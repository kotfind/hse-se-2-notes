= Задачи

== Задача 1 

$ F(x) = cases(
    0.0 "," & x<=3,
    0.2 "," & -3<x<=1,
    0.4 "," & 1<x<=2,
    1.0 "," & x>2,
) $

#figure(
    caption: [Ряд распределения],
    table(
        columns: 4,
        $x$, $-3$, $1$, $2$,
        $p$, $0.2$, $0.2$, $0.2$
    )
)

== Задача 2 

#figure(
    caption: [ряд распределения],
    table(
        columns: 5,
        $x$, $0$, $1$, $2$, $3$,
        $P$, $C^0_7 dot C^3_8 / C^3_15 = 56/455$, $... = 196/455$, $... = 168/455$, $... = 35/455$
    )
)

$ E(x) = 0 dot 56/455 + 1 dot 196/455 + 2 dot 168/455 + 3 dot 35/455 = 1.4 $
$ D(x) = 3 dot 7 / 15 dot (1 - 7 / 15) dot (1 - 7-1 / 15-1) = 0.64 $

Общий вид (напоминание):

$ p = C^m_M dot C^n-m_N-m / C^n_N $

$ M(x) = n dot M / N $

$ D(x) = n dot M / N dot (1 - M / N) dot (1 - n-1/N-1) $


== Задача 3

$N = 7, M = 4, n = 4$

#figure(
    caption: [ряд распределения],
    table(
        columns: 5,
        $x$, $1$, $2$, $3$, $4$,
        $P$, $4/35$, $18/35$, $12/35$, $1/35$
    )
)


ВАЖНО: здесь нельзя использовать формулу гипергеометрической вероятности, тк
наше распределение начинается с 1 (не с 0)

$ M = 1 dot 4 / 35 + 2 dot 18 / 35 + 3 dot 12 / 35 + 4 dot 1 / 35 = 2.217 $

$ D = 0.49 $


== Задача 4 

$ P(x > 3) = 1 / 3 $

$ F_x(3) - ? $

$ P(x<3) + P(x=3) + P(x>3) = 1 $

$ F_x (3) = P(x<3) = 1 - P(x>3) = 2/3 $

== Задача

$ p = 0.8 $

#figure(
    caption: [ряд распределения],
    table(
        columns: 3,
        $x$, $2$, $3$,
        $P$, $p$, $1-p$
    )
)

$ M(x) = 2 p + 3 (1 - p) = 2.2 $

TODO: complete the graph

$ M(x^2) =4 dot 0.8 + 9 dot 0.2 = 5 $
$ D(x) = M(x^2) - (M(x))^2 = 5 - 4.84 = 0.16 $
$ sigma(x) = 0.4 $

== Задача

#figure(table(
    columns: 4,
    [], [Вклад], [Годовых], [Вероятность банкротства], 
    $A$, $20$, $40%$, $0.3$,
    $B$, $18$, $30%$, $0.2$
))

$X$ --- сумма вклада

Через год:

$x_1 = 0$ --- оба банкрота

$x_2 =28$ --- банкрот $B$

$x_3 = 23.4$ --- банкрот $A$

$x_4 = 51.4$ --- нет банкрота

#figure(table(
    columns: 5,
    $X$, $0$, $23.4$, $28$, $51.4$,
    $p$, $0.05$, $0.24$, $0.14$, $0.56$
))

$ M(x) = 38.32 $
$ M(x^2) = 1720.672 $
$ D(x) = 252.2496 $

== Задача

$ N = 2000, p = 0.001 $
$ "П"(a) = "П"(1) $
$ P(x = 2) = 1/(2! e) = 0.184 $
$ P(x >= 2) = 1 - P(0) - P(1) = 1 - 1/e - 1/e = 0.264 $

== Задача

$ N = 1000 $ --- всего деталей
$ n > 2 $ --- система работает, пока 
$ q = 0.998 $ --- безотказная работа одной детали
$ p = 0.002 $
$ x ~ "П"(2) $
$ E(x) = ... $
