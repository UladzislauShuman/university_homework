import numpy as np
import matplotlib.pyplot as plt
import os

from jacobi import jacobi_method
from gauss_seidel import gauss_seidel_method

def main():

    OUTPUT_DIR = "task1_results"
    REPORT_FILE = "report.txt"
    PLOT_FILE = "plot.png"

    A = np.array([
        [4., -5., 5.],
        [5., -4., 0.],
        [-1., -5., 4.]
    ])

    x_true = np.array([7., 5., 8.])
    b = np.array([43., 15., 0.])

    x0 = np.zeros_like(b)

    max_iterations = 100

    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
    
    report_path = os.path.join(OUTPUT_DIR, REPORT_FILE)
    plot_path = os.path.join(OUTPUT_DIR, PLOT_FILE)

    print("="*60)
    print("Начало эксперимента по исследованию итерационных методов")
    print(f"Решаемая система: A*x = b, где b = {b.tolist()}")
    print(f"Ожидаемое решение: x_true = {x_true.tolist()}")
    print(f"Результаты будут сохранены в папку: {OUTPUT_DIR}")
    print("="*60)

    x_jacobi, jacobi_residuals = jacobi_method(A, b, x0, max_iterations)
    x_gauss_seidel, gs_residuals = gauss_seidel_method(A, b, x0, max_iterations)

    print("Расчеты завершены. Идет сохранение результатов...")

    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("="*70 + "\n")
        f.write("Отчет\n")
        f.write("="*70 + "\n\n")
        f.write(f"Решаемая система для матрицы A:\n{A}\n\n")
        f.write(f"Вектор правой части b = {b.tolist()}\n")
        f.write(f"Ожидаемое точное решение x* = {x_true.tolist()}\n")
        f.write(f"Максимальное количество итераций: {max_iterations}\n\n")
        
        f.write("-" * 30 + "\n")
        f.write("Метод Якоби\n")
        f.write("-" * 30 + "\n")
        f.write(f" - Конечное решение: {x_jacobi}\n")
        f.write(f" - Норма невязки на последней итерации: {jacobi_residuals[-1]:.4e}\n")
        
        f.write("-" * 30 + "\n")
        f.write("Метод Гаусса-Зейделя\n")
        f.write("-" * 30 + "\n")
        f.write(f" - Конечное решение: {x_gauss_seidel}\n")
        f.write(f" - Норма невязки на последней итерации: {gs_residuals[-1]:.4e}\n")
        f.write("="*70 + "\n")

    print(f"-> Текстовый отчет успешно сохранен в: {report_path}")
    plt.style.use('seaborn-v0_8-whitegrid')
    plt.figure(figsize=(12, 8))

    plt.plot(range(max_iterations), jacobi_residuals, marker='o', linestyle='--', label='Метод Якоби')
    plt.plot(range(max_iterations), gs_residuals, marker='x', linestyle='-', label='Метод Гаусса-Зейделя')

    plt.yscale('log')
    plt.xlabel('Номер итерации, k', fontsize=14)
    plt.ylabel('Норма невязки ||Ax^k - b|| (log-шкала)', fontsize=14)
    plt.title('Диаграмма сходимости методов', fontsize=16)
    plt.xticks(range(0, max_iterations + 1, 2))
    plt.legend(fontsize=12)
    plt.grid(True, which="both", ls="--")

    plt.savefig(plot_path, dpi=300)
    print(f"-> График успешно сохранен в: {plot_path}")
    print("="*60)

    plt.show()


if __name__ == "__main__":
    main()