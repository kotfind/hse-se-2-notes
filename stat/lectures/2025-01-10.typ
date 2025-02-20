#import "/utils/math.typ": *

= Введение

- Теория вероятностей: по известной модели ищем параметры
- Математическая статистика: по наблюдаемой величине строим модель

= Определения

#def[
    #defitem[Однородной выборкой] объема $N$ называется случайный вектор $X =
    (X_1, ...,  X_n)$, компоненты которого --- независимые и одинокого
    распределенные.

    _Примечание_: в ближайшее время будем обсуждать только *однородные* выборки.
]

#def[
    Компоненты однородной выборки называются #defitem[элементами выборки].
]

#def[
    Если все элементы выборки $X_1, ...,  X_n$ выборки имеют распределение $F_xi
    (x)$, то говорят, что #defitem[выборка соответствует распределению $F_xi (x)$ или
    выборка порождена случайной величиной $xi$].

    _Примечание_: обычно $F_xi (x)$ мы не знаем. Часто известно только семейство
    распределения: например, "гауссово" или "непрерывное".
]

#def[
    Детерминированный вектор $x = (x_1, ...,  x_n)$, где $X_i$ есть реализация
    СВ $X_i, i = overline(1 ... n)$ называется #defitem[реализацией выборки $X$].
]

#def[
    #defitem[Выборочным пространством] $S$ называется множество всех возможных
    реализаций выборки.
]

#def[
    Пара $(S, cal(F))$, где $cal(F)$ -- семейство распределений, порождающих
    $X$, называется #defitem[моделью].
]

#def[
    Упорядочим реализацию $x_((1)) <= x_((2)) <= ... <= x_((n))$.

    Пусть СВ $X_(k)$ есть такой элемент выборки, реализация которого, который при любой реализации
    $X_1, ...,  X_n$, принимает значение $X_((k))$.

    Тогда пос-ть $X_((1)), ...,  X_((n))$ называется #defitem[вариационным
    рядом] выборки, а $X_((k))$ --- $k$-ой порядковой статистикой.
]

#def[
    Порядковые статистики $X_((1))$ и $X_((n))$ называются #defitem[экстремальными].
]

Когда мы зафиксируем конкретную реализацию, $X_((i))$ станет числом, до этого
$X_((i))$ --- СВ.

== Эмпирическая функция распределения

#def[
    Пусть $X_1, ...,  X_n$ соответствует распределению $F_xi (x)$,
    тогда функция:
    $ accent(F, hat)_n (x) = 1/n sum_(k = 1)^n I(x_k <= x) $
    называется #defitem[эмпирической функцией распределения].
]

=== Свойства

- $E accent(F, hat)_n (x) = P(x_k <= x) = F_xi (x) $
- По УЗБЧ:
    $ 1/n sum_(k = 1)^n I(x_k <= x) ->_(n -> oo)^"п. н." F_xi (x) $

= Гистограмма

$x_1, ...,  x_n$ --- реализация

Для построения гистограммы:
+ Разбить $R^1$ на $m + 2$ не пересекающихся интервала
+ Обычно рассматривают *размах* выборки $r = x_((n)) - x_((1))$
+ Первый и последний интервалы ($(-oo, x_((1)))$ и $(x_((n)), +oo)$) пустые,
    остальные --- длинны равной $Delta = r / m$
+ Для каждого интервала вычисляем частоту попаданию в него: $nu_k$
+ На каждом интервале строим прямоугольник высотой $h_k = nu_k / Delta$

При увеличении $m$ гистограмма стремится к плотности.

#blk(title: [Гистограмма ростов])[
    $
        x_((1)) = 163\
        x_((39)) = 203\
        m = 5\
        r = 203 - 163 = 40\
        Delta = 8\
    $

    #figure(table(
        columns: 3,
        align: center,
        table.header[*Интервал*][*Частота*][*Высота*],
        $[163, 171)$, $ 8/39$, $...$,
        $[171, 179)$, $11/39$, $...$,
        $[179, 187)$, $18/39$, $...$,
        $[187, 195)$, $ 1/39$, $...$,
        $[195, 203)$, $ 1/39$, $...$,
    ))
]

100 наблюдений = ~7 интервалов
