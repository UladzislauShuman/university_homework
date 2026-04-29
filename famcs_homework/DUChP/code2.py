import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation

# --- Параметры ---
L = np.pi / 2  # Длина
N_terms = 50   # Количество членов ряда

# Коэффициенты для k = 0
A0 = 6 / np.pi
B0 = 10 / np.pi

# Массивы для k >= 1
k_vals = np.arange(1, N_terms + 1)
wk = 2 * np.sqrt(k_vals * (k_vals + 1)) # Частоты omega_k

Ak = np.zeros(N_terms)
Bk = np.zeros(N_terms)

for i, k in enumerate(k_vals):
    # Ak
    term1 = (-1)**k / (2*k + 1)**2
    term2 = (1 + (-1)**k) / (4 * (k + 1))
    term3 = (1 - (-1)**k) / (4 * k)
    Ak[i] = (4 / np.pi) * (term1 + term2 + term3)
    
    # Bk
    Bk[i] = (1 / wk[i]) * (Ak[i] + 4 / (np.pi * (2*k + 1)))

# --- u(x, t) ---
def u(x, t):
    result = (A0 + B0 * t) * np.exp(-t) * np.sin(x)
    
    # остальные
    for i, k in enumerate(k_vals):
        T_k = np.exp(-t) * (Ak[i] * np.cos(wk[i] * t) + Bk[i] * np.sin(wk[i] * t))
        X_k = np.sin((2*k + 1) * x)
        result += T_k * X_k
        
    return result

# анимация
fig, ax = plt.subplots(figsize=(8, 5))
x_vals = np.linspace(0, L, 200)
line, = ax.plot(x_vals, u(x_vals, 0), color='blue', lw=2)

ax.set_xlim(0, L)
ax.set_ylim(-1.5, 2.5)
ax.set_title("Колебание струны с затуханием (Задача 11.30)")
ax.set_xlabel("Координата x")
ax.set_ylabel("Отклонение u(x,t)")
ax.grid(True, linestyle='--', alpha=0.7)

# для обновления кадра
def animate(frame):
    t = frame * 0.05
    line.set_ydata(u(x_vals, t))
    ax.set_title(f"Колебание струны с затуханием | Время t = {t:.2f}")
    return line,

ani = animation.FuncAnimation(fig, animate, frames=200, interval=30, blit=True)

plt.show()