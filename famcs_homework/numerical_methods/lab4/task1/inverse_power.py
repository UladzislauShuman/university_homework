import numpy as np

def inverse_power_method_with_shift(
    A: np.ndarray, 
    mu: float = 0.0, 
    epsilon: float = 1e-6, 
    max_iter: int = 1000):
    """
    "Используя степенной метод со сдвигом, найти минимальные по модулю собственные значения 
    и соответствующие им собственные векторы матриц (известно, что все собственные значения данных матриц положительны)"
    
    по заданию мне нужно было использовать степенной метод со сдвигом
    степенной метод используют для определения максимального по модулю собственного значения
    а нам нужно для минимального по модулю
    то есть ближайщий к 0
    то есть сдвиг mu = 0

    далее
    исходная функция
    y^{k+1} = (A - mu I)^{-1} y^{k}
    (A - mu I) @ y^{k+1} = y^{k}
    с учетом что mu = 0
    A @ y^{k+1} = y^{k}
    и нам остаетя решить это СЛАУ, чтобы найти y^{k+1}
    

    
    аргументы:
        A (np.ndarray): исходная матрица.
        mu (float): значение сдвига.
        epsilon (float): точность.
        max_iter (int): максимальное число итераций.
        
    возвращает:
        eigenvalue (float): СЗн.
        eigenvector (np.ndarray): пронормированный СВ.
        iterations (int): количество итераций.
        residual_norm (float): норма вектора невязки ||Ax - lambda*x||.
    """
    n = A.shape[0]
        
    # x^(0)
    np.random.seed(42) # для воспроизводимости
    x = np.random.rand(n) # рандомно
    x = x / np.linalg.norm(x) # нормируем
    
    # A - mu*I
    shifted_A = A - mu * np.eye(n)
    
    # если shifted_A -- вырождена, то mu есть СЗн
    # то есть 
    # det(shifted_A) = 0
    # det(A - mu*I) = 0
    # то есть -- mu это СЗн
    if np.linalg.cond(shifted_A) > 1e10:
        print("WARN: Матрица близка к вырожденной, lambda ~ {mu}")

    eigenvalue = 0.0 # СЗн
    
    for k in range(max_iter):
        # решаем (A - mu*I) * y^(k+1) = x^(k)
        try:
            y = np.linalg.solve(shifted_A, x)
        except np.linalg.LinAlgError:
            raise ValueError("Матрица (A - shift*I) вырождена. Сдвиг совпал с собственным значением.")
        
        # нормируем: x^(k+1) = y / ||y||
        x_next = y / np.linalg.norm(y)
        
        # вычисляем приближение СЗн с помощью отношения Рэлея
        # lambda = (Ax, x) / (x, x). 
        # тк x нормирован, (x, x) = 1.
        eigenvalue = np.dot(A @ x_next, x_next)
        
        # норма невязки
        # r = ||A * x - lambda * x||
        residual_vector = A @ x_next - eigenvalue * x_next
        residual_norm = np.linalg.norm(residual_vector)
        
        # обновляем 
        x = x_next
        
        # сходится?
        if residual_norm < epsilon:
            return eigenvalue, x, k + 1, residual_norm

    return eigenvalue, x, max_iter, residual_norm