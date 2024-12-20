= Переход от ковариационной матрицы к корреляционной

#let cov = "cov"

$ cov(x, y) = mat(
    0.37, 0.51, 0.11;
    0.51, 0.25, 0.31;
    0.11, 0.31, 0.4
) $

$ D_1 = 0.37; D_2 = 0.25; D_3 = 0.4 $

$ r_(x y) = mat(
    1,   0.51 / (sqrt(0.37) sqrt(0.25)), 0.11/(sqrt(0.37) sqrt(0.4));
    ...,                              1,                         ...;
    ...,                            ...,                           1;
) $

= Задачи

== Задача

Гауссовский вектор: $xi = (xi_1, xi_2)$

$ E xi = (-4, 2) $
$ cov(xi_1, xi_2) = mat(
     0.6,  -0.2;
    -0.2,   0.4;
) $

$ eta = 3 xi_1 - 4 xi_2 $
$ r_(eta xi) - ? $
$ P(eta > -15) - ?$

=== Решение

== Задача

$ xi ~ N(m, sigma^2) $
$ M = (4; -1) $
$ xi = (xi_1, xi_2) $
$ cov = mat(
    20, 20;
    20, 40;
) $

Найти:
$P(xi_1 - 3 xi_2 > 5) - ?; r_(xi eta) - ?;$

=== Решение
