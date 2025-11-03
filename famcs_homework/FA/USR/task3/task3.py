import os
import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import simpson # Импортируем именно метод Симпсона

def solve_integral_equation_simpson():
    """
    Решает интегральное уравнение Фредгольма методом последовательных
    приближений с использованием численного интегрирования по формуле Симпсона.
    """
    # --- Параметры задачи ---
    LAMBDA = 1.0
    EPSILON = 1e-3
    SIMPSON_STEP = 0.05
    
    # --- Настройки вывода ---
    OUTPUT_DIR = "task3/results"
    REPORT_FILE = "report.txt"
    PLOT_FILE = "plot.png"

    # --- Подготовка директории ---
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
    report_path = os.path.join(OUTPUT_DIR, REPORT_FILE)
    plot_path = os.path.join(OUTPUT_DIR, PLOT_FILE)

    # --- Определение функций ---
    def y(t):
        return np.sqrt(np.maximum(0, 1 - t))

    def K(t, s):
        return t * np.sqrt(np.maximum(0, 1 - s))

    def x_exact(t):
        return y(t) + (15 * LAMBDA / (30 - 8 * LAMBDA)) * t

    s_points = np.arange(0, 1 + SIMPSON_STEP, SIMPSON_STEP)
    t_points = np.linspace(0, 1, 21)

    # --- Начальное приближение ---
    x_prev = y(t_points)

    # --- Параметры сходимости  ---
    alpha = (2/3) * abs(LAMBDA)
    x0_norm_diff = abs(LAMBDA) / 2
    n_apr = int(np.log(EPSILON * (1 - alpha) / x0_norm_diff) / np.log(alpha)) + 1
    
    # --- Итерационный процесс ---
    for i in range(1, n_apr + 5):
        x_curr = np.zeros_like(t_points)
    
        for j, t_j in enumerate(t_points):
            # Подынтегральная функция для метода Симпсона
            integrand_values = K(t_j, s_points) * np.interp(s_points, t_points, x_prev)
            
            # Вычисление интеграла по формуле Симпсона
            integral_val = simpson(y=integrand_values, x=s_points)
            x_curr[j] = y(t_j) + LAMBDA * integral_val
        error_norm = np.max(np.abs(x_curr - x_prev))
        if error_norm < EPSILON:
            iterations_needed = i
            break
        x_prev = x_curr
    else:
        iterations_needed = i

    # --- Построение финальных функций для гладкого графика ---
    t_fine = np.linspace(0, 1, 101)
    x_curr_fine = np.interp(t_fine, t_points, x_curr)
    x_exact_fine = x_exact(t_fine)

    # --- Сохранение отчета ---
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("="*50 + "\n")
        f.write("ЗАДАЧА 3\n")
        f.write("="*50 + "\n\n")
        f.write("--- Условия сходимости ---\n")
        f.write("В пространстве C[0, 1]: |lambda| < 1.5\n")
        f.write("В пространстве L2[0, 1]: |lambda| < sqrt(6) approx 2.449\n\n")
        f.write(f"Выбрано значение lambda = {LAMBDA}\n")
        f.write(f"Коэффициент сжатия alpha в C[0,1]: {alpha:.6f}\n")
        f.write(f"Априорная оценка n_apr: {n_apr} итераций\n\n")
        f.write("--- Приближенное решение ---\n")
        f.write(f"Найдено за {iterations_needed} итераций с точностью {EPSILON}.\n")
        f.write(f"Апостериорная погрешность (норма разности): {error_norm:.6f}\n")
        f.write(f"Значения в узловых точках:\n")
        f.write(f"  t=0.0: x_approx={x_curr[0]:.4f}, x_exact={x_exact(0.0):.4f}\n")
        f.write(f"  t=0.5: x_approx={np.interp(0.5, t_points, x_curr):.4f}, x_exact={x_exact(0.5):.4f}\n")
        f.write(f"  t=1.0: x_approx={x_curr[-1]:.4f}, x_exact={x_exact(1.0):.4f}\n")

    # --- Построение графика ---
    plt.style.use('seaborn-v0_8-whitegrid')
    fig, ax = plt.subplots(figsize=(12, 7))
    
    ax.plot(t_fine, x_exact_fine, 'r-', label='Точное решение', linewidth=2)
    ax.plot(t_fine, x_curr_fine, 'b--', label=f'Приближенное решение (N={iterations_needed})', linewidth=2)
    
    ax.set_xlabel('t', fontsize=12)
    ax.set_ylabel('x(t)', fontsize=12)
    ax.set_title('Сравнение точного и приближенного решений', fontsize=14)
    ax.legend()
    ax.grid(True, which="both", ls="--")
    plt.tight_layout()
    plt.savefig(plot_path, dpi=300)
    plt.close()

if __name__ == "__main__":
    solve_integral_equation_simpson()