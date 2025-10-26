import numpy as np

def generate_system(n: int, a_param: float = -0.99) -> tuple[np.ndarray, np.ndarray, np.ndarray]:
    """
    генерирует матрицу a, точное решение x_0 и вектор b для слау ax=b
    согласно условию лабораторной работы.

    - n: размерность системы.
    - a_param: значение параметра 'a'.

    возвращает кортеж (a_matrix, x_0, b), где a_matrix - матрица (n,n),
    x_0 - вектор (n,), b - вектор (n,).
    """
    # --- генерация матрицы A ---
    """
    1 0 0 0 0 1 
    a 1 0 0 0 1 
    a a 1 0 0 1 
    a a a 1 0 1 
    a a a a 1 1 
    a a a a a 1 
    """
    a_matrix = np.zeros((n, n), dtype=float)
    # заполняем поддиагональную часть и главную диагональ
    for i in range(n):
        for j in range(i + 1):
            if i == j:
                a_matrix[i, j] = 1.0
            else:
                a_matrix[i, j] = a_param
    # заполняем последний столбец единицами
    a_matrix[:, -1] = 1.0

    # --- генерация точного решения x_0 ---
    # согласло условию -- ветор 1
    x_0 = np.ones(n, dtype=float)

    # --- вычисление вектора b ---
    # исходя из условия b = A * x_0
    """
    рассмотрим на примере 6 x 6
    1 0 0 0 0 1 | 1
    a 1 0 0 0 1 | 1
    a a 1 0 0 1 | 1
    a a a 1 0 1 | 1
    a a a a 1 1 | 1
    a a a a a 1 | 1
    
    итого 
    0 * a + 1 + 1 = 0 * a + 2
    1 * a + 1 + 1 = 1 * a = 2
    ...
    4a + 2
    но тут уже только одна 1 
    5a + 1
    
    """
    # b_i = (i-1)*a + 2 для i < n-1
    # b_{n-1} = (n-1)*a + 1
    b = np.arange(n) * a_param + 2.0
    b[-1] = (n - 1) * a_param + 1.0
    
    return a_matrix, x_0, b