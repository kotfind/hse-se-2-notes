= Информация

Коллок предварительно в начале второго модуля (2 ноября, 1--4 пары)

Все задачи в контесте стоят одинокого

= Алгоритм Карацубы

Алгоритм перемножения двух многочленов (или чисел)

$ A(x) = a_0 + a_1 x + ... + a_(n-1) x^(n-1) $
$ B(x) = b_0 + b_1 x + ... + b_(n-1) x^(m-1) $

// Будем считать $deg A = deg B = n$, не $n - 1$.

$ C(x) = A(x) B(x) = c_0 + c_1 x + ... c_(n + m - 2) x^(n + m - 2) $

bruteforce (в столбик) за $O(n^2)$: $ c_k = sum^k_(i = 0) a_i dot b_(k - i) $

В Карацубе лучше останавливаться при $deg approx 16$ и перемножать в столбик

Добиваем многочлены до одинаковой длины и до степени двойки.

// TODO: add block

// TODO: add poly macro

Разобьем многочлен на два:
$ A(x)
    &= a_0 + a_1 x + ... + a_(n - 1) x^(n-1) \
    &= 
        underbrace([a_0 + a_1 x + ... + a_(n/2 - 1) x^(n/2 - 1)], A_0(x))
        + underbrace([a_(n/2) + ... + a_(n - 1) x^(n/2-1)], A_1(x)) x^(n/2) \
    &= A_0(x) + A_1(x) x^(n/2) $

$ B(x) = B_0(x) + B_1(x) x^(n/2) $

Перемножим (складываем за линию, перемножаем рекурсивно):
$ A(x)B(x)
    &= (A_0 + A_1 x^(n/2))(B_0 + B_1 x^(n/2))
    &= A_0 B_0 + (A_1 B_0 + A_0 B_1)x^(n/2) + A_1 B_1 x^n $

Найдем асимптотику:
$ T(n) = 4T(n/2) + O(n) => T(n) = O(n^2) $

Так перемножать не выгодно. Проблема в четырех произведениях.

Сокращаем число произведений до трех:
$ (A_0 + A_1)(B_0 + B_1)
    = underbrace(A_0 B_0 + A_1 B_1, "уже знаем")
        + underbrace(A_0 B_1 + A_1 B_0, "сможем найти") $

Найдем новую асимптотику:
$ T(n) = underbrace(3T(n/2), "на умножения") + underbrace(O(n), "на сложения")
    => T(n) = O(n^(log_2 3)) approx O(n^1.585) $

Так перемножать значительно быстрее.

== Длинная арифметика

$ 2105789 = 9 + 8x + 7x^2 + 5x^3 + x^5 + 2x^6 |_(x=10) $

$ a, b < 10^1000 $

Нужно делать перенос разряда.

Можно сменить систему счисления для ускорения в константу раз. Удобно брать $x = 10^n$.

== Алгоритм Штрассена

Обобщение Карацубы на матрицы

brutforce за $O(n^3)$: $C_i_j = sum^(n - 1)_(k = 0) a_(i k) b_(k j)$

$n = 2^k$

Пилим матрицу на четыре куска:
// TODO: rewrite as matrix
#table(
    columns: 2,
    stroke: none,
    $a_(1 1)$, $a_(1 2)$,
    $a_(2 1)$, $a_(2 2)$,
)

Куски будут перемножаться, как обычные матрицы.

Можно посчитать не за 8, а за 7 умножений

Посчитаем сложность:
$ T(n) = 7 T(n/2) + O(n^2) => T(n) = O(n^(log_2 7)) approx O(n^2.81) $
Выгодно только для очень больших матриц

=== Аналоги Штрассена

#table(
    columns: 3,
    table.header[*Год*][*Название*][*Асимптотика*],
    [1990], [Коперсмита-Виноградова], $O(n^(2.3755))$,
    [2020], [Алмана-Вильямса], $O(n^2.3728)$
)

*Гипотеза Штрассена*: $forall epsilon > 0:
    exists "алгоритм":
    forall n >= N:
    O(n^(2+epsilon))$

== Fast Fourier Transform (FFT)

Сложность $O(n log n)$, но с большой константой

*Основной принцип*: храним многочлен, как список его значений в некоторых точках.
Знаем $A(x_0), A(x_1), ..., A(x_(n-1))$

Коэффициенты при умножении меняются нетривиально, а значения в точках ---
намного проще, если удачно выбрать точки: $x_i = omega^i$, где $omega in CC$ или
$omega in ZZ_p$.

Проблема: переход в `double`.
