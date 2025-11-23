import numpy as np
import time

def solve_gauss_seidel_sparse(n, tolerance=1e-10, max_iter=5000):

    b = np.ones(n)
    b[0] = 3.0
    x = np.zeros(n)
    for k in range(max_iter):
        x_old = x.copy()
        
        for i in range(n):
            sigma = 0.0
            
            if i > 0:
                sigma += x[0] 
            
            if i <= n - 3:
                sigma += (n - 2) * x_old[i + 2]
            x[i] = (b[i] - sigma) / n

        residual_vector = np.zeros(n)
        for i in range(n):
            ax_i = n * x[i]
            if i > 0:
                ax_i += x[0]
            if i <= n - 3:
                ax_i += (n - 2) * x[i + 2]
            
            residual_vector[i] = ax_i - b[i]
        
        residual_norm = np.max(np.abs(residual_vector))
        
        if residual_norm < tolerance:
            return x, k + 1 
            
    return x, max_iter 

def main():
    sizes = [10, 50, 100, 1000]
    
    print("="*60)
    print("Запуск решения СЛАУ методом Гаусса-Зейделя")
    print("Критерий остановки: ||Ax - b||_inf < 1e-10")
    print("="*60)
    
    for n in sizes:
        start_time = time.time()
        solution, iterations = solve_gauss_seidel_sparse(n)
        end_time = time.time()
        
        print(f"\n--- Результаты для n = {n} ---")
        print(f"Количество итераций: {iterations}")
        print(f"Время выполнения: {end_time - start_time:.4f} сек.")
        
        if n == 1000:
            print("\nРешение для n = 1000 (первые 20 компонент):")
            for i in range(20):
                print(f"x[{i:2d}] = {solution[i]:.8f}")
            
            print("\nРешение для n = 1000 (последние 20 компонент):")
            for i in range(n - 20, n):
                print(f"x[{i:4d}] = {solution[i]:.8f}")
    
    print("\n" + "="*60)

if __name__ == "__main__":
    main()