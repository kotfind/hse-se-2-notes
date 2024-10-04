#import "/utils/math.typ": *

=== Свойства математического ожидания

+ $E c = c$
+ $E(c xi) = c E(xi)$
+ Если $a <= xi <= b$, то $a <= E xi <= b$.
+ $E(xi_1 + xi_2) = E(xi_1) + E(xi_2)$
+ Пусть $eta = phi(xi)$, где $phi$ --- детерминированная функция, тогда
    $E eta = E phi(xi) = sum_(i = 1)^n phi(x_i) p_i $

== Дисперсия

#def[
    #defitem[Дисперсией] случайной величины $xi$ называется число
    $ D xi = E (xi - E xi)^2 $
]

=== Свойства дисперсии

+ $D c = 0$
+ $D (c xi) = c^2 D(xi)$
+ $forall xi: D(xi) >= 0$
+ $D(xi) = E(xi^2 - 2 xi E(xi) + (E xi)^2) = E(xi^2) - 2 (E xi)^2 + (E xi)^2
    = E xi^2 - (E xi)^2 $ --- удобная формула для вычислений
+ $D(xi_1 + xi_2) = E(xi_1 + xi_2)^2 - (E(xi_1 + xi_2))^2 =
    E(xi_1^2) + 2E(xi_1 xi_2) + E(xi_2^2) - (E xi_1)^2 - 2 E xi_1 E xi_2 + (E xi_2)^2
    = D xi_1 + D xi_2 + 2 underbrace((E(xi_1 xi_2) - E xi_1 E xi_2), "ковариация")
    = D xi_1 + D xi_2 + 2 "cov"(xi_1, xi_2) $
+ Если $xi_1$ и $xi_2$ независимы, то $"cov"(xi_1, xi_2) = 0 ->
    D(xi_1 + xi_2) = D xi_1 + D xi_2 $

== Другие

#def[
    #defitem[Среднеквадратическое отклонение]: $sigma_xi = sqrt(D xi)$
]

#def[
    #defitem[Начальный момент порядка $k$] ($k = 1, 2, ...$): $mu_k = E xi^k$
]

$ mu_1 = E xi $

#def[
    #defitem[Центральный момент порядка $k$] ($k = 2, 3, ...$): $nu_k = E(xi - E xi)^k$
]

$ nu_2 = D xi $

#def[
    #defitem[Центрированная случайная величина]: $xi^0 = xi - E xi$
]

$ E xi^0 = 0 $

#def[
    #defitem[Нормированная случайная величина]: $xi^* = xi^0 / sigma$
]

$ D xi^* = D xi^0 / sigma = 1/(sigma^2) D xi^0 = 1 $

= Часто встречающиеся распределения

== Распределение Бернулли

$ xi underbrace(~, "имеет распределение") "Ber"(p), 0 < p < 1 $

#figure(
    table(
        columns: 3,
        align: center,
        $xi$, $0$, $1$,
        $P$, $1 - p$, $p$,
    )
)

#figure(
    table(
        align: center,
        columns: 3,
        $xi^2$, $0$, $1$,
        $P$, $1 - p$, $p$,
    )
)

$ E xi = 0 + 1 dot p = p $
$ D xi = E xi^2 - (E xi^2) = p - p^2 = p(1 - p) = p q $

== Биномиальное распределение

$ xi ~ "Bi"(n, p), 0 < p < 1 $

#figure(
    table(
        align: center,
        columns: 6,
        $xi$, $0$, $...$, $k$, $...$, $n$,
        $P$,  $...$, $...$, $C_n^k p^k q^(n - k)$, $...$, $...$,
    )
)

Матожидание. Способ 1:
$ E xi = sum_(k = 0)^n k dot C_n^k p^k q^(n - k)
    = sum_(k = 0)^n k n! / (k!(n - k)!) p^k q^(n - k)
    = n p sum_(k = 1)^n (n - 1)!/((k - 1)!(n - k)!) p^(k - 1) q^(n - k)
    = {i = k - 1} = n p sum_(i = 0)^n (n - 1)!/(i!(n - 1 - i)!) p^i q^(n - 1 - i)
    = n p dot 1 = n p $

Маожидание. Способ 2:
$ xi = xi_1 + xi_2 + xi_3 + ... + xi_n $
$ xi_i ~ "Ber"(p) $
$ E xi = E (sum_(i = 1)^n xi_i)  = sum_(i = 1)^n (E xi_i) = n p $

Дисперсия. Способ 1:
$ D xi = E xi^2 - (E xi)^2 = sum_(k = 0)^n k^2 dot C_n^k p^k q^(n - k) = ... $

Дисперсия. Способ 2:
$ D xi = D(sum_(i = 1)^n xi_i) underbrace(=, "т.к. независимы") 
    sum_(i = 1)^n D(xi_i) = n p q $

#blk(title: "Пример")[
    Бросаем монетку 10 раз.

    $ n = 10, p = 0.5 -> cases(
        E xi = 10 dot 0.5 = 5,
        D xi = 10 dot 1/2 dot 1/2 = 2.5
    ) $
]

== Распределение Пуассона

$ xi ~ "П"(lambda), lambda > 0 $

$ xi = {0, 1, 2, ...} $
$ P(xi = k) = (e^(-lambda) lambda^k) / (k!) $

Проверим условие нормировки:
$ sum_(k = 0)^oo (e^(-lambda) lambda^k) / (k!)
    = e^(-lambda) sum lambda^k / (k!) = e^(-lambda) e^lambda = 1 $

Матожидание:
$ E xi = sum_(k = 0)^oo k (e^(-lambda) lambda^k) / (k!)
    = lambda e^(-lambda) sum_(k = 1)^oo (lambda^(k - 1))/((k - 1)!)
    = lambda e^(-lambda) e^lambda = lambda $

Дисперсия:
$ D xi = E xi^2 - (E xi)^2
    = sum_(k = 0)^oo k^2 (e^(-lambda) lambda^k) / (k!) - lambda^2
    = sum_(k = 0)^oo k (e^(-lambda) lambda^k) / ((k - 1)!) - lambda^2 =\
    = lambda sum_(k = 0)^oo (k - 1 + 1) (e^(-lambda) lambda^(k - 1)) / ((k - 1)!) - lambda^2
    = lambda^2 + lambda - lambda^2 = lambda $

*Теорема Пуассона* Пусть проводятся испытания по схеме Бернулли, причем
$n -> oo$, $p -> 0$,$n p -> lambda$. Тогда
$ lim_(n -> oo) C^k_n p^k (1 - p)^(n - k) = (e^(-lambda) lambda^k)/(k!) $

#proof[
    $ lim_(n -> oo) C^k_n p^k (1 - p)^(n - k)
        = lim_(n -> oo) n! / (k! (n - k)!) p^k (1 - p)^(n - k) =\
        = lim_(n -> oo) n! / (k! (n - k)!) (lambda/n)^k (1 - lambda/n)^(n - k) =\
        = lambda^k / k! lim_(n -> oo) (n dot (n - 1) dot ... dot (n - k + 1)) / (n^k)
            (1 - lambda/n)^n / (1 - lambda/n)^k
        = 1 dot e^(-lambda) / 1 = e^(-lambda) $
]

Погрешность при замене Бернулли на Пуассона:
$ abs(C_n^k p^k q^(n - k) - (e^(-n p) (n p)^k)/k!) <= n p^2 $

== Геометрическое распределение

$ xi ~ G(p), 0 < p < 1 $

$ xi = {1, 2, ...} $
$ P(xi = k) = q^(k - 1)p $

*Смысл*: Испытание с двумя исходами. Останавливаемся, когда произошел первый
успех.

Матожидание:
$ E xi = sum_(k = 1)^oo k q^(k - 1) p = p sum_(k = 1)^oo k q^(k - 1)
    = p sum_(k = 1)^oo (q^k)' =\
    = p (sum_(k = 1)^oo q^k)' = p (q/(1 - q))' = p / (1 - q)^2 = 1/p $

Дисперсия:
$ D xi = q/(p^2) $

#blk(title: "Пример")[
    Студент знает 80% материала. Его спрашивают, пока не завалят.
    $ xi ~ G(0.2) $
]
