import os
import numpy as np

def solve_slae():
    """
    Решает мой вариант СЛАУ методом последовательных приближений.
    """
    # --- Параметры задачи ---
    # Матрица C и вектор D после приведения к виду X = CX + D
    C = np.array([
        [0, 0.2, 0.15, -0.1],
        [0.2, 0, -0.2, 0.2],
        [-0.375, -0.375, 0, 0.125],
        [0.3, -0.2, 0.1, 0]
    ])
    
    D = np.array([1.45, 1.6, 3.625, 3.8])
    
    EPSILON = 1e-4
    X0 = np.zeros(4)

    # --- Настройки вывода ---
    OUTPUT_DIR = "task2/results"
    REPORT_FILE = "report.txt"

    # --- Подготовка директории ---
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
    report_path = os.path.join(OUTPUT_DIR, REPORT_FILE)

    # ---  Подсчет коэффициента сжатия и априорной оценки ---
    # кубическая норма
    alpha = np.max(np.sum(np.abs(C), axis=1))
    
    x1 = C @ X0 + D
    diff_x0_x1_norm = np.linalg.norm(X0 - x1, ord=np.inf)
    
    n_apr = int(np.log(EPSILON * (1 - alpha) / diff_x0_x1_norm) / np.log(alpha)) + 1

    # --- Итерационный процесс ---
    x_prev = X0
    stop_threshold = EPSILON * (1 - alpha) / alpha
    
    for i in range(1, n_apr):
        x_curr = C @ x_prev + D
        if np.linalg.norm(x_curr - x_prev, ord=np.inf) < stop_threshold:
            iterations_needed = i
            break
        x_prev = x_curr
    else:
        iterations_needed = i

    # --- Сохранение отчета ---
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("="*50 + "\n")
        f.write("ЗАДАЧА 2\n")
        f.write("="*50 + "\n\n")
        f.write(f"Точность epsilon: {EPSILON}\n\n")
        f.write("--- Параметры метода ---\n")
        f.write(f"Коэффициент сжатия alpha (кубическая норма): {alpha:.6f}\n")
        f.write(f"Начальное приближение X0: {X0}\n")
        f.write(f"Априорная оценка n_apr: {n_apr} итераций\n\n")
        f.write("--- Результат ---\n")
        f.write(f"Найденное решение X*:\n")
        f.write(f"  x1 = {x_curr[0]:.6f}\n")
        f.write(f"  x2 = {x_curr[1]:.6f}\n")
        f.write(f"  x3 = {x_curr[2]:.6f}\n")
        f.write(f"  x4 = {x_curr[3]:.6f}\n\n")
        f.write(f"Фактическое число итераций: {iterations_needed}\n")

if __name__ == "__main__":
    solve_slae()