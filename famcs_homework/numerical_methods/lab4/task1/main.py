import numpy as np
import os
import sys

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from data import get_matrices
from inverse_power import inverse_power_method_with_shift

def main():
    OUTPUT_DIR = "task1_results"
    REPORT_FILE = "report_8_1.txt"
    EPSILON = 1e-6 
    MU = 0.0 
    
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
        
    report_path = os.path.join(OUTPUT_DIR, REPORT_FILE)
    matrices = get_matrices()
    
    print("="*70)
    print("Задание 8.1")
    print("Формирование отчета...")
    print("="*70)
    
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("ОТЧЕТ ПО ЗАДАНИЮ 8.1\n")
        f.write(f"Метод: Обратная итерация со сдвигом (mu={MU})\n")
        f.write("="*40 + "\n\n")

        for name, matrix in matrices.items():
            print(f"Обработка: {name}...")
            
            lambda_eigenvalue, eigenvector, iterations_amount, residual_norm = inverse_power_method_with_shift(
                matrix, mu=MU, epsilon=EPSILON
            )
            
            matrix_str = str(matrix).replace('\n', '\n\t')
            eigenvector_str = np.array2string(eigenvector, precision=4, separator=', ', suppress_small=True)
            
            residual_vector = matrix @ eigenvector - lambda_eigenvalue * eigenvector
            residual_vector_str = np.array2string(residual_vector, precision=2, formatter={'float_kind':lambda x: f"{x:.2e}"})

            block = (
                f"--- {name} ---\n"
                f"Исходная матрица:\n\t{matrix_str}\n\n"
                f"Результаты вычислений:\n"
                f"  Собственное значение (min |λ|): {lambda_eigenvalue:.6f}\n"
                f"  Собственный вектор:\n     {eigenvector_str}\n"
                f"  Вектор невязки (Ax - λx):\n     {residual_vector_str}\n"
                f"  Норма невязки: {residual_norm:.4e}\n"
                f"  Итераций: {iterations_amount}\n"
                f"\n" + "-"*40 + "\n\n"
            )
            
            f.write(block)
            print(f"-> {name}: lambda = {lambda_eigenvalue:.6f}")

    print("="*70)
    print(f"Готово! Отчет сохранен в: {report_path}")

if __name__ == "__main__":
    main()