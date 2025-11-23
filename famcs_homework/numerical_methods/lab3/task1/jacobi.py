
import numpy as np

def jacobi_method(A, b, x0, max_iter):

    n = len(b)
    x = x0.copy()
    residuals_history = [] 

    for k in range(max_iter): # 0 до max_iter - 1
        residual = np.linalg.norm(A @ x - b) # евклидово расстояние
        residuals_history.append(residual)

        x_new = np.zeros(n)
        for i in range(n): # 0 до n - 1
            s1 = np.dot(A[i, :i], x[:i]) # матричное умножение
            s2 = np.dot(A[i, i + 1:], x[i + 1:])
            # то есть j != i
            x_new[i] = (b[i] - s1 - s2) / A[i, i]
        
        x = x_new
        
    return x, residuals_history