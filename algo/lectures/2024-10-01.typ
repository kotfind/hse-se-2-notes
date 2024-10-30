#import "/utils/math.typ": *

== Время работы quicksort-а

Случайно выбираем опорный элемент $x$

Мысленно отсортируем массив:
$ a_1, a_2, ..., a_n --> b_1, b_2, ..., b_n $

Опорный элемент $x$ сравнивается со всем и исключается из работы.
Значит, два элемента никогда не сравниваются больше одного раза.

Пусть $delta_(i j) = "int"(b_i " сравнивали с " b_j)$.
Для времени работы считаем количество сравнений:
$ E(T(n)) = E(sum_(i = 0)^(n-1) sum_(j = i + 1)^n delta_(i j))
    = sum sum E(delta_(i j)) = sum sum P(b_i " сравнивали с " b_j) $

Два элемента $b_i$ и $b_j$ НЕ будут сравниваться, если между ними когда-то
выбирался опорный. Они будут сравниваться только, если среди элементов
$b_i, ...,  b_j$ первым был выбран $i$-ый или $j$-ый.

$ E(T(n)) = sum_(i = 0)^(n-1) sum_(j = i + 1)^n 2/(j - i + 1)
    = sum_(i = 0)^(n - 1) sum_(k = 1)^(n - i) 2/(k + 1)
    = sum_(i = 0)^(n - 1) 2 underbrace((1/2 + 1/3 + ... + (n - i + 1)), O(log n))
    = O(n log n) $

== Skip List

Вероятностная структура данных на основе list-а и операциями, как у дерева
поиска

Элементы лежат по возрастанию. Есть фиктивные элементы $-oo$ и $oo$
в начале и конце.

$ -oo -> -4 -> 0 -> 1 -> 3 -> 7 -> 12 -> 15 -> +oo $

Хотим прыгать по списку большими шагами, а не только шагами по 1.

Делаем новый список ("уровень"), в который включаем элементы данного с
вероятностью $P = 1/2$. Бесконечности всегда переходят на новый уровень.

В каждом элементе храним указатель направо и вниз. Отдельно храним указатель на
$-oo$ верхнего уровня.

#figure(
    caption: [Структура списка],
    table(
        columns: 18,
        stroke: none,
        align: center,
                  [], $arrow.b$, $$, $$, $$, $$, $$, $$, $$, $$, $$, $$, $$, $$, $$, $$, $$, $$,
        [Уровень 2:], $-oo$, $->$, $-4$, $->$, $ $, $  $, $ $, $  $, $ $, $  $, $7$, $->$, $  $, $  $, $  $, $  $, $+oo$,
        [Уровень 1:], $-oo$, $->$, $-4$, $->$, $ $, $  $, $ $, $  $, $3$, $->$, $7$, $->$, $  $, $  $, $15$, $->$, $+oo$,
        [Уровень 0:], $-oo$, $->$, $-4$, $->$, $0$, $->$, $1$, $->$, $3$, $->$, $7$, $->$, $12$, $->$, $15$, $->$, $+oo$,
    )
)

Операции:
- Поиск: спускаемся по дереву
- Удаление: удаляем из всех слоев
- Добавление: случайно выбираем в каких слоях элемент будет, а в каких --- нет (количество
    слоев может увеличиться), потом добавляем.

Способы реализации:
- multiple nodes: несколько уровней с node-ами
- fat nodes: один уровень, но в каждой node-е несколько указателей

Преимущество перед деревом:
- Легко пишется
- Легко распараллеливается (можно вставлять несколько элементов одновременно)
- Легко печатается

$ P("есть i-ый уровень") = 1 - (1 - 1/(2^i))
    underbrace(<=, "неравенство бернули") 1 - (1 - n/(2^i)) = n / (2^i) $

$ i = 4 log_2 n: P(i) <= n/(2^(4 log n)) = n/(n^4) = 1/(n^3) $

=== Модификации Skip List-а

- $p != 1/2$.
    - количество слоев: $log_(1/p) n$
    - $O(1/p log_(1/p) n)$
    - Лучший вариант $p = 1/e$, но на практике, вероятно, бесполезно.
- Можно сделать только два слоя: получим корневую декомпозицию

== Метод имитации отжига

Пытаемся минимизировать некоторую величину -- функционал качества (например, какой-нибудь путь в графе,
расставить на доску ферзей, которые друг друга не бьют).

Будем пытаться улучшить значение функционала: $Q_0 -> Q_1 -> ...$

#blk(title: [Плохой способ])[
    Будем рандомно генерировать новое состояние и переходить на него только,
    если оно лучше.

    Не работает, так как можно попасть в локальный минимум, а не глобальный.
]

Вводим понятие температуры $T_i$, функции, которая как-то убывает с каждой итерацией.

Делаем случайное, небольшое изменение. Если функционал стал меньше, то
переходим, иначе переходим с вероятностью:
$ P = e^(-(Q_(i + 1) - Q_i) / T_i) $

Идея в том, что изначально (когда $T_i$ большое) у нас плохое состояние и не
страшно его "потерять", перепрыгнув в другое. Потом (когда $T_i$ маленькое),
состояние более хорошее и перепрыгивать мы хотим меньше.
