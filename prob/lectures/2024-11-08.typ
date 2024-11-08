#import "/utils/math.typ": *

Пусть $xi = (xi_, xi_2)$ --- непрерывный случайный вектор.
Тогда 

$xi_1$ и $xi_2$ независимы $<=>$ $f_xi (x, y) = f_(xi_1) (x) f_(xi_2) (y)$

#proof[
    - ($->$)
    
        $ f_xi (x, y) = (diff^2 F(x, y))/(diff x diff y) 
            = (diff^2 F_(xi_1) (x) F_(xi_2) (y)) / (diff x diff y)
            = (d F_(xi_1) (x)) / (d x) (d F_(xi_2) (y)) / (d y)
            = f_(xi_1) (x) f_(xi_2) (y) $

    - ($<-$)

        $ F_xi (x, y) = integral_(-oo)^(x) integral_(-oo)^y f_xi (t, s) d s d t
            = integral_(-oo)^x integral_(oo)^y f_(xi_1) (t) f_(xi_2) (s) d s d t
            = F_(xi_1) (x) F_(xi_2) (y)
        $
]

#def[
    Случайный вектор $xi = (xi_1, ...,  xi_n)$ имеет равномерное распределение в
    области $D in RR^n$, если
    $ f_xi (x_1, ...,  x_n) = cases(
        c "," &"if" (x_1, ...,  x_n) in D,
        0 "," &"oth"
    ) $

    При $n = 2: c = 1/(S_D)$
]

#blk(title: [Пример 1])[
    Пусть $xi = (xi_1, xi_2)$ распределен равномерно в прямоугольнике с
    углами в $(0, 0), (1, 1)$. Хотим проверить [не]зависимость компонент.

    $ f_xi (x, y) = cases(
        1 "," &"if" x in (0, 1) and y in (0, 1),
        0 "," &"oth"
    ) $

    $ f_(xi_1) (x) = integral_(-oo)^(+oo) f_xi (x, y) d y
        = cases(
            integral_0^1 1 d y = 1 "," &"if" x in (0, 1),
            0 "," &"if" x in.not (0, 1),
        )
    $

    $ f_(xi_2) (y) = integral_(-oo)^(+oo) f_xi (x, y) d x
        = cases(
            integral_0^1 1 d x = 1 "," &"if" y in (0, 1),
            0 "," &"if" y in.not (0, 1),
        )
    $

    Т.к. $f_xi (x, y) = f_(xi_1) (x) dot f_(xi_2) (y)$, то компоненты
    независимы
]

#blk(title: [Пример 2])[
    Пусть $xi = (xi_1, xi_2)$ распределен равномерно в круге $c = (0, 0), r =
    r$.

    $ f_xi (x, y) = cases(
        1/(pi r^2) "," &"if" x^2 + y^2 <= R^2,
        0 "," &"oth"
    ) $

    $ f_(xi_1) (x) = integral_(-oo)^(+oo) f(x, y) d y
        = integral_(-sqrt(R^2 - x^2))^(sqrt(R^2 - x^2)) 1/(pi r^2) d y
        = cases(
            (2 sqrt(R^2 - x^2)) / (pi r^2) "," &"if" abs(x) <= r,
            0 "," &"oth"
        )
    $

    $ f_(xi_2) (y) = integral_(-oo)^(+oo) f(x, y) d x
        = integral_(-sqrt(R^2 - y^2))^(sqrt(R^2 - y^2)) 1/(pi r^2) d x
        = cases(
            (2 sqrt(R^2 - y^2)) / (pi r^2) "," &"if" abs(y) <= r,
            0 "," &"oth"
        )
    $

    Т.к. $f_xi (x, y) eq.not f_(xi_1) (x) f_(xi_2) (y)$, то $xi_1$ и $xi_2$ ---
    зависимы
]

== Математическое ожидание

#def[
    #defitem[Математическим ожиданием] вектора $xi = (xi_1, xi_2)$ называется
    вектор $E xi = (m_1, ..., m_n)$, где $m_i = E xi_i$.
]

=== Свойства математического ожидания

- $E(xi_1 + xi_2) = E xi_1 + E xi_2$

    #proof[
        Для дискретного случая (для непрерывного аналогично):

        $ E(underbrace(xi_1 + xi_2, eta))
            = sum_i sum_j (x_i + y_j) p_(i j)
            = sum_i sum_j x_i p_i j + sum_i sum_j y_j p_i j =\
            = sum_i x_i p_(i dot) + sum_j y_j p_(dot j)
            = E xi_1 + E xi_2
        $
    ]

- Если $xi_1$ и $xi_2$ независимы, то $E (xi_1 xi_2) = E xi_1 dot E xi_2$

    #proof[
        Для непрерывного случая (для дискретного аналогично):

        $ E xi_1 xi_2 = integral_(-oo)^(+oo) integral_(-oo)^(+oo) x y f(x, y) d x d y
            underbrace(=, "независимы")
            integral_(-oo)^(+oo) integral_(-oo)^(+oo) x y f_(xi_1) (x) f_(xi_2) (y) d x d y =\
            = integral_(-oo)^(+oo) x f_(xi_1) (x) dot integral_(-oo)^(+oo) y f_(xi_2) (y)
            = E xi_1 E xi_2
        $
    ]

== Ковариация

#def[
    #defitem[Ковариация]#footnote[от "совместная изменяемость"] $xi_1$ и $xi_2$
    ($"cov"(xi_1, xi_2)$ или $k_(xi_1 xi_2)$):
    $ k_(xi_1 xi_2) = E (xi_1 - E xi_1) (xi_2 - E xi_2) = E xi_1^0 xi_2^0 $
]

#def[
    #defitem[Коэффициентом корреляции] $xi_1$ и $xi_2$ называется
    $ rho_(xi_1 xi_2) = k_(xi_1 xi_2) / sqrt(D xi_1 D xi_2)
        = k_(xi_1^* xi_2^*) $
]

#def[
    Величины $xi_1$ и $xi_2$ называются #defitem[некоррелированными], если
    $rho_(xi_1 xi_2) = 0$
]

#def[
    Величины $xi_1$ и $xi_2$ называются #defitem[положительно коррелированными], если
    $rho_(xi_1 xi_2) > 0$
]

#def[
    Величины $xi_1$ и $xi_2$ называются #defitem[отрицательно коррелированными], если
    $rho_(xi_1 xi_2) < 0$
]

=== Свойства ковариации

- $"cov"(xi, xi) = D xi$
- $D(xi + eta) = D xi + D eta + 2 "cov"(xi, eta)$
- $"cov"(xi, eta) = "cov"(eta, xi)$
- $"cov"(xi, eta) = E(xi - E xi)(eta - E eta) = ...
    = E xi eta - E xi E eta$
- $"cov"(a xi + b, c eta + d) = a b "cov"(xi, eta)$
- $abs(rho_(xi eta)) = abs("cov"(eta, xi)) / (sigma_xi sigma_eta) <= 1$

    $abs("cov"(eta, xi)) <= sigma_xi sigma_eta$

    #proof[
        $ 0 <= D(xi^* + eta^*) = D xi^* + D eta^* + 2 "cov"(xi^*, eta^*)
            = 1 + 1 + 2 rho_(xi eta) \
            => rho_(xi eta) >= -1 $
        $ 0 <= D(xi^* - eta^*) = D xi^* + D eta^* - 2 "cov"(xi^*, eta^*)
            = 1 + 1 - 2 rho_(xi eta) \
            => rho_(xi eta) <= 1 $
        $ -1 <= rho_(xi eta) <= 1 $
    ]
- Если $xi$ и $eta$ независимы и с конечными дисперсиями, то $"cov"(xi, eta) = 0$

    #proof[
        $ "cov"(xi, eta) = E xi^0 eta^0
            = integral_(-oo)^(+oo) integral_(-oo)^(+oo)
                (x - m_xi) (y - m_eta) f(x, y) d x d y = \
            underbrace(=, "независимы")
            integral_(-oo)^(+oo) integral_(-oo)^(+oo)
                (x - m_xi) f_xi (x) (y - m_eta) f_eta (y) d x d y = \
            = integral_(-oo)^(+oo) (x - m_xi) f_xi d x dot
                integral_(-oo)^(+oo) (x) (y - m_eta) f_eta (y) d y = 0 dot 0 = 0 $
    ]
