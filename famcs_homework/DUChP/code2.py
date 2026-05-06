import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from matplotlib.widgets import TextBox

# --- Параметры ---
L = np.pi / 2  # Длина
N_terms = 50   # Количество членов ряда

# --- Глобальные переменные управления ---
current_t = 0.0    # Текущее время
DT = 0.03          # Шаг времени (скорость анимации)
is_paused = False  # Состояние паузы

# --- Предварительный расчет коэффициентов ---
A0 = 6 / np.pi
B0 = 10 / np.pi

k_vals = np.arange(1, N_terms + 1)
wk = 2 * np.sqrt(k_vals * (k_vals + 1)) # Частоты omega_k

Ak = np.zeros(N_terms)
Bk = np.zeros(N_terms)

for i, k in enumerate(k_vals):
    term1 = (-1)**k / (2*k + 1)**2
    term2 = (1 + (-1)**k) / (4 * (k + 1))
    term3 = (1 - (-1)**k) / (4 * k)
    Ak[i] = (4 / np.pi) * (term1 + term2 + term3)
    Bk[i] = (1 / wk[i]) * (Ak[i] + 4 / (np.pi * (2*k + 1)))

# --- Функция u(x, t) ---
def u(x, t):
    # k = 0
    result = (A0 + B0 * t) * np.exp(-t) * np.sin(x)
    
    # k >= 1
    for i, k in enumerate(k_vals):
        T_k = np.exp(-t) * (Ak[i] * np.cos(wk[i] * t) + Bk[i] * np.sin(wk[i] * t))
        X_k = np.sin((2*k + 1) * x)
        result += T_k * X_k
    return result

# --- Настройка визуализации ---
fig, ax = plt.subplots(figsize=(8, 6))
plt.subplots_adjust(bottom=0.25) # Место для текстового поля

x_vals = np.linspace(0, L, 200)
line, = ax.plot(x_vals, u(x_vals, current_t), color='blue', lw=2)

ax.set_xlim(0, L)
ax.set_ylim(-1.5, 2.5)
ax.set_xlabel("Координата x")
ax.set_ylabel("Отклонение u(x,t)")
ax.grid(True, linestyle='--', alpha=0.7)

def update_ui():
    state = "ПАУЗА" if is_paused else "ИДЕТ"
    ax.set_title(f"Задача 11.30 (Затухание) | t = {current_t:.2f}\n[{state}] Клик по графику — пауза")

# --- Логика виджета (Поле ввода времени) ---
ax_box = plt.axes([0.35, 0.05, 0.3, 0.06])
text_box = TextBox(ax_box, 'Задать время t: ', initial="0.0")

def set_time(text):
    global current_t
    try:
        new_t = float(text)
        current_t = new_t
        line.set_ydata(u(x_vals, current_t))
        update_ui()
        fig.canvas.draw_idle()
    except ValueError:
        print("Введите корректное число")

text_box.on_submit(set_time)

# --- Логика анимации и паузы ---
def animate(frame):
    global current_t
    if not is_paused:
        current_t += DT
        line.set_ydata(u(x_vals, current_t))
        update_ui()
    return line,

def toggle_pause(event):
    global is_paused
    # Если кликнули внутри основного графика (а не в поле ввода)
    if event.inaxes == ax:
        is_paused = not is_paused
        update_ui()
        fig.canvas.draw_idle()

# Привязываем клик мыши
fig.canvas.mpl_connect('button_press_event', toggle_pause)

# Запуск анимации
# blit=False важен, чтобы заголовок (title) обновлялся корректно
ani = animation.FuncAnimation(fig, animate, interval=30, blit=False, cache_frame_data=False)

print("Управление:")
print("- Введите время в поле внизу и нажмите Enter.")
print("- Кликните по графику, чтобы остановить или запустить время.")

plt.show()