#import "/utils/math.typ": *

= Формула Байеса

$ P(H_i | A) = P(A H_i) / P(A)
    = (P(H_i) P(A | H_i)) / (sum_(j = 1)^n P(H_j) P(A | H_j)) $

$ sum_(i = 1)^n P(H_i) = 1 $

$ sum_(i = 1)^n P(H_i | A) = 1 $

== Задача

#figure(
    caption: [Условие],
    table(
        columns: 3,
        table.header[*Завод*][*Процент поставленных деталей*][*Вероятность
            исправной детали*],
        [№ 1], $65%$, $0.9$,
        [№ 2], $35%$, $0.8$,
    )
)

$A$ --- деталь с дефектом оказалась в самолете

$H_1$ --- деталь взяли и 1-ого завода
$ P(H_1) = 0.65 $
$ P(A | H_1) = 0.1 $

$H_2$ --- деталь взяли и 2-ого завода
$ P(H_1) = 0.35 $
$ P(A | H_1) = 0.2 $

$ P(A) = P(H_1) P(A | H_1) + P(H_2)P(A | H_2) = 0.65 dot 0.1 + 0.35 dot 0.2 $
$ P(H_1 | A) = (P(H_1) P(A | H_1)) / P(A) = 65 / 135 = 0.48 $
$ P(H_2 | A) = (P(H_2) P(A | H_1)) / P(A) = 70 / 135 = 0.52 $

= Случайные величины

#def[
    #defitem[Случайная величина (СВ)] --- величина, которая после эксперимента принимает
    заранее неизвестное значение.

    Числовая функция $xi: Omega-> RR$, которая удовлетворяет условию
    измеримости #footnote[почти всегда исполняется]:
    $ forall x in RR: { omega: xi(omega) <= x } in cal(A) $
]

#figure(
    caption: [Пример с кубиком],
    table(
        columns: 6,
        stroke: none,
        $Omega = {$, $omega_1,$, $omega_2,$, $...,$, $omega_6$, $}$,
        $$, $arrow.b$, $arrow.b$, $$, $arrow.b$, $$,
        $xi = {$, $1,$, $2,$, $...,$, $3$, $}$,
    )
)

#def[
    #defitem[Функция распределения (вероятностей)] случайно величины $xi$
    называется функция $ F_xi (x) = P(omega: xi(omega) <= x) $
]

Свойства $F(x)$:
+ $F(+oo) = 1$

    $F(-oo) = 0$

    $forall x: 0 <= F(x) <= 1$

+ $F(x)$ не убывает: $x_1 < x_2 => F(x_1) <= F(x_2)$

+ $F(x)$ непрерывна справа:

    $ F(x_0) = lim_(epsilon -> 0+) F(x_0 + epsilon), $
    где $x_0$ --- точка разрыва

Если некоторая $F(x)$ удовлетворяет условиям, то она является функцией
распределения некоторой величины.

Случайные величины:
- Дискретные
- Непрерывные

= Дискретные случайные величины

#def[
    Случайную величину называют #defitem[дискретной], если множество её
    возможных значений конечно или счетно.
]

#def[
    #defitem[Ряд распределения] для дискретной СВ --- табличка из $xi$ в $P$:

    #figure(
        table(
            columns: 5,
            $xi$, $x_1$, $x_2$, $...$, $x_n$,
            $P$,  $p_1$, $p_2$, $...$, $p_n$,
        )
    )
]

#blk(title: "Пример")[
    #figure(
        table(
            columns: 4,
            $xi$, $-1$, $0$, $2$,
            $P$, $0.2$, $0.3$, $0.5$,
        )
    )

    $ x < -1: F(x) = 0 $
    $ F(-1) = 0.2 $
    $ F(-0.5) = 0.2 $
    $ F(0) = 0.2 + 0.3 $
    $ F(2) = 1 $
    $ x > 2: F(x) = 1 $
]

== Числовые характеристики дискретных случайных величин
=== Математическое ожидание

#def[
    #defitem[Математическим ожиданием $E$ (среднее значение)] дискретной СВ $xi$
    называется число $ E xi = sum_(i = 1)^oo x_i p_i $

    Предполагается, что ряд $sum_(i = 1)^oo abs(x_i) p_i$ сходится
]
