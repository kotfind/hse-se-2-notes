#import "../../utils/math.typ": *

= Геометрическое определение вероятности

Рассматриваем подмножества на $RR^n$, которые имеют конечную меру

Пример эксперимента: попадет ли случайная точка в подмножество

#figure(image("./geom_prob.svg", height: 5cm))

$ P(A) = mu(A) / mu(Omega)$

#def[
    События #defitem[несовместны] --- $A dot B = emptyset$
]

== Св-ва $P(A)$

+ $P(A) >= 0 forall A subset Omega$
+ $P(Omega) = 1$
+ если $A_1$ и $A_2$ несовместны, то $P(A_1 + A_2) = P(A_1) + P(A_2)$

== Задача

$x$ --- время прихода Джульеты

$y$ --- время прихода Ромео

$abs(x - y) < 1\4$

#figure(image("./romeo.svg", height: 5cm))

$ P(overline(A)) = mu(overline(A))/mu(Omega) = (9/16)/1 $
$ P(A) = 1 - 9/16 = 7/16 $

= Частотное (статистическое) определение

Пусть опыт проведен $N$ раз, и событие произошло $m_A$ раз. Тогда *частота*
события $A$: $nu(A) = m_A/N$

$ P(A) = lim_(N -> oo) m_A/N $

= Аксиоматическое определение Колмагорова

Пусть $cal(A)$ --- $sigma$-алгебра событий на пространстве $Omega$. Числ функция $P:
cal(A) -> RR^1$ --- вероятность, если:
+ $forall A in cal(A) P(A) >= 0$ --- аксиома неотрицательности
+ $P(Omega) = 1$ --- условие нормировки
+ если $A_1, ..., A_n, ...$ попарно несовместны, то
    $P(sum_(i=1)^oo A_i = sum_(i=1)^oo P(A_i)$

Число $P(A)$ называется вероятностью соб-я $A$

Тройка $(Omega, cal(A), P)$ --- вероятностное пространство

== Свойства $P(A)$

+ $P(overline(A)) = 1 - P(A)$

    Док-во:
    
    $ Omega = A + overline(A) $
    $ A dot overline(A) = emptyset $
    $ 1 = P(Omega) = P(A + overline(A)) = P(A) + P(overline(A)) $

+ $P(emptyset) = 1 - P(Omega) = 0$
+ $A subset B => P(A) <= P(B)$

    Док-во:
    
    $ B = A + (B \\ A) $
    $ P(B) = P(A + (B \\ A)) = P(A) + underbrace(P(B \\ A), >=0) $

+ $ forall A: 0 <= P(A) <= 1 $

+ Теорема сложения: $P(A + B) = P(A) + P(B) - P(A dot B)$

    Док-во:

    $ A = A Omega = A B + A overline(B) $
    $ B = B Omega = A B + overline(A) B $
    $ A + B = underbrace(
            A B + A overline(B) + overline(A) B,
            "попарно несовместны"
        ) $

    $ P(A) = P(A B) + P(A overline(B)) => P(A) - P(A B) = P(A overline(B)) $
    $ P(B) = P(A B) + P(overline(A) B) => P(B) - P(A B) = P(overline(A) B) $
    $ P(A + B)
        = P(A B) + P(A overline(B)) + P(overline(A) B) 
        = P(A B) + P(A) - P(A B) + P(B) - P(A B)
        = P(A) + P(B) - P(A B) $

+ Обобщение теоремы сложения:
    $ P(underbrace(A_1 + A_2, A) + underbrace(A_3, B))
        = P(A) + P(B)
        = P(A_1) + P(A_2) + P(A_3) - P(A_1 A_2) - P(A_1 A_3) - P(A_2 A_3) + P(A_1 A_2 A_3) $

    $ P(sum_i A_i)
        = sum_i P(A_i)
        - sum_(i < j) P(A_i A_j)
        + sum_(i < j < k) P(A_i A_j A_k)
        - ...
        + (-1)^(n+1)P(A_1 ... A_n) $

= Условная вероятность

#figure(image("./cond_prob.svg", height: 5cm))

Переходим из $Omega$ в $B$

Пусть $A, B in Omega$ и $P(B) != 0$, тогда вероятность $A$ при условии $B$:
$ P(A|B) = P(A B) / P(B) $

#def[
    $A$ и $B$ #defitem[независимые], если $P(A|B) = P(A)$
]

#def[
    $A$ и $B$ #defitem[независимые], если $P(A B) = P(A)P(B)$
]

Любые несовместные события зависимы
// TODO: proof utils
