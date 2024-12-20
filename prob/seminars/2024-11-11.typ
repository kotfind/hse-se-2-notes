= Задачи

== Задача

$ x ~ N(0; 1) $

- 
    $ F_0 (x) = Phi_0 (x) + 1/2 $

    $ P(x > epsilon) = 2 Phi_0 (x) $

    $ Phi_0 (1.29) = 0.4074 $

    $ 2 Phi_0 (1.29) >= 0.8 $

- $...$

== Задача

+ Вероятность *не* заболеть 0.9998
+ Из 10000 не менее четырех = ?
+ Матожидание и дисперсия числа заболевших = ?

$ q = 1 - 0.9998 = 0.0002 $

$ a = n q = 2 $

$ x ~ "П"(q) = "П"(2) $

$ P(x = k) = (a^k) / (k!) e^(-a) $

$ P(0) = e^(-q) = exp(0.0002) = 0.135 $

$ P(1) = a dot e^(-a) = 0.274 $

$ P(2) = a^2 / 2 dot e^(-a) = 0.27 $

$ P(3) = a^3 / 6 dot e^(-a) = 0.183 $

$ P(A) = 1 - P(0) - P(1) - P(2) - P(3) = ... $

== Задача

$ f(x) = cases(
    c/x"," &x in (1, 3),
    0"," &x in.not(1, 3)
) $

$ integral_1^3 f(x) d x = c integral_1^3 1/x d x = c ln x |_1^3
    = c (ln 3 - ln 1) = 1 $
$ c = 1/(ln 3) $

$ E x = integral_1^3 x dot c / x d x = c integral_1^3 d x = 2 / (ln 3) $

$ E x^2 = integral_1^3 x^2 c/x d x  = c integral_1^3 x d x
    = 1/(ln 3) (x^2/2 |_1^3) = 4/(ln 3) $

$ D x = E x^2 - (E x)^2 = 4/(ln 3) - 4/((ln 3)^2) $

$ P(x > 2) = c integral_2^3 1/x d x = (ln 3 - ln 2) / (ln 3) $

== Задача

- $ x ~ N(500, sigma^2) $
- $ P(|x - 500| <= 9.8) = 0.95 $
- $ P(x < 480) = ? $

- $ P(|x - 500| <= 9.8) = 2 Phi_0 (9.8 / sigma) $

    $ Phi_0 (9.8 / sigma) = 1/2 dot 0.95 = 0.475 $

    По таблице: $ 9.8 / sigma = 1.95 $

    $ sigma = 5 $

    $ P(-oo < x < 480) = Phi((480 - 500) / sigma) - Phi(-oo)
        = Phi(-4) + Phi(oo) = ... $

== Задача

$ f(x) = 1/sqrt(pi) e^(-(x + 5)^2) $
$ E(3 - 2 x + 4 x^2) = ? $

=== Решение

$ sigma = 1/sqrt(2)$

$ E = -5 $

$ E x^2 = D + (E x)^2 $

$ E(3) - 2 E(x) + 4 E(x^2) = 115 $

== Задача

$ x ~ N(0; 1) $
$ P = 0.7 $
$ x_0.25 $

=== Решение

$ P(|x - a| < epsilon) = 2 Phi(epsilon/sigma) = 0.7 $
$ Phi(epsilon) = 0.35 $
Ищем $epsilon$ из таблицы

$ ... $

== Задача

Отрезок $L = 35$ поделили на части по $25$ и $10$. Бросают три точки.

$x$ --- число точек, попавших на 10.

Построить график $F(x)$, найти $M(x), D(x)$.

=== Решение

$ x ~ "Ber"(5/7) $

#figure(table(
    columns: 5,
    align: center,
    $x$, $0$, $1$, $2$, $3$,
    $p$, $0.364$, $0.437$, $0.1749$, $0.0233$,
))

== Задача

Вероятность ошибки $p = 0.21$

Наименьшее число измерений $N_"min"$, чтобы с $P > 0.92$ хотя бы один
результат неверный

=== Решение

$ 1 - P_"все верные" = 1 - 0.79^2 > 0.92 $
$ 0.08 >= 0.79^n $
$ n >= log_(0.79) 0.08 approx 10.5 $
$ n >= 11 $
