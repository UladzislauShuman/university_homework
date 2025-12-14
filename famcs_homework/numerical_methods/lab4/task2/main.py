import numpy as np
import os
import sys

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from task1.data import get_matrices
from task1.inverse_power import inverse_power_method_with_shift
from danilevsky import danilevsky_method
from horner import evaluate_frobenius_polynome, format_polynomial

def main():
    OUTPUT_DIR = "task2_results"
    REPORT_FILE = "report_8_2.txt"
    
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
        
    report_path = os.path.join(OUTPUT_DIR, REPORT_FILE)
    matrices = get_matrices()
    
    print("="*70)
    print("Задание 8.2")
    print("Формирование отчета...")
    print("="*70)
    
    with open(report_path, 'w', encoding='utf-8') as f:

        for name, matrix in matrices.items():
            print(f"Обработка: {name}...")
            
            #  lambda из задания 1
            lambda_found, _, _, _ = inverse_power_method_with_shift(matrix, mu=0.0)
            
            # метод Данилевского
            polynome_blocks = danilevsky_method(matrix)
            
            polynome_string_parts = [] 
            total_value_at_lambda = 1.0
          
            # проходим по блокам для сборки полинома и вычисления значения
            for idx, (degree, coefficients) in enumerate(polynome_blocks):
                # формируем строку части полинома
                polynome_str = format_polynomial(coefficients)
                polynome_string_parts.append(f"({polynome_str})")
                
                # вычисляем значение
                val = evaluate_frobenius_polynome(coefficients, lambda_found)
                total_value_at_lambda *= val

            # собираем итоговую строку
            full_poly_str = " * ".join(polynome_string_parts)
            
            # матрица для вывода
            matrix_str = str(matrix).replace('\n', '\n\t')

            result_block = (
                f"--- {name} ---\n"
                f"Исходная матрица:\n\t{matrix_str}\n\n"
                f"Характеристический многочлен:\n"
                f"  P(λ) = {full_poly_str}\n\n"
                f"Проверка корня (из задания 8.1):\n"
                f"  P({lambda_found:.6f}) = {total_value_at_lambda:.4e}\n"
                f"\n" + "-"*40 + "\n\n"
            )
            
            f.write(result_block)
            print(f"-> {name}: Готово.")

    print("="*70)
    print(f"Готово! Отчет сохранен в: {report_path}")

if __name__ == "__main__":
    main()