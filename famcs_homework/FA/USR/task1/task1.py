import os
import numpy as np
import matplotlib.pyplot as plt

def solve_nonlinear_equation():
    """
    Решает нелинейное уравнение x^5 + 2x^3 + x - 2 = 0 методом
    последовательных приближений после сужения интервала локализации корня.
    """
    # --- Параметры задачи ---
    k1 = 5.1405
    k2 = 6.888
    LAMBDA = 2 / (k1 + k2)
    ALPHA = (k2 - k1) / (k1 + k2)
    
    EPSILON = 1e-4
    X0 = 0.75
    
    # --- Настройки вывода ---
    OUTPUT_DIR = "task1/results"
    REPORT_FILE = "report.txt"
    PLOT_FILE = "plot.png"

    # --- Подготовка директории ---
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
    report_path = os.path.join(OUTPUT_DIR, REPORT_FILE)
    plot_path = os.path.join(OUTPUT_DIR, PLOT_FILE)

    # --- Определение функций ---
    def g(x: float) -> float:
        return x**5 + 2*x**3 + x - 2

    def f(x: float) -> float:
        return x - LAMBDA * g(x)

    # --- Априорная оценка ---
    x1 = f(X0)
    diff_x0_x1 = abs(X0 - x1)
    n_apr = int(np.log(EPSILON * (1 - ALPHA) / diff_x0_x1) / np.log(ALPHA)) + 1

    # --- Итерационный процесс ---
    x_prev = X0
    stop_threshold = EPSILON * (1 - ALPHA) / ALPHA
    
    for i in range(1, n_apr):
        x_curr = f(x_prev)
        if abs(x_curr - x_prev) < stop_threshold:
            iterations_needed = i
            break
        x_prev = x_curr
    else:
        iterations_needed = i

    # --- Сохранение отчета ---
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("="*50 + "\n")
        f.write("ЗАДАЧА 1\n")
        f.write("="*50 + "\n\n")
        f.write(f"Уравнение: x^5 + 2x^3 + x - 2 = 0\n")
        f.write(f"Точность epsilon: {EPSILON}\n\n")
        f.write("--- Параметры метода ---\n")
        f.write(f"lambda = {LAMBDA:.6f}\n")
        f.write(f"Коэффициент сжатия alpha на [0.7, 0.8]: {ALPHA:.6f}\n")
        f.write(f"Начальное приближение x0: {X0}\n")
        f.write(f"Априорная оценка n_apr: {n_apr} итераций\n\n")
        f.write("--- Результат ---\n")
        f.write(f"Найденный корень x*: {x_curr:.6f}\n")
        f.write(f"Фактическое число итераций: {iterations_needed}\n")

if __name__ == "__main__":
    solve_nonlinear_equation()