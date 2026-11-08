"""
обработка результатов: таблица метрик и графики.
  python3 scripts/analyze.py
читает results/<сценарий>/result.jtl (сырые данные jmeter) и метрики из prometheus,
пишет results/summary.md, results/summary.csv и картинки в ../ответ/фото/
"""
import json
from pathlib import Path

import matplotlib
import numpy as np
import pandas as pd
import requests

matplotlib.use("Agg")
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parent.parent
RES = ROOT / "results"
IMG = ROOT.parent / "ответ" / "фото"
IMG.mkdir(parents=True, exist_ok=True)
PROM = "http://localhost:9090/api/v1/query_range"

SCEN = ["nocache", "cache", "redis-stop", "redis-flush"]
NAMES = {"nocache": "без кэша", "cache": "с кэшем", "redis-stop": "redis выключен", "redis-flush": "FLUSHALL"}
# цвета закреплены за сценарием, а не за порядком на графике
COL = {"nocache": "#2a78d6", "cache": "#eb6834", "redis-stop": "#1baf7a", "redis-flush": "#c98500"}
INK, INK2, GRID = "#0b0b0b", "#52514e", "#e4e3df"

plt.rcParams.update({
    "figure.facecolor": "#fcfcfb", "axes.facecolor": "#fcfcfb", "savefig.facecolor": "#fcfcfb",
    "axes.edgecolor": GRID, "axes.labelcolor": INK2, "xtick.color": INK2, "ytick.color": INK2,
    "text.color": INK, "axes.grid": True, "grid.color": GRID, "grid.linewidth": 0.8,
    "axes.spines.top": False, "axes.spines.right": False, "lines.linewidth": 2,
    "font.size": 11, "axes.titlesize": 12, "axes.titleweight": "bold", "legend.frameon": False,
})

# метрики сервера, базы и кэша из prometheus (шаг 1 с)
PROM_Q = {
    "pg_cpu": 'sum(rate(container_cpu_usage_seconds_total{name="lab2-postgres"}[5s]))',
    "redis_cpu": 'sum(rate(container_cpu_usage_seconds_total{name="lab2-redis"}[5s]))',
    "pg_tps": 'sum(rate(pg_stat_database_xact_commit{datname="lab2"}[5s]))',
    "db_qps": "sum(rate(users_db_query_seconds_count[5s]))",
    "pool_wait": "sum(hikaricp_connections_pending)",
    "hit_ratio": 'sum(rate(users_cache_total{result="hit"}[5s])) / sum(rate(users_cache_total[5s]))',
    "app_cpu": "process_cpu_usage * system_cpu_count",
}


def load(s):
    meta = json.loads((RES / s / "meta.json").read_text())
    d = pd.read_csv(RES / s / "result.jtl", usecols=["timeStamp", "elapsed", "success"],
                    dtype={"timeStamp": "int64", "elapsed": "int32", "success": "bool"})
    d["t"] = (d.timeStamp - meta["start_ms"]) / 1000.0  # секунды от старта нагрузки
    d["sec"] = d.t.astype(int)
    for k in ("event1_ms", "event2_ms"):
        meta[k] = (int(meta[k]) - meta["start_ms"]) / 1000.0 if meta[k] else None
    return meta, d


def prom(meta):
    out = {}
    for k, q in PROM_Q.items():
        r = requests.get(PROM, params={"query": q, "start": meta["start_ms"] / 1000,
                                       "end": meta["end_ms"] / 1000, "step": "1"}).json()
        res = r["data"]["result"]
        if res:
            v = np.array(res[0]["values"], dtype=float)
            out[k] = pd.Series(v[:, 1], index=v[:, 0] - meta["start_ms"] / 1000)
        else:
            out[k] = pd.Series(dtype=float)
    return pd.DataFrame(out)


def stats(d, pm, a, b, scen, phase):
    """метрики за отрезок [a, b) секунд"""
    x = d[(d.t >= a) & (d.t < b)]
    p = pm[(pm.index >= a) & (pm.index < b)]
    el = x.elapsed.to_numpy()
    return {
        "сценарий": NAMES[scen], "фаза": phase, "длит., с": round(b - a),
        "запросов": len(x), "RPS": len(x) / (b - a),
        "mean, мс": el.mean(), "p50, мс": np.percentile(el, 50), "p90, мс": np.percentile(el, 90),
        "p95, мс": np.percentile(el, 95), "p99, мс": np.percentile(el, 99),
        "p99.9, мс": np.percentile(el, 99.9), "max, мс": el.max(),
        "ошибки, %": 100 * (~x.success).mean(),
        "hit ratio, %": 100 * p.hit_ratio.mean() if p.hit_ratio.notna().any() else np.nan,
        "CPU postgres (ядер)": p.pg_cpu.mean(), "CPU postgres max": p.pg_cpu.max(),
        "TPS postgres": p.pg_tps.mean(), "TPS postgres max": p.pg_tps.max(),
        "ждут соединение (ср.)": p.pool_wait.mean(),
        "CPU redis (ядер)": p.redis_cpu.mean(), "CPU сервиса (ядер)": p.app_cpu.mean(),
    }


def per_second(d):
    g = d.groupby("sec").elapsed
    ps = pd.DataFrame({"rps": g.size(), "p50": g.median(), "p99": g.quantile(0.99)})
    return ps.iloc[:-1]  # последняя секунда неполная


def recovery(ps, ev, base_rps):
    """через сколько секунд после события rps вернулся к 90% от прежнего и держится 5 секунд"""
    after = ps[ps.index >= ev].rps
    ok = (after >= 0.9 * base_rps).astype(int).rolling(5).sum() == 5
    hit = ok[ok]
    return (hit.index[0] - 4 - ev) if len(hit) else np.nan


rows, extra, data = [], [], {}
for s in SCEN:
    if not (RES / s / "meta.json").exists():
        print("нет результатов для", s)
        continue
    meta, d = load(s)
    pm = prom(meta)
    ps = per_second(d)
    data[s] = (meta, d, pm, ps)
    T0, T1, E1, E2 = meta["rampup"], meta["duration"], meta["event1_ms"], meta["event2_ms"]
    print(s, len(d), "запросов")

    if s in ("nocache", "cache"):
        rows.append(stats(d, pm, T0, T1, s, "весь прогон без разгона"))
    elif s == "redis-stop":
        rows.append(stats(d, pm, T0, E1, s, "до отказа (кэш работает)"))
        rows.append(stats(d, pm, E1, E2, s, "redis выключен"))
        rows.append(stats(d, pm, E2, T1, s, "после включения"))
    else:
        rows.append(stats(d, pm, T0, E1, s, "до FLUSHALL"))
        rows.append(stats(d, pm, E1, E1 + 30, s, "30 с после FLUSHALL #1"))
        rows.append(stats(d, pm, E2, E2 + 30, s, "30 с после FLUSHALL #2"))
        rows.append(stats(d, pm, T0, T1, s, "весь прогон без разгона"))

    # время восстановления и всплеск нагрузки на базу
    if E1 is not None:
        base = ps[(ps.index >= E1 - 60) & (ps.index < E1)].rps.median()
        db_before = pm[(pm.index >= E1 - 60) & (pm.index < E1)].db_qps.mean()
        for i, ev in enumerate([E1, E2], 1):
            label = {"redis-stop": ["docker stop redis", "docker start redis"],
                     "redis-flush": ["FLUSHALL #1", "FLUSHALL #2"]}[s][i - 1]
            win = pm[(pm.index >= ev) & (pm.index < ev + 60)]
            extra.append({
                "сценарий": NAMES[s], "событие": label,
                "RPS до события (медиана)": base,
                "мин. RPS за 1 с": ps[(ps.index >= ev) & (ps.index < ev + 60)].rps.min(),
                "макс. p99 за 1 с, мс": ps[(ps.index >= ev) & (ps.index < ev + 60)].p99.max(),
                "запросов в базу/с до": db_before, "пик запросов в базу/с": win.db_qps.max(),
                "пик CPU postgres": win.pg_cpu.max(),
                "восстановление RPS, с": recovery(ps, ev, base) if not (s == "redis-stop" and i == 1) else np.nan,
            })

def to_md(df, digits):
    """таблица в markdown без лишних зависимостей"""
    def f(v):
        if isinstance(v, (float, np.floating)):
            return "—" if np.isnan(v) else f"{v:.{digits}f}"
        return str(v)
    lines = ["| " + " | ".join(df.columns) + " |", "|" + "---|" * len(df.columns)]
    lines += ["| " + " | ".join(f(v) for v in r) + " |" for r in df.itertuples(index=False)]
    return "\n".join(lines)


summary = pd.DataFrame(rows)
events = pd.DataFrame(extra)
summary.to_csv(RES / "summary.csv", index=False)
events.to_csv(RES / "events.csv", index=False)
with open(RES / "summary.md", "w") as f:
    f.write(to_md(summary, 2) + "\n\n")
    f.write(to_md(events, 1) + "\n")
print(summary.to_string())
print(events.to_string())

# ---------- 1. распределение задержек по перцентилям ----------
P = np.array([25, 50, 75, 90, 95, 99, 99.5, 99.9, 99.95, 99.99])
X = -np.log10(1 - np.minimum(P, 99.999) / 100)   # ось "сколько девяток"
curves = []
for s in SCEN:
    if s not in data:
        continue
    meta, d, *_ = data[s]
    if s == "redis-stop":
        x = d[(d.t >= meta["event1_ms"]) & (d.t < meta["event2_ms"])].elapsed
        lab = "redis выключен (3 мин отказа)"
    elif s == "redis-flush":
        x = d[d.t >= meta["rampup"]].elapsed
        lab = "FLUSHALL (весь прогон, 2 очистки)"
    else:
        x = d[d.t >= meta["rampup"]].elapsed
        lab = NAMES[s]
    curves.append((s, lab, np.percentile(x, P)))

fig, ax = plt.subplots(figsize=(10, 5.5))
for s, lab, y in curves:
    ax.plot(X, y, color=COL[s], marker="o", markersize=5, label=lab)
    ax.annotate(f"{y[-1]:.0f} мс", (X[-1], y[-1]), xytext=(6, 0), textcoords="offset points",
                va="center", color=INK2, fontsize=10)
ax.set_yscale("log")
ax.set_xticks(X)
ax.set_xticklabels([f"{p:g}%" for p in P], rotation=45)
ax.set_xlabel("перцентиль (доля запросов, которые уложились в это время)")
ax.set_ylabel("задержка, мс (лог. шкала)")
ax.set_title("Распределение задержек по перцентилям (200 пользователей, JMeter)")
ax.yaxis.set_major_locator(matplotlib.ticker.LogLocator(subs=(1, 2, 5)))
ax.yaxis.set_major_formatter(matplotlib.ticker.FuncFormatter(lambda v, _: f"{v:g}"))
ax.yaxis.set_minor_formatter(matplotlib.ticker.NullFormatter())
ax.legend(loc="upper left")
fig.tight_layout()
fig.savefig(IMG / "percentiles.png", dpi=150)

# ---------- 2. до / после: rps и перцентили ----------
base_rows = summary[summary["фаза"] == "весь прогон без разгона"].set_index("сценарий").loc[["без кэша", "с кэшем"]]
fig, (a1, a2) = plt.subplots(1, 2, figsize=(11, 4.5), gridspec_kw={"width_ratios": [1, 2]})
bars = a1.bar(base_rows.index, base_rows.RPS, color=[COL["nocache"], COL["cache"]], width=0.55)
a1.bar_label(bars, labels=[f"{v:,.0f}".replace(",", " ") for v in base_rows.RPS], padding=3, color=INK)
a1.set_title("Пропускная способность, запросов/с")
a1.grid(axis="x", visible=False)
cols = ["p50, мс", "p90, мс", "p95, мс", "p99, мс", "p99.9, мс"]
xx = np.arange(len(cols))
for i, s in enumerate(["nocache", "cache"]):
    v = base_rows.loc[NAMES[s], cols].to_numpy(dtype=float)
    b = a2.bar(xx + (i - 0.5) * 0.36, v, width=0.34, color=COL[s], label=NAMES[s])
    a2.bar_label(b, labels=[f"{x:g}" for x in v], padding=2, fontsize=9, color=INK2)
a2.set_xticks(xx)
a2.set_xticklabels([c.replace(", мс", "") for c in cols])
a2.set_title("Задержка, мс")
a2.legend()
a2.grid(axis="x", visible=False)
fig.tight_layout()
fig.savefig(IMG / "before_after.png", dpi=150)


# ---------- 3. отказ кэша во времени ----------
def timeline(s, fname, title, zoom=None):
    meta, d, pm, ps = data[s]
    if zoom:
        ps = ps[(ps.index >= zoom[0]) & (ps.index <= zoom[1])]
        pm = pm[(pm.index >= zoom[0]) & (pm.index <= zoom[1])]
    fig, ax = plt.subplots(4, 1, figsize=(11, 11), sharex=True)
    ax[0].plot(ps.index, ps.rps, color=COL[s])
    ax[0].set_title("Пропускная способность (по данным JMeter), запросов/с")
    ax[1].plot(ps.index, ps.p50, color="#2a78d6", label="p50")
    ax[1].plot(ps.index, ps.p99, color="#eb6834", label="p99")
    ax[1].set_yscale("log")
    ax[1].yaxis.set_major_locator(matplotlib.ticker.LogLocator(subs=(1, 2, 5)))
    ax[1].yaxis.set_major_formatter(matplotlib.ticker.FuncFormatter(lambda v, _: f"{v:g}"))
    ax[1].yaxis.set_minor_formatter(matplotlib.ticker.NullFormatter())
    ax[1].set_title("Задержка за каждую секунду, мс (лог. шкала)")
    ax[1].legend(loc="upper left")
    ax[2].plot(pm.index, pm.pg_cpu, color=COL["nocache"])
    ax[2].axhline(1.0, color=INK2, linestyle=":", linewidth=1)
    ax[2].text(pm.index.min(), 1.0, " лимит контейнера = 1 ядро", va="bottom", color=INK2, fontsize=9)
    ax[2].set_ylim(0, 1.15)
    ax[2].set_title("CPU postgres, ядер")
    ax[3].plot(pm.index, pm.db_qps, color=COL["nocache"])
    ax[3].set_title("Запросов в postgres от сервиса, в секунду")
    ax[3].set_xlabel("секунды от начала нагрузки")
    labels = {"redis-stop": ["docker stop redis", "docker start redis"],
              "redis-flush": ["FLUSHALL #1", "FLUSHALL #2"]}[s]
    for ev, lab in zip([meta["event1_ms"], meta["event2_ms"]], labels):
        if zoom and not (zoom[0] <= ev <= zoom[1]):
            continue
        for a in ax:
            a.axvline(ev, color=INK2, linestyle="--", linewidth=1)
        ax[0].text(ev, ax[0].get_ylim()[1], f" {lab}", va="top", color=INK, fontsize=10)
    fig.suptitle(title, fontweight="bold")
    fig.tight_layout()
    fig.savefig(IMG / fname, dpi=150)


if "redis-stop" in data:
    timeline("redis-stop", "timeline_redis_stop.png", "Отказ кэша: redis выключен на 3 минуты")
    e2 = data["redis-stop"][0]["event2_ms"]
    timeline("redis-stop", "zoom_redis_start.png", "Крупно: redis снова включён (пустой)", zoom=(e2 - 15, e2 + 45))
if "redis-flush" in data:
    timeline("redis-flush", "timeline_redis_flush.png", "Отказ кэша: FLUSHALL на 3-й и 6-й минуте")
    e1 = data["redis-flush"][0]["event1_ms"]
    timeline("redis-flush", "zoom_flush.png", "Крупно: первые секунды после FLUSHALL #1", zoom=(e1 - 15, e1 + 45))
print("картинки:", IMG)
