#import "/utils/math.typ": *

#let cov = "cov"

== Свойства условной дисперсии

- $D(xi | eta = y_j) = sum_(i = 1)^m
    (x_i - E(xi | eta = y_j))^2
    (p_(i j)) / p_(dot j)$

- $D(xi | eta = y) = integral_(-oo)^(oo)
    (x - E(xi | eta = y))^2 f_xi (x | y) d x$

= Гауссовский вектор

#blk(title: [Условие нормировки для распределения Гаусса])[
    Пусть $xi_1$ и $xi_2$ независимы и $xi_1, xi_2 ~ N(0, 1)$.

    $ xi = (xi_1, xi_2) $
    $ f_(xi_1) (x) = 1/sqrt(2 pi) exp(-x^2 / 2) $

    $ f_xi (x, y) = f_xi_1 (x) f_xi_2 (y) = 1/(2 pi) exp(-(x^2 + y^2) / 2)$

    $ integral_(-oo)^oo integral_(-oo)^oo f_xi (x, y) d x d y
        = integral_(-oo)^oo f_xi_1 (x) d x integral_(-oo)^oo f_xi_2 (y) d y =\
        = integral_(-oo)^oo integral_(-oo)^oo 1/(2 pi) exp(-(x^2 + y^2) / 2)
        = {#stack(
            $ x = r cos phi $,
            $ y = r sin phi $,
            $ abs(J) = r $,
        )} = \
        = integral_0^(2 pi) integral_0^(+oo) r/(2 pi) exp(-r^2 / 2) d r d phi
        = integral_0^(+oo) r exp(-r^2/2) d r =\
        = integral_0^(+oo) exp(-r^2/2) d r^2 / 2
        = lr(-exp(-r^2 / 2)|)_0^(+oo) = 1
    $
]

#def[
    Случайный вектор $xi = (xi_1, ..., xi_n)^T$ имеет нормальное (гауссовское)
    распределение $xi ~ N(m, K)$, если плотность распределения имеет вид:

    - в векторном виде:
        $ f(x) = 1/sqrt((2pi)^2 det K) exp(-1/2 ((x - m)^T K^(-1) (x - m))) $

    - в виде функции от $n$ переменных:

        $ f(x_1, ...,  x_n)
            = sqrt(det C)/sqrt((2 pi)^n)
                exp(-1/2 (sum_r sum_j c_(i j) (x_i - m_i)(x_j - m_j))) $
]

== Свойства гауссовского распределения

- $E xi = m; K_xi = k$
- Любой подвектор гауссового вектора --- тоже гауссовый вектор
- Пусть $eta = sum_(i = 1)^n alpha_i xi_i$ и не все $alpha_i = 0$, тогда $eta$
    тоже имеет гауссового распределение.
- Пусть $eta = A xi + B$, где $A$ --- матрица размера $K times n$, а $B$ --- вектор размера $K$.

    $ eta ~ N(A m_xi + B, A K_xi A^T) $

- Если компоненты гауссового вектора попарно некоррелированны, то они
    независимы#footnote[Это работает именно для гауссового распределение]

    #proof[
        $ forall i != j: rho_(xi_i xi_j) = 0 => cov(xi_i, xi_j) = 0 $

        $ K = mat(
            sigma_1^2, ...,       0;
            dots.v,    dots.down, dots.v;
            0,         ...,       sigma_n^2;
        ) $

        $ C = K^-1 = mat(
            1/sigma_1^2, ...,       0;
            dots.v,      dots.down, dots.v;
            0,           ...,       1/sigma_n^2;
        ) $

        $ f(x_1, ...,  x_n)
            = 1/(sqrt((2pi)^n sigma_1 ...  sigma_n))
                exp(-1/2 sum_(i = 1)^n 1/sigma_i^2 (x_i - m_i)^2) =\
            =
                underbrace(1/(sqrt(2 pi) sigma_1) exp(-1/2 (x_1 - m_1)^2/sigma_1^2), f_xi_1 (x_1))
                dot ... dot
                underbrace(1/(sqrt(2 pi) sigma_n) exp(-1/2 (x_n - m_n)^2/sigma_n^2), f_xi_n (x_n)) $
    ]

- *Теорема о нормальной корреляции*

    Пусть 

    $ z = (z_1, ..., z_n)^T ~ N(m_z, K_z) $
    $ eta = (z_1, ...,  z_l)^T $
    $ xi = (z_(l+1), ...,  z_m)^T $
    $ m_z^T = (m_eta^T, m_xi^T) $
    $ K_z = mat(
        K_(eta eta), K_(eta xi);
        K_(xi eta), K_(xi xi)
    ) $

    Тогда
    
    $ (eta | xi = x) ~ N(m_(eta | xi = x), K_(eta | xi = x)), $

    где

    $ m_(eta | xi = x) = m_eta + K_(eta xi) K_(eta eta)^(-1) (x - m_xi) $
    $ K_(eta | xi = x) = K_(eta eta) - K_(eta xi) K_(xi xi)^(-1) K_(eta xi)^T $

    При $n = 2:$

    $ m_(eta | xi = x) = m_eta + cov(xi, eta) / (D xi) (x - m_xi) $
    $ D(eta | xi = x) = D eta - (cov(xi, eta))^2 / (D xi) $


#blk(title: [Пример])[
    На бирже акциями торгуют $A$ и $B$.

    $ (xi_A, xi_B) ~ N(m, K) $

    $ m = mat(10; 12) $
    $ K = mat(
        4, 3.6;
        3.6, 9;
    ) $

    - $P(xi_A > xi_B) - ?$
    - $xi_B = 14; E(xi_A | xi_B = 14) - ?; D(xi_A | xi_B = 14) - ?$

    *Решение:*
    $ P(xi_A > xi_B) = P(xi_A - xi_B > 0) $
    $ xi_A - xi_B ~ N(-2, 2.4^2) $
    \*Дальше по функции Лапласа\*

    $ E(xi_A | xi_B = 14) = 10 + 3.6 / 9 (14 - 12) = 10.8 $
    $ D(xi_A | xi_B) = 4 - 3.6^2/9 = 2.56 $
]

= Виды сходимости случайных последовательностей

#def[
    Последовательность случайных величин $xi_1, ..., xi_n, ...$ определенных на
    одном вероятностном пространстве $Omega$, называют #defitem[случайной
    последовательностью]: ${xi_n}_(n = 1,...)$.
]

#def[
    Случайная последовательность $xi_n$ #defitem[сходится по вероятности] к $xi$:
    $xi_n ->^P xi$, если
    $ forall epsilon > 0: P(abs(xi_n - xi) > epsilon) ->_(n -> oo) 0 $
]
