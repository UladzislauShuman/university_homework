# test.py

import sys
import os
import time
import numpy as np
import matplotlib.pyplot as plt
from generation import generate_system
from rotation import solve_rotation
from gauss import solve_gauss

def run_performance_experiment(start_size, end_size, step):
    """
    проводит полный цикл эксперимента по исследованию методов:
    - запускает решатели для диапазона размерностей.
    - собирает данные о погрешностях.
    - сохраняет результаты в txt и строит график.
    """
    # --- настройки ---
    OUTPUT_DIR = "performance_results"
    REPORT_FILE = "performance_report.txt"
    PLOT_FILE = "performance_plot.png"
    A_PARAM = -0.99

    # --- подготовка ---
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
    report_path = os.path.join(OUTPUT_DIR, REPORT_FILE)
    plot_path = os.path.join(OUTPUT_DIR, PLOT_FILE)
    
    results = []
    sizes_to_test = range(start_size, end_size + 1, step)

    print("="*60)
    print("начало эксперимента по исследованию методов")
    print(f"диапазон размеров: от {start_size} до {end_size} с шагом {step}")
    print(f"параметр 'a': {A_PARAM}")
    print("="*60)

    # --- вычисление погрешности ---
    """
    для оценки точности каждого метода я сравниваю полученное численное
    решение `x_computed` с заранее известным точным решением `x_0`.
    
    я выбрал евклидову норму для вычисления нормы погрешности
    
    формула для вычисления:
    error = ||x_0 - x_computed||₂ = sqrt(Σ( (x_0[i] - x_computed[i])² ))
    
    в коде это вычисляется с помощью функции `np.linalg.norm(x_0 - x_computed)`.
    """
    # --- цикл вычисления погрешностей ---
    for n in sizes_to_test:
        print(f"обработка системы размера {n}x{n}...")
        
        # генерируем систему
        a_matrix, x_0, b = generate_system(n, a_param=A_PARAM)
        
        # решаем методом вращений и считаем погрешность
        start_time = time.time()
        x_rotation = solve_rotation(a_matrix, b)
        time_rotation = time.time() - start_time
        error_rotation = np.linalg.norm(x_0 - x_rotation)
        
        # решаем оптимизированным методом гаусса и считаем погрешность
        start_time = time.time()
        x_gauss = solve_gauss(n, b, a_param=A_PARAM)
        time_gauss = time.time() - start_time
        error_gauss = np.linalg.norm(x_0 - x_gauss)
        
        # сохраняем результаты
        results.append((n, error_rotation, time_rotation, error_gauss, time_gauss))
        print(f"-> погрешность (вращения): {error_rotation:e}, время: {time_rotation:.4f}с")
        print(f"-> погрешность (гаусс):   {error_gauss:e}, время: {time_gauss:.4f}с")

    print("\nэксперимент завершен. сохранение результатов...")

    # --- сохранение результатов ---
    if not results:
        print("не было проведено ни одного замера.")
        return

    dims = np.array([res[0] for res in results])
    errors_rot = np.array([res[1] for res in results])
    errors_gauss = np.array([res[3] for res in results])

    # --- запись результата ---
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("="*70 + "\n")
        f.write("отчет\n")
        f.write("="*70 + "\n\n")
        f.write(f"{'размер (n)':<15} | {'погрешность (вращения)':<25} | {'погрешность (гаусс)':<25}\n")
        f.write("-" * 70 + "\n")
        for res in results:
            f.write(f"{res[0]:<15} | {res[1]:<25.6e} | {res[3]:<25.6e}\n")
        f.write("-" * 70 + "\n")
    
    print(f"\nтекстовый отчет сохранен в файл: {report_path}")

    # --- построение графика ---
    plt.style.use('seaborn-v0_8-whitegrid')
    fig, ax = plt.subplots(figsize=(12, 7))
    
    ax.plot(dims, errors_rot, 'o-', label='метод вращений', color='blue')
    ax.plot(dims, errors_gauss, 's--', label='оптимизированный метод гаусса', color='red')
    
    ax.set_xlabel('размерность матрицы (n)', fontsize=12)
    ax.set_ylabel('норма погрешности ||x_0 - x_computed||₂', fontsize=12)
    ax.set_title('зависимость точности решения слау от размерности матрицы', fontsize=14)
    ax.set_yscale('log')
    ax.legend(fontsize=10)
    ax.grid(True, which="both", ls="--")
    
    plt.tight_layout()
    plt.savefig(plot_path, dpi=300)
    print(f"график сохранен в файл: {plot_path}")
    print("="*60)


if __name__ == "__main__":
    # --- парсинг аргументов командной строки ---
    if len(sys.argv) != 4:
        print("ошибка: неверное количество аргументов.")
        print("использование: python test.py <начальный_размер> <конечный_размер> <шаг>")
        print("пример: python test.py 5 505 20")
        sys.exit(1)

    try:
        start = int(sys.argv[1])
        end = int(sys.argv[2])
        step = int(sys.argv[3])
        if start <= 0 or end <= 0 or step <= 0 or start > end:
            raise ValueError("параметры должны быть положительными, и начальный размер не должен превышать конечный.")
        run_performance_experiment(start, end, step)
    except ValueError as e:
        print(f"ошибка в параметрах: {e}")
        sys.exit(1)