import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from scipy.optimize import root_scalar
from matplotlib.widgets import TextBox

# --- Параметры задачи ---
L = 1.0
h = 1.0
a = 4.0
N_terms = 50

# --- Глобальные переменные управления ---
current_t = 0.0    # Текущее время
DT = 0.02          # Шаг времени
is_paused = False  # Состояние паузы

# --- Решение уравнения для собственных значений ---
def equation(mu):
    return np.sin(mu) + (mu / (h * L)) * np.cos(mu)

mu_roots = []
for n in range(1, N_terms + 1):
    left = np.pi/2 + np.pi*(n-1) + 1e-5
    right = np.pi + np.pi*(n-1)
    sol = root_scalar(equation, bracket=[left, right], method='brentq')
    mu_roots.append(sol.root)

mu = np.array(mu_roots)

# --- Коэффициенты ряда ---
norm_sq = (L / 2) * (1 - np.sin(2 * mu) / (2 * mu))
A_n = (L * (1 - np.cos(mu))) / (mu * norm_sq)
B_n = (L**3 / (4 * mu**2 * norm_sq)) * (np.sin(mu) / mu - np.cos(mu))

def u(x, t):
    result = np.zeros_like(x)
    for i in range(N_terms):
        m = mu[i]
        T_n = A_n[i] * np.cos(4 * m * t / L) + B_n[i] * np.sin(4 * m * t / L)
        X_n = np.sin(m * x / L)
        result += T_n * X_n
    return result

# --- Настройка графиков ---
fig, ax = plt.subplots(figsize=(8, 6))
plt.subplots_adjust(bottom=0.25) # Освобождаем место снизу для поля ввода

x_vals = np.linspace(0, L, 200)
line, = ax.plot(x_vals, u(x_vals, current_t), color='red', lw=2)

ax.set_xlim(0, L)
ax.set_ylim(-2.5, 2.5)
ax.set_xlabel("Координата x")
ax.set_ylabel("Отклонение u(x,t)")
ax.grid(True, linestyle='--', alpha=0.7)

def update_title():
    state = "ПАУЗА" if is_paused else "ИДЕТ"
    ax.set_title(f"t = {current_t:.2f} [{state}]\n(Клик - пауза, Enter в поле - переход)")

# --- Логика виджетов ---
# Создаем область для текстового поля [left, bottom, width, height]
ax_box = plt.axes([0.35, 0.05, 0.3, 0.075])
text_box = TextBox(ax_box, 'Задать время t: ', initial="0.0")

def set_time(text):
    global current_t, is_paused
    try:
        new_t = float(text)
        current_t = new_t
        # Обновляем график сразу
        line.set_ydata(u(x_vals, current_t))
        update_title()
        fig.canvas.draw_idle()
    except ValueError:
        print("Ошибка: введите числовое значение")

text_box.on_submit(set_time)

# --- Логика анимации ---
def animate(frame):
    global current_t
    if not is_paused:
        current_t += DT
        line.set_ydata(u(x_vals, current_t))
        update_title()
    return line,

def toggle_pause(event):
    global is_paused
    # Проверяем, что клик был не в поле ввода
    if event.inaxes == ax:
        is_paused = not is_paused
        update_title()

fig.canvas.mpl_connect('button_press_event', toggle_pause)

# interval=20 (примерно 50 кадров в секунду)
ani = animation.FuncAnimation(fig, animate, interval=20, blit=False, cache_frame_data=False)

print("Инструкция:")
print("1. Введите число в поле 'Задать время t' и нажмите ENTER для прыжка во времени.")
print("2. Кликните по самому графику, чтобы остановить/запустить время.")

plt.show()