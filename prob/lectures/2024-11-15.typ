#import "/utils/math.typ": *

=== Свойства коэффициента корреляции

- $rho_(xi eta) <= 1$
- $rho_(xi xi) = 1$
- Если $eta = a xi + b, a != 0$, то
    $ rho_(xi eta) = match(
        1, a > 0;
        -1, a < 0;
    ) $

    #proof[
        $ rho_(xi eta) &= "cov"(xi, eta) / sqrt(D xi D eta)
            = (E_(xi eta) - E_xi E_eta) / sqrt(D xi D eta) 
            = (E xi (a xi + b) - E xi E (a xi + b)) / sqrt(D xi D(a xi + b)) =\
            &= (a E xi^2 + cancel(b E xi) - a (E xi)^2 - cancel(b E xi)) / sqrt(a^2 (D xi)^2)
            = (a (E xi^2 - (E xi)^2)) / (abs(a) D xi)
            = (a D xi) / (abs(a) D xi)
        $
    ]

- Пусть $abs(rho_(xi eta)) = 1 => eta = a xi + b$

    #proof[
        - Пусть $rho_(xi eta) = 1$:

            $ D(xi^* - eta^*) &= D xi^* + D eta^* + 2 "cov"(xi^*, - eta^*) =\
                &= D xi^* + D eta^* - 2 "cov"(xi^*, eta^*)
                = 2 - 2 rho_(xi eta) = 2 (1 - rho_(xi eta)) = 0 $

            $ D (xi^* - eta^*) = 0 $

            $ xi^* - eta^* = c $

            $ (xi - m_xi) / sigma_xi - (eta - m_eta) / sigma_eta = c $

        - Пусть $rho_(xi eta) = -1$:

            $ D(xi^* + eta^*) = D xi^* + D eta^* + 2 "cov"(xi^*, eta^*)
                = 2 (1 + rho_(xi eta)) = 0 $
    ]

#blk(title: [Пример: зависимы, но не коррелированы])[
    $ x ~ R(-a, a) $

    $ n = xi^2 $

    $ "cov" (xi, eta) = E xi eta - underbrace(E xi, = 0) E eta
        = E xi^3 = integral_(-a)^(a) xi^3 dot 1/(2 a) d x = 0 $

    Так получается, потому что ковариация "отлавливает" только линейные
    зависимости
]

== Ковариационная матрица

#def[
    #defitem[Ковариационной матрицей] вектора $xi = (xi_1, ...,  xi_n)$
    называется матрица $K_xi = (k_(i j))$, где $k_(i j) = "cov"(xi_i, xi_j)$
]

=== Свойства ковариационной матрицы

- $k_(i j) = k_(j i)$
- $k_(i i) = D xi_i$
- $K_xi$ --- неотрицательно определенная:

    $ forall lambda_1, ...,  lambda_n in RR:
        sum_i sum_j lambda_i lambda_j k_(i j) >= 0 $

    #proof[
        $ 0 &<= E(sum_(i = 1)^n lambda_i xi_i^0)^2
            = E (sum_i sum_j lambda_i lambda_j xi_i^0 xi_j^0)
            = lambda_i lambda_j sum_i sum_j E (xi_i^0 xi_j^0)
            = lambda_i lambda_j sum_i sum_j k_(i j)
        $
    ]

== Корреляционной матрица

#def[
    #defitem[Корреляционной матрицей] вектора $xi = (xi_1, ...,  xi_n)$
    называется матрица $R_xi = (rho_(i j))$, где $rho_(i j) = rho(xi_i xi_j)$
]

=== Свойства корреляционной матрицы

- $rho_(i j) = rho_(j i)$
- $rho_(i i) = 1$
- $rho_xi$ --- неотрицательно определенная

По ковариационной матрице можно построить корреляционную, а наоборот -- не можем

== Формула свертки

Пусть $xi_1$ и $xi_2$ --- независимы, тогда
$ f_(xi_1 + xi_2) (y)
    = integral_(-oo)^(+oo) f_xi_1 (x) f_xi_2 (y - x)  d x. $

#proof[
    $ F_(xi_1 + xi_2) (y) = P(xi_1 + xi_2 <= y) =\
        = integral.double_(x_1 + x_2 <= y) f_(xi_1) (x_1) f_(xi_2) (x_2) d x_2 d x_1
        = integral_(-oo)^(+oo) integral_(-oo)^(z - x) f_(xi_1) (x) f_(xi_2) (y) d x_2 d x_1 $

    $ f_(xi_1 + xi_2) (y)
        = d/(d y) F_(xi_1 + xi_2) (y)
        = integral_(-oo)^(+oo) f_(xi_1) (x) f_(xi_2)(y - x) d x $
]


=== Пример

$ xi_1 ~ N(0, 1); xi_2 ~ N(0, 1) $

$xi_1, xi_2$ --- независимы

$ eta = xi_1 + xi_2 $

$ f_eta (z) &= integral_(-oo)^(+oo) 1/sqrt(2 pi) e^(- x^2 / 2) 1/sqrt(2 pi) e^(-(z - x)^2 / 2)
    = integral_(-oo)^(+oo) 1/sqrt(2 pi) e^(-x^2/2 - (z^2/2 - (2 x z) / 2+ x^2/2)) d x =\
    &= e^(-z^2/2)/(sqrt(2 pi) sqrt(2)) integral_(-oo)^(+oo) 1/(sqrt(2pi) sqrt(1/2)) e^(-(x - z/2)^2)
    = e^(-z^2/2)/(sqrt(2 pi) sqrt(2)) $

Снова получили гауссово распределение

#blk[
    Пусть $xi_1, ...,  xi_n$ --- независимые случайные величины такие, что
    $xi_i ~ N(m_i, sigma_i^2)$, то
    $ (eta = xi_1 + ... + xi_n) ~ N(m_eta, D_eta), $
    где
    $ m_eta = sum m_i $
    $ D_eta = sum D_i $
]
