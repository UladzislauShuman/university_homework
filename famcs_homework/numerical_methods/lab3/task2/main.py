import numpy as np
import time
import matplotlib.pyplot as plt
import os

from gauss_seidel import gauss_seidel


def main():
    OUTPUT_DIR = "task2_results"
    REPORT_FILE = "report.txt"
    PLOT_FILE = "plot.png"

    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
    
    report_path = os.path.join(OUTPUT_DIR, REPORT_FILE)
    plot_path = os.path.join(OUTPUT_DIR, PLOT_FILE)

    sizes = [10, 50, 100, 1000]
    
    print("="*60)
    print("Начало решения СЛАУ методом Гаусса-Зейделя")
    print("Критерий остановки: ||Ax - b|| < 1e-10")
    print("="*60)
    
    plt.style.use('seaborn-v0_8-whitegrid')
    plt.figure(figsize=(12, 8))
    
    results_for_report = []
    solution_1000 = None

    for n in sizes:
        start_time = time.time()
        solution, iterations, residuals_history = gauss_seidel(n=n)
        end_time = time.time()
        
        time_taken = end_time - start_time
        final_residual = residuals_history[-1] if residuals_history else float('nan')
        results_for_report.append((n, iterations, time_taken, final_residual))

        print(f"\n--- Результаты для n = {n} ---")
        print(f"Количество итераций: {iterations}")
        print(f"Время выполнения: {time_taken:.4f} сек.")
        
        plt.plot(range(1, iterations + 1), residuals_history, marker='o', markersize=4, linestyle='-', label=f'n = {n}')
        
        if n == 1000:
            solution_1000 = solution
            print("\nРешение для n = 1000 (первые 20 компонент):")
            for i in range(20):
                print(f"x[{i:2d}] = {solution[i]:.8f}")
            
            print("\nРешение для n = 1000 (последние 20 компонент):")
            for i in range(n - 20, n):
                print(f"x[{i:4d}] = {solution[i]:.8f}")
    
    print("\n" + "="*60)

    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("="*70 + "\n")
        f.write("Отчет\n")
        f.write("="*70 + "\n\n")
        f.write("Сводная таблица результатов:\n")
        f.write(f"{'Размер (n)':<15} | {'Итерации':<15} | {'Время (сек)':<15} | {'Финальная невязка':<20}\n")
        f.write("-" * 75 + "\n")
        for res in results_for_report:
            n_val, it_val, time_val, res_val = res
            f.write(f"{n_val:<15} | {it_val:<15} | {time_val:<15.4f} | {res_val:<20.4e}\n")
        f.write("-" * 75 + "\n\n")

        if solution_1000 is not None:
            f.write("Компоненты вектора решения для n = 1000:\n")
            f.write("-" * 40 + "\n")
            f.write("Первые 20 компонент:\n")
            for i in range(20):
                f.write(f"x[{i:2d}] = {solution_1000[i]:.8f}\n")
            f.write("\nПоследние 20 компонент:\n")
            for i in range(1000 - 20, 1000):
                f.write(f"x[{i:4d}] = {solution_1000[i]:.8f}\n")
            f.write("-" * 40 + "\n\n")
        f.write("="*70 + "\n")

    print(f"Текстовый отчет успешно сохранен в: {report_path}")

    plt.yscale('log')
    plt.xlabel('Номер итерации, k', fontsize=14)
    plt.ylabel('Норма невязки ||Ax^k - b|| (log-шкала)', fontsize=14)
    plt.title('Диаграмма сходимости метода Гаусса-Зейделя', fontsize=16)
    plt.legend(fontsize=12)
    plt.grid(True, which="both", ls="--")
    
    plt.savefig(plot_path, dpi=300)
    print(f"График успешно сохранен в: {plot_path}")
    
    plt.show()


if __name__ == "__main__":
    main()