#import "/utils/math.typ": *

= Символы Ландау

#def[
    #defitem[$f(x) = O(g(x)):$]
    $
        exists C > 0
        exists x_0 >= 0:
        forall x >= x_0:
        abs(f(x)) <= C abs(g(x))
    $
]

#def[
    #defitem[$f(x) = o(g(x)):$]
    $
        forall epsilon > 0
        exists x_0:
        forall x >= x_0:
        abs(f(x)) <= epsilon abs(g(x))
    $
]


#def[
    #defitem[$f(x) = Theta(g(x)):$]
    $
        exists 0 < C_1 <= C_2
        exists x_0:
        C_1 abs(g(x)) <= abs(f(x)) <= C_2 abs(g(x))
    $
]

== Примеры

+ $3n + 5sqrt(n) = O(n)$
+ $n = O(n^2)$
+ $n! = O(n^n)$
+ $log n^2 = O(log n)$
+ $k log k = n => k = O(?)$

= Мастер-теорема

$T(n)$ --- время работы (количество операций)

*Теор.* Пусть $
    a in NN,
    b in RR,
    b > 1,
    c >= 0 \
    T(n) = cases(
        O(1)              &" if" n <= n_0,
        a T(n/b) + O(n^c) &" otherwise"
    )
$ тогда: $ T(n) = cases(
    O(n^c)         &" if " c > log_b a,
    O(n^c log n)   &" if " c = log_b a,
    O(n^(log_b a)) &" if " c < log_b a,
) $

== Доказательство

Max глубина $= log_b n$

На $i$-ом слое: $a^i dot (n/(b^i))^c$ операций
В листьях (слой $log_b n$): $ a^(log_b n) $ операций

$
    T(n)
    = sum^(log_b n)_(k = 0) O(a^i (n/(b^i))^c)
    = O(sum^(log_b n)_(k = 0) a^i (n/(b^i))^c)
    = O(n^c sum^(log_b n)_(k = 0) (a/(b^c))^i)
$

Let $q = a/(b^c)$

$
    q < 1:
    a < b^c <=>
    c > log_b a: \
    O(n^c sum_i q^i)
    <= O(n^c sum^infinity_i q^i)
    = O(n^c dot 1/(1-q))
    = O(n^c)
$

$
    q = 1:
    O(n^c dot log_b n)
$

$
    q = 1:
    O(n^c dot (a/(b^c))^(log_b n))
    = O(n^c dot (a^(log_b n))/(b^(c dot log_b n)))
    = O(n^c dot (a^(log_b n))/(n^c)) = \
    = O(a^(log_b n))
    = O(a^((log_a n)/(log_a b)))
    = O(n^(1/(log_a b)))
    = O(n^(log_b a))
$

== Примеры

=== Merge sort
$
    T(n) = 2 dot T(n/2) + O(n)\
    a = 2\
    b = 2\
    c = 1
$

$ log_2 2 = 1 => T(n) = O(n^c log n) = O(n log n) $

=== Бинпоиск

$
    T(n) = T(n/2) + O(1)\
    a = 1\
    b = 2\
    c = 0
$

$ log_2 1 = 0 => T(n) = O(n^c log n) = O(log n) $

=== Обход полного двоичного дерева

$
    T(n) = 2 T(n/2) + O(1)\
    a = b = 2\
    c = 0
$

$ log_2 2 > 0 => T(n) = O(n^(log_b a)) = O(n^1) = O(n) $

== Обобщение

$ T(n) = a T(n/b) + O(n^c dot log^k n) $
$ c = log_b a=> T(n) = O(n^c log^(k + 1) n) $
