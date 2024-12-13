#import "/utils/math.typ": *

= Неравенство Берри-Эссена

Пусть $xi_1, ...,  xi_n$ --- независимые, одинокого распределены и $D xi_i < oo$,
$ eta_n = (sum_(i = 1)^n xi_i - E sum_(i = 1)^n xi_i) / sqrt(sum_(i = 1)^n xi_i) $
То
$ sup_x abs(F_eta_n (x) - Phi(x)) <= (C dot E abs(xi_1 - m_1)^3) / (sqrt(n)
sigma^3) $

Где $C$ --- некоторая константа, которая постоянно уточняется. Сейчас известно,
что $1/sqrt(2 pi) <= C < 0.478.$

= Закон больших чисел (ЗБЧ)

Говорят, что случайная последовательность $xi_1, ...,  xi_n$ удовлетворяет ЗБЧ,
если
$ 1/n sum_(i = 1)^n xi_i - 1/n sum_(i = 1)^n E xi_i ->^P_(n -> oo) 0 $

== Теорема Чебышева

Пусть $xi_1, ...,  xi_n$ некоррелированы и $D xi_1, ...,  D xi_n$ ограничены в
совокупности (т.е. $exists C > 0: forall k: D xi_k <= C$), тогда ЗБЧ.

#proof[
    $ forall epsilon > 0:
        P(abs(1/n sum_(i = 1)^n xi_i - 1/n sum_(i = 1)^n E xi_i) > epsilon)
        <= D(1/n sum_(i = 1)^n xi_i) / epsilon^2 <= ...
    $

    $ D(1/n sum_(i = 1)^n xi_i)
        underbrace(=, #[т.к. некоррелированы]) 1/n^2 sum_(i = 1)^n D xi_i
        <= (C dot n) / n^2
        = C/n
    $

    $ ... <= C / (epsilon^2 dot n) ->_(n -> oo) 0 $
]

== Теорема

Пусть $xi_1, ...,  xi_n$ одинокого распределены и $D xi_i < oo$, тогда ЗБЧ.

#proof[
    $ forall epsilon > 0:
        P(abs(1/n sum_(i = 1)^n xi_i - 1/n sum_(i = 1)^n E xi_i) > epsilon)
        <= D(1/n sum_(i = 1)^n xi_i) / epsilon^2
        = (n dot D) / (n^2 dot epsilon^2)
        = sigma^2 / (n epsilon^2) ->_(n -> oo) 0
    $
]

== Теорема

Пусть $xi_k$ --- количество "успехов" в $k$ испытаниях Бернулли с вероятностью $p$.

$p^* = xi_n / n$ --- СВ, частота успеха

$ xi_n = eta_1 + ... + eta_n, #[где] eta_i ~ "Bi"(p) $

$ p^* = 1/n sum_(i = 1)^n eta_i $

$ E p^* = E(1/n sum_(i = 1)^n eta_i ) = p $
$ D eta_i = p q < oo $

По ЗБЧ:
$ p^* = 1/n xi_n ->_(n -> oo)^P p $

= Усиленный закон больших чисел

Говорят, что случайная последовательность $xi_1, ...,  xi_n$ удовлетворяет УЗБЧ,
если
$ 1/n sum_(i = 1)^n xi_i - 1/n sum_(i = 1)^n E xi_i ->^"п. н."_(n -> oo) 0 $

Если УЗБЧ, то и ЗБЧ.

== Теорема Колмогорова

Пусть $xi_1, ...,  xi_n, ...$ независимы, одинокого распределены и
$m < oo$, тогда УЗБЧ: т.е $1/n sum_(i = 1)^n xi_i ->_(n -> oo)^"п. н." m$

= Метод Монте-Карло

Пример. Хотим посчитать $integral_a^b g(x) d x$

$ xi_1, ...,  xi_n ~ R(a, b) $

$xi_1, ...,  xi_n$ независимы

По УЗБЧ: $1/n sum_(i = 1)^n g(xi_i) ->_(n -> 0)^"п. н." E g(xi_i)
    = integral_a^b g(x) underbrace(f_xi (x), 1 / (b - a)) d x$

$ I^* = (b - a) / n sum_(i = 1)^n g(xi) ->^"п. н." integral_a^b g(x) d x $

Имеет смысл применять в многомерных случаях.

$I$ --- истинное значение интеграла

$ P(|I^* - I| < delta) = p $

По ЦПТ:
$ (1/n sum_(i = 1)^n g(xi_i) - I) / sqrt(D(1/n sum_(i = 1)^n g(xi_i)))
    ->^d_(n -> oo) U,
$

где $U ~ N(0, 1)$

$ sqrt(D(1/n sum_(i = 1)^n g(xi_i))) = n/n^2 D(g(xi_1)) = (D g(xi_1)) / n $

$ P(|I^* - I| < delta) = 2 Phi_0(delta/sqrt(D(1/n sum_(i = 1)^n g(xi_i)))) = p 
    = 2Phi_0((delta sqrt(n)) / sqrt(D g(xi_1)))
$

Для применения этой формулы полезно ограничить дисперсию, а не считать её
напрямую.
