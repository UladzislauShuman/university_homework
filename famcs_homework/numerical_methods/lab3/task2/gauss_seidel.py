import numpy as np
import time

def gauss_seidel(n, tolerance=1e-10, max_iter=5000):
    """
    Решает СЛАУ A_n*x = b методом Гаусса-Зейделя для матрицы A_n вида
    n 0 n-2 0   0   0
    1 n 0   n-2 0   0 
    1 0 n   0   n-2 0
    1 0 0   n   0   n-2
    1 0 0   0   n   0
    1 0 0   0   0   n
    
    n -- размернсть матрицы
    """
    # вектор правой части b согласно условию: b = [1, 1, 1, ..., 1]^T
    b = np.ones(n)
    # начальное приближение x^(0) как нулевой вектор
    x = np.zeros(n)
    
    residuals_history = []
    
    for k in range(max_iter):
        # соъраняем предыдущего приближения x^(k)
        x_old = x.copy()
        
        # обновляем все компоненты вектора x для x^(k+1)
        for i in range(n):
            # будет хранить сумму Σ(a_ij * x_j) для j != i
            sigma = 0.0
            
            # вместо полного перебора строки добавляем в сумму только
            # те слагаемые, которые соответствуют ненулевым элементам.
            
            # слагаемое для a_i0 = 1,где i > 0
            if i > 0:
                # используем значение x[0] из текущей итерации k+1
                sigma += x[0] 
            
            # слагаемое для a_{i, i+2} = n-2 при i <= n-3
            if i <= n - 3:
                # используем значение x[i+2] из итерации k (x_old)
                sigma += (n - 2) * x_old[i + 2]
            
            # итого X^(k+1)
            x[i] = (b[i] - sigma) / n

        # проверяем на остановку
        residual_vector = np.zeros(n)
        for i in range(n):
            # берем диагональный элемент: a_ii * x_i
            ax_i = n * x[i]
            # добавляем от первого столбца: a_i0 * x_0
            if i > 0:
                ax_i += x[0]
            # добавляем наддиагональ: a_{i, i+2} * x_{i+2}
            if i <= n - 3:
                ax_i += (n - 2) * x[i + 2]
            
            residual_vector[i] = ax_i - b[i]
        
        residual_norm = np.linalg.norm(residual_vector)
        
        residuals_history.append(residual_norm)
        
        # сравниваем
        if residual_norm < tolerance:
            return x, k + 1, residuals_history
            
    return x, max_iter, residuals_history