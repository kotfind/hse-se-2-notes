#import "/utils/math.typ": *

= Неравенства Чебышева

Пусть
$ E abs(xi)^r < oo, $
Тогда
$ forall epsilon > 0: P(abs(xi) >= epsilon) <= (E abs(xi)^r) / (epsilon^r). $

Часто дает очень грубую оценку

#proof[
    $ E abs(r) = integral_(-oo)^(+oo) abs(x)^2 f(x) d x
        >= integral_(abs(x) >= epsilon) abs(x)^2 f(x) d x
        >= epsilon^r integral_(abs(x) >= epsilon) f(x) d x
        = epsilon^r P(abs(xi) >= epsilon)
    $
]

== Частные случаи

- Неравенство Маркова: $r = 1$ и $P(xi >= 0) = 1$

    $ P(xi >= epsilon) <= (E (xi)) / epsilon $

- $r = 2$:

    $ P(abs(xi) >= epsilon) <= (E xi^2) / (epsilon^2) $

- $r = 2$ и $eta = epsilon - E epsilon$:

    $ P(abs(xi - E xi) >= epsilon) <= D / (epsilon^2) $

== Пример

$xi$ --- расход электроэнергии
$E xi = 4000 "Кв"/"ч"$

Оценить, что в какой-то день $P(xi >= 10000)$

$ r = 1 $
$ P(xi >= 0) = 1 $

$ P(xi >= 10 000) = 4000 / 10000 = 0.4$

= Случайные векторы

#def[
    Вектор $xi = (xi_1, ...,  xi_n)$, где $xi_1, ...,  xi_n$ --- случайные
    величины, называется #defitem[случайным вектором].
]

Случайные вектора нужны, так как случайные величины обычно полезно рассматривать
в совокупности.

#def[
    #defitem[Функцией распределения случайного вектора] $xi = (xi_1, ...,
    xi_n)$ называется функция
    $ F_xi (x_1, ...,  x_n) = P(xi_1 < x_1, ..., xi_n <= x_n)
        := P(xi_1 < x_1 and ... and xi_n <= x_n) $
]

Пусть $n = 2:$
$F_xi (x y) = P(xi_1 <= x, xi_2 <= y)$

== Свойства функции распределения

На примере $n = 2$

+ $forall (x, y) in RR^2: 0 <= F(x, y) <= 1$
+ $F(-oo, -oo) = F(-oo, y) = F(x, -oo) = 0$
+ $F(+oo, +oo) = 1$
+ $F_xi (+oo, y) = F_(xi_2) (y)$\
  $F_xi (x, +oo) = F_(xi_1) (x)$
+ $P(a_1 <= xi_1 <= a_2, b_1 <= xi_2 <= b_2)
    = F(a_2, b_2) - F(a_1, b_2) - F(a_2, b_1) + F(a_1, b_1)$
+ $F(x, y)$ монотонно не убывает по каждому аргументу

    #proof[
        $ F(x + Delta x, y) = P(xi_1 <= x + Delta x, xi_2 <= y)
             = underbrace(P(xi_1 <= x, xi_2 <= y), =F(x, y))
                + underbrace(P(x <= xi_1 <= x + Delta x, xi_2 <= y), >= 0) $
    ]

#def[
    #defitem[Частное/ маргинальное распределение] --- распределение одной
    из компонент вектора
]

#def[
    Компоненты $xi_1, xi_2$ случайного вектора $xi = (xi_1, x_2)$ называются
    #defitem[независимыми], если $F_xi (x, y) = F_(xi_1) (x) dot F_(xi_2) (y)$
]

= Дискретные случайные векторы

#def[
    Случайный вектор $xi = (xi_1, xi_2)$ называется #defitem[дискретным], если
    $xi_1$ и $xi_2$ --- дискретные случайные величины.
]

#blk(title: [Табличный способ задания])[
    #figure(table(
        columns: 4,
        align: center,
        $$,         $y_1$,      $...$,      $y_k$,
        $x_1$,      $p_(1 1)$,  $...$,      $p_(1 k)$,
        $dots.v$,   $dots.v$,   $dots.down$,$dots.v$,
        $x_n$,      $p_(m 1)$,  $...$,      $p_(m k)$
    ))

    $ P_(i j) = P(xi_1 = x_i, xi_2 = y_j) $
]

$ P_(i dot) := sum_(j = 1)^k p_(i j) $

$ P(xi_1 = x_1) = P_(1 dot) $
$ P(xi_2 = y_1) = P_(dot 1) $

#def[
    Компоненты $xi_1, xi_2$ дискретного вектора $xi = (xi_1, xi_2)$
    #defitem[независимы], если
    $forall i j: P_(i j) = p_(i dot) p_(dot j)$
]

= Непрерывные случайные векторы

== Плотность распределения

#def[
    Неотрицательная кусочно непрерывная функция $f_xi (x, y)$, такая что
    $ F_xi (x, y) = integral_(-oo)^x integral_(-oo)^y f(t_1, t_2) d t_2 d t_1 $
    называется плотностью распределения $xi = (xi_1, xi_2)$.
]

В точках, где $F_xi (x, y)$ дифференцируема:
$ f(x, y) = (diff^2 F(x, y)) / (diff x diff y) $

=== Свойства плотности распределения

- $forall x, y: f(x, y) >= 0$
- $integral_(-oo)^(+oo) integral_(-oo)^(+oo) f(x, y) d x d y = F(+oo, +oo) = 1$
- $integral_(a_1)^(a_2) integral_(b_1)^(b_2) f(x, y) d x d y
    = F(a_2, b_2) - F(a_2, b_1) - (F(a_1, b_2) - F(a_1, b_1))
    = P(a_1 <= xi_1 <= a_2, b_1 <= xi_2 <= b_2) $
- $P(xi in D) = integral.double_D f(x, y) d x d y$
- $ F_(xi_1) (x) = F_xi (x, +oo)
    = integral_(-oo)^x integral_(-oo)^(+o) f(t_1, t_2) d t_2 d t_1 $

    $ f_(xi_1) (x) = d/(d x) F_(xi_1) (x)
        = d/(d x) integral_(-oo)^x integral_(-oo)^(+oo) f(t_1, t_2) d t_2 d t_1
        = integral_(-oo)^(+oo) f(x, t_2) d t_2 = integral_(-oo)^(+oo) f(x, y) d y $
