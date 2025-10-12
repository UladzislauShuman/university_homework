import sys
import numpy as np
import random
import time

def generate_matrix(size: int, value_range: tuple = (-10, 10)) -> list:
    """
    генерирует случайную матрицу нужного формата
    матрица гарантированно является невырожденной.
    """
    if size <= 0:
        raise ValueError("Размер матрицы должен быть положительным числом.")

    low, high = value_range
    matrix = [[0.0] * size for _ in range(size)]

    # случайными числами
    for i in range(size):
        for j in range(i + 2):  # j <= i + 1
            if j < size:
                matrix[i][j] = float(random.randint(low, high))


    # у меня возникла проблема, что -- если просто сгенерировать матрицу, то
    # получиться то, что получается в output_intput_example.txt
    # причина такая 
    """
    матрица может быть хоть и не строго вырожденной, то есть -- ей можно найти обратную матрицу
    но может получиться плохо обусловленной (то есть -- произойти округление И поломать тем самым все вычисления)
    поэтому, мне нужно сгенерировать матрицы, которые 
    - невырождены
    - численно устойчивы
    и есть класс матриц, который может нам это позволить -- матрицы с Диагональным преобладанием
    это матрицы, у которых для каждой строки i модуль ее диагонального элемента строго больше, чем
    сумма модулей остальных элементов строки
    |A[i][i]| > Σ |A[i][j]| for all j != i
    """
    # собственно этим алгоритм и занимается
    for i in range(size): # 0 до size - 1
        # cумма модулей всех недиагональных элементов в строке
        off_diagonal_sum = sum(abs(matrix[i][j]) for j in range(size) if i != j)
        
        # делаем диагональный элемент по модулю строго больше этой суммы
        new_diag_val = off_diagonal_sum + random.randint(1, 5)
        # знак выбираем случайно, чтобы не было только положительных диагоналей
        matrix[i][i] = new_diag_val if random.random() > 0.5 else -new_diag_val

    return matrix

def make_invert_matrix(matrix):
    """
    Данный метод находит обратную матрицу для матрицы вида:
    X X 0 0 0
    X X X 0 0
    X X X X 0
    X X X X X
    X X X X X

    как работает алгоритм
        он использует метод Гаусса с выбором главного элемента по столбцу
        мы итерируем снизу вверх
            сравниваются модули элементов (k,k) и (k-1,k) (ищется главный только среди этих двух, так как выше их стоят нули)
            в случае если (k,k) меньше чем (k-1,k), то строки меняются местами
            потом (k)ая строка обнуляет (k-1)ую строку
        в промежуточном результате мы получаем слева нижнетреугольную матрицу, а справа некоторую матрицу
        далее мы применяем обратный ход, чтобы получить слева единичную матрицу, а справа уже обратную исходной матрицу
    """ 
    n = len(matrix)

    # --- Инициализация ---
    # создаем копию (мы тем самым исходную matrix не поменяем)
    A = [[float(el) for el in row] for row in matrix]

    # инициализириуем единичную (по итогу она и будет содержать обратную)
    B = [[0.0] * n for _ in range(n)]
    for i in range(n):
        B[i][i] = 1.0
    # --- O(n^2) ---

    # --- Прямой ход ---
    # идем снизу вверх
    for j in range(n - 1, 0, -1): # n - 1 до 1
        # print_matrix(A, title=("Матрица A на этапе "+ str(j)))
        # выбираем главный элемент по столбцу j (сравниваем a[j][j] и a[j-1][j])
        if abs(A[j-1][j]) > abs(A[j][j]):
            # в случае если, меняем строки j и j-1 местами
            A[j], A[j-1] = A[j-1], A[j]
            # в обеих матрицах
            B[j], B[j-1] = B[j-1], B[j]

        # уже предварительно проверяем матрицу на вырожденность
        # ну то есть -- мы получили уже диагональный элемент будущей нижнетреугольной матрицы
        # а тк определитель нижнетреугольной матрицы равен произведению диагональных элементов
        # то мы уже на месте можем проверить, не будет ли определитель равен 0
        if A[j][j] == 0:
            raise ValueError("Матрица вырождена")

        # коэффициент для обнуления элемента a[j-1][j]
        factor = A[j-1][j] / A[j][j]
        
        # для A  обновляем только ненулевую часть строки (до j-го столбца включительно)
        for k in range(j + 1): # от 0 до j
            A[j-1][k] -= factor * A[j][k]
        
        # для B обновляем только ту часть строки, где появляются ненулевые элементы.
        # цикл будет от j-1, так как перестановка могла поместить ненулевой элемент в позицию (j-1, j).
        for k in range(j - 1, n): # j-1 до n-1
            B[j-1][k] -= factor * B[j][k]

    # print_matrix(A, title=("Матрица A на этапе "+ str(0)))
    if A[0][0] == 0:
        raise ValueError("Матрица вырождена")
    
    """
    основной цикл добавляет нам n
    внутренние циклы хоть и меньше чем n, но в среднем добавят n
    поэтому
    """
    # --- O(n^2) ---
    
    # --- Обратный ход ---
    # в результате прямого обхода мы имеем нижнетреугольную матрицу 
    # и верхнетреугольную матрицу с нижней поддиагональю
    """
    что-то вида
    
    A = 
    x 0 0 0 0 
    x x 0 0 0
    x x x 0 0
    x x x x 0
    x x x x x
    
    B = 
    x x x x x
    x x x x x 
    0 x x x x 
    0 0 x x x
    0 0 0 x x
    """
    
    # диагонали до единиц
    # для первой строки (просто потом будет считать для B, ибо если мы на i строке, то придется считать от j)
    divisor = A[0][0]
    for k in range(0 + 1): # 0 до 0 
        A[0][k] /= divisor
    for k in range(0, n):
            B[0][k] /= divisor
            
    for i in range(1, n): # 1 до n - 1
        divisor = A[i][i]
        # делим только левую часть до диагонали (дальше 0)
        for k in range(i + 1): # 0 до i 
            A[i][k] /= divisor
            
        for k in range(i - 1, n):
            B[i][k] /= divisor
            
    """
    два вложенных цикла, которые в среднем O(n)
    итого
    """
     # --- O(n^2) ---

    # обнуляем поддиагональные элементы
    """
    сейчас мы имеем все тоже самое, но вида
    
    A = 
    1 0 0 0 0 
    x 1 0 0 0
    x x 1 0 0
    x x x 1 0
    x x x x 1
    
    B = 
    x x x x x
    x x x x x 
    0 x x x x 
    0 0 x x x
    0 0 0 x x
    """
    # идем по строкам
    for i in range(1, n): # нет смысла рассматривать первую строку, там уже и так единица
        # идем по столбцам, до диагонали
        for j in range(i):
            factor = A[i][j]
            if factor == 0:
                continue

            # для А будет достаточно просто обнулить элемент, ибо A[j][j] = 1,
            # и остальные элементы в j-й строке левее диагонали равны нулю.
            A[i][j] = 0.0

            # Для B выполняем полное вычитание строк
            for k in range(n): # 0 до n - 1
                B[i][k] -= factor * B[j][k]

    """
    три вложенных цикла в среднем по O(n) каждый
    """
     # --- O(n^3) ---
    
    return B
    """
    итого сложность 
    0 
    + инициализация O(n^2)
    + прямой ход O(n^2)
    + обратный ход 
        + диагонали к единиицам O(n^2)
        + обнуление поддиагональныых элементов O(n^3)
    = 
    O(n^3)
    """


def print_matrix(matrix, title="Матрица:", precision=4, file_handle=None):
    """
    выводит матрицу в консоль и в файл
    """
    print(title)
    if file_handle:
        file_handle.write(title + "\n")

    if not matrix:
        print("[]")
        if file_handle:
            file_handle.write("[]\n")
        return
        
    format_str = f"{{elem:10.{precision}f}}"
    for row in matrix:
        row_str = " ".join(format_str.format(elem=elem) for elem in row)
        print(row_str)
        if file_handle:
            file_handle.write(row_str + "\n")
    

    print()
    if file_handle:
        file_handle.write("\n")

def parse_matrix_from_file(filename):
    """
    читает матрицу из текстового файла.
    числа в строке должны быть разделены пробелами.
    каждая строка файла - это строка матрицы.
    """
    matrix = []
    with open(filename, 'r') as f:
        for line in f:
            # пропускаем пустые строки
            if not line.strip():
                continue
            # разделяем строку по пробелам и преобразуем в числа
            row = [float(num) for num in line.strip().split()]
            matrix.append(row)
    return matrix

def process_and_save(matrix, source_name):
    """
    что сохраняет в txt файл
    - исходную
    - обратную
    - результат перемножения (для проверки)
    """
    output_filename = f"output_{source_name}"
    with open(output_filename, 'w', encoding='utf-8') as outfile:
        header = f"--- Обработка источника: {source_name} ---\n"
        print(header.strip())
        outfile.write(header)
        try:
            print_matrix(matrix, "Исходная матрица:", file_handle=outfile)
            start_time = time.time()
            
            inverse_matrix = make_invert_matrix(matrix)
            
            end_time = time.time()
            duration = end_time - start_time
            time_report = f"Время выполнения инвертирования: {duration:.6f} сек.\n"
            print("\n" + time_report.strip())
            outfile.write("\n" + time_report)
            
            print_matrix(inverse_matrix, "Обратная матрица:", file_handle=outfile)
            
            A_np = np.array(matrix)
            A_inv_np = np.array(inverse_matrix)
            identity_check = np.dot(A_np, A_inv_np)
            print_matrix(identity_check.tolist(), "Проверка (A * A⁻¹):", file_handle=outfile)
        
        except (ValueError, Exception) as e:
            error_message = f"Ошибка: {e}"
            print(error_message)
            outfile.write(error_message + "\n")

if __name__ == "__main__":
    args = sys.argv

    # python lab1.py <имя_файла>
    if len(args) == 2:
        input_filename = args[1]
        try:
            original_matrix = parse_matrix_from_file(input_filename)
            process_and_save(original_matrix, input_filename)
        except (FileNotFoundError, ValueError) as e:
            print(f"Ошибка чтения файла: {e}")

    # python lab1.py <базовое_имя_для_вывода> random <размер>
    elif len(args) == 4 and args[2].lower() == 'random':
        output_base_name = args[1]
        try:
            size = int(args[3])
            original_matrix = generate_matrix(size)
            process_and_save(original_matrix, output_base_name)
        except ValueError:
            print(f"Ошибка генерации: Неверный размер '{args[3]}'. Ожидается целое число.")
        except IndexError:
            print("Ошибка: Неверное количество аргументов для генерации.")

    else:
        print("Ошибка: Неверное использование скрипта.")
        print("\nСпособ 1 (чтение из файла):")
        print("  python test.py <имя_входного_файла>")
        print("\nСпособ 2 (генерация случайной матрицы):")
        print("  python test.py <имя_выходного_файла> random <размер>")
        print("  Пример: python test.py my_random_test.txt random 15")
