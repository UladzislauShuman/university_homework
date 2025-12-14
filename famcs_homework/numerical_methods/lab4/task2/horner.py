def evaluate_frobenius_poly(coefficients, lambda_):
    """
    вычисляет значение характеристического многочлена в lambda_ по схеме Горнера, указаной в условии.
    P(x) = x^n - p[0]*x^(n-1) - p[1]*x^(n-2) - ... - p[n-1]
    coeffs: список [p1, p2, ..., pn]
    lambda_: значение x
    """
    result = 1.0 # так как у нас цель проверить, правильно ли мы нашли и СЗн и равно ли нулю выражение, 
    #то не важно 1 или -1 коэффициент при старшей степени lambda^n
    
    for p in coefficients:
        # P(x) = (...((1 * x - p1) * x - p2) * x ... ) - pn
        result = result * lambda_ - p
        
    return result

def format_polynomial(coefficients):
    """
    выписывает полином в красивом виде
    если получился блочный вариант -- нужнно в цикле вызывать эту функцию
    """
    n = len(coefficients)
    terms = [f"λ^{n}"]
    
    for i, p in enumerate(coefficients):
        power = n - 1 - i
        sign = "-" if p >= 0 else "+"
        val = abs(p)
        
        term_str = f" {sign} {val:.4f}"
        if power > 0:
            term_str += f"λ^{power}" if power > 1 else "λ"
        
        terms.append(term_str)
        
    return "".join(terms)