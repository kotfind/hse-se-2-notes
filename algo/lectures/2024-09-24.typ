#import "/utils/math.typ": *

= Детерминированные и вероятностные алгоритмы

== Детерминированные алгоритмы

#def[
    #defitem[Сложность] --- максимальное время работы на данных размера $n$.
]

#def[
    #defitem[Сложность в среднем] --- математическое ожидание количества
    действий.

    Для конечномерных: $ E = sum_(x in chi) P(x) dot "cut"(x) $
    Для бесконечномерных: \*какой-то интеграл\*
]

От бесконечномерного случая часто можно перейти к конечномерному. Например, в
случае сортировок делать сжатие координат (превращать )

== Вероятностные алгоритмы

#def[
    #defitem[Вероятностные алгоритмы] --- алгоритмы, которые при одних выходных
    данных могут иметь разное время работы или разный вывод. Используют
    генератор случайных чисел.
]

*Виды вероятностных алгоритмов*:
- *Без ошибки*: всегда выдает правильный ответ
- *С односторонней ошибкой*: ошибается только в одну сторону

    Пример: вероятностные алгоритмы проверки на простоту

- *С двусторонней ошибкой*: ошибается в обе стороны

#def[
    #defitem[Ожидаемое время работы] --- математическое ожидание времени работы
    (для конкретного набора входных данных)
]

#def[
    #defitem[Ожидаемая сложность] --- максимальное ожидаемое время на данных
    размера $n$.
]

== $k$-ая порядковая статистика (вероятностный)

Выбрали случайный опорный элемент, разделили массив на две части по опорному:
$ underbrace(..., m - 1 "элемент") <= x_i <= underbrace(..., n - m "элементов") $

Медиана будет либо опорным элементом, либо элементов в бОльшем куске.

Оценим ожидаемое время работы. Если массив разбился на куски по $m - 1$ и $n - m$
$ T(n) = underbrace(T(max(m - 1, n - m)), "в худшем случае ищем в большем куске")
    + underbrace(O(n), "на разделение по опорному") $

Итого:
$ E(T(n)) &= sum^n_(m=1) P(n) E(T(max(m - 1, n - m))) + O(n)
    = sum^n_(m = n/2) 1/n dot 2 E(T(m)) + O(n) = \
    &= 2/n sum_(m = n/2)^(n - 1) E(T(m)) + O(n)
    = 2/n (O(n/2) + ... + O(n - 1)) + O(n) = \
    &= 2/n O((3n^2) / 8) + O(n)
    = O(3/4 n) + O(n) = O(n) $

== $k$-ая порядковая статистика (детерминированный)

+ Делим массив на чанки размера 5
+ Сортируем каждый чанк: $7/5 n$ действий
+ Берем медиану каждого чанка: $m_1 , ... , m_(n/10)$
+ Ищем медиану медиан рекурсивно
+ Используем найденное число в виде опорного элемента в прошлом алгоритме

$ T(n) = underbrace(T((7n)/10), "прошлый алгоритм")
    + underbrace(T(n/5), "рекурсия")
    + underbrace(O(n), "разделение")
    -> T(n) = O(n) $

== Алгоритм Фрейвалдса

Правда ли, что $A dot B = C$? ($A$, $B$ и $C$ даны)

Берем случайный вектор из $0$ и $1$: $v = (""_0^1, ""_0^1, ..., ""_0^1)$

Если $A B = C$, то $A dot (B dot v) = C dot v$

Алгоритм с односторонней ошибкой. Если получили равенство, то
вероятность неудачи не больше одной второй

Можно повторит процедуру и улучшить вероятность. За $k$ испытаний получаем
вероятность $P_"неуд" <= 1/(2^k)$, а сложность $O(k n^2)$.

== Лемма Шварца-Зиппеля

$f(x_1 , ... , x_k)$ --- многочлен степени $n$

Считаем, что умеем находить значение $f$ в точке

Хотим проверить, является ли он тождественным нулем

+ Берем случайный набор данных $(y_1 , ... , y_k) in S^k$
+ Для ненулевого $f: P(f(y_1, ...,  y_n) = 0) <= n/abs(S)$

== Дерандомизация

Превращение вероятностного алгоритма в детерминированный

Для леммы Шварца-Зиппеля и $k = 1$ достаточно проверить $n + 1$ разную точку
