import sys
import os
import time
import numpy as np
import matplotlib.pyplot as plt

from lab1 import generate_matrix, make_invert_matrix

def run_performance_test(start_size, end_size, step):
    """
    полный цикл эксперимента: 
    - замеры 
    - анализ 
    - сохранение отчета и графика
    """
    # --- настройки ---
    OUTPUT_DIR = "performance_results"
    REPORT_FILE = "performance_report.txt"
    PLOT_FILE = "performance_plot.png"
    NUM_RUNS_PER_SIZE = 3
    TARGET_TIME_SEC = 60.0

    # --- подготовка ---
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
    report_path = os.path.join(OUTPUT_DIR, REPORT_FILE)
    plot_path = os.path.join(OUTPUT_DIR, PLOT_FILE)
    results = []
    sizes_to_test = range(start_size, end_size + 1, step)

    print("="*60)
    print("Начало эксперимента по оценке производительности алгоритма O(n^3)")
    print(f"Диапазон размеров: от {start_size} до {end_size} с шагом {step}")
    print(f"Количество запусков для каждого размера: {NUM_RUNS_PER_SIZE}")
    print("="*60)
    
    # --- цикл замеров ---
    for n in sizes_to_test:
        times_for_current_size = []
        print(f"Обработка матриц размера {n}x{n}...")
        for i in range(NUM_RUNS_PER_SIZE):
            matrix = generate_matrix(n)
            start_time = time.time()
            make_invert_matrix(matrix)
            end_time = time.time()
            times_for_current_size.append(end_time - start_time)
        
        avg_time = np.mean(times_for_current_size)
        results.append((n, avg_time))
        print(f"-> Среднее время: {avg_time:.6f} сек.")

    print("\nЭксперимент завершен. Анализ результатов...")

    # ---  сохранение результатов ---
    if not results:
        print("Не было проведено ни одного замера.")
        return

    dims = np.array([res[0] for res in results])
    times = np.array([res[1] for res in results])
    
    # считаем константу c = T/n^3. исключаем n=0
    constants_c = times / (dims**3 + 1e-9)  # добавляем небольшое число к знаменателю для избежания деления на ноль
    num_points_for_avg = min(len(constants_c), 5)
    c_avg = np.mean(constants_c[-num_points_for_avg:])
    
    n_max_for_target_time = int((TARGET_TIME_SEC / c_avg)**(1/3)) if c_avg > 0 else 0

    # --- запись отчета ---
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("="*60 + "\n")
        f.write("Отчет о производительности алгоритма O(n^3)\n")
        f.write("="*60 + "\n\n")
        f.write("1. Результаты замеров\n" + "-"*40 + "\n")
        f.write(f"{'Размер (n)':<15} | {'Среднее время (T), сек':<25}\n" + "-"*40 + "\n")
        for n, t in results: f.write(f"{n:<15} | {t:<25.6f}\n")
        f.write("-" * 40 + "\n\n")
        f.write("2. Анализ асимптотической сложности\n" + "-"*40 + "\n")
        f.write("Теоретическая сложность: O(n^3)\n")
        f.write("Аппроксимация: T(n) = c * n^3\n\n")
        f.write(f"{'Размер (n)':<15} | {'Константа (c = T/n^3)':<25}\n" + "-"*40 + "\n")
        for i in range(len(dims)): f.write(f"{dims[i]:<15} | {constants_c[i]:<25.4e}\n")
        f.write("-" * 40 + "\n")
        f.write(f"\nСредняя константа 'c' (по последним {num_points_for_avg} замерам): {c_avg:.4e}\n\n")
        f.write("3. Прогноз производительности\n" + "-"*40 + "\n")
        f.write(f"На основе средней константы c = {c_avg:.4e}, прогнозируется, что\n")
        f.write(f"программа сможет обратить матрицу размером примерно\n")
        f.write(f"{n_max_for_target_time}x{n_max_for_target_time} за {TARGET_TIME_SEC:.0f} секунд (1 минуту).\n")
        f.write("-" * 40 + "\n")
    
    print(f"\nТекстовый отчет сохранен в файл: {report_path}")

    # --- график ---
    plt.style.use('seaborn-v0_8-whitegrid')
    fig, ax = plt.subplots(figsize=(10, 6))
    ax.plot(dims, times, 'o-', label='Экспериментальные данные', color='blue')
    theoretical_times = c_avg * (dims**3)
    ax.plot(dims, theoretical_times, '--', label=f'Аппроксимация $T(n) = {c_avg:.2e} \\cdot n^3$', color='red')
    ax.set_xlabel('Размерность матрицы (n)', fontsize=12)
    ax.set_ylabel('Время выполнения (сек)', fontsize=12)
    ax.set_title('Зависимость времени инвертирования матрицы от ее размерности', fontsize=14)
    ax.legend(fontsize=10)
    ax.grid(True)
    ax.set_xlim(left=0)
    ax.set_ylim(bottom=0)
    plt.tight_layout()
    plt.savefig(plot_path, dpi=300)
    print(f"График сохранен в файл: {plot_path}")
    print("="*60)


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Ошибка: Неверное количество аргументов.")
        print("Использование: python test.py <начальный_размер> <конечный_размер> <шаг>")
        print("Пример: python test.py 100 1000 100")
        sys.exit(1)

    try:
        start = int(sys.argv[1])
        end = int(sys.argv[2])
        step = int(sys.argv[3])
        if start <= 0 or end <= 0 or step <= 0 or start > end:
            raise ValueError("Параметры должны быть положительными, и начальный размер не должен превышать конечный.")
        run_performance_test(start, end, step)
    except ValueError as e:
        print(f"Ошибка в параметрах: {e}")
        sys.exit(1)