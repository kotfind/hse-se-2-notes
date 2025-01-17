#import "/utils/math.typ": *

= Выборочные моменты

$ X_1, ..., X_n ~ F(x, theta) $

#def[
    #defitem[$k$-ым начальным моментом] называется:
    $ mu_k^\^ = 1_n sum_(i = 1)^n x_i^k $
]

#def[
    #defitem[Выборочное среднее]:
    $ mu_1^\^ = overline(x) $
]

#def[
    #defitem[$k$-ым центральным выборочным моментом] называется
    $ nu_k^\^ = 1/n sum_(i = 1)^n (x_i - overline(x))^k $
]

#def[
    #defitem[Выборочная дисперсия]: $s^2 := nu_2^\^$
]

#def[
    Пусть $(x_1, y_1), ..., (x_n, y_n) ~ F(x, y, theta)$

    #defitem[Выборочная ковариация]:
    $ K_(x y)^\^ = 1/n sum_(i = 1)^n (x_i - overline(x)) (y_i - overline(y)) $
]

#def[
    #defitem[Коэффициент выборочной ковариации]:
    $ rho_(x y)^\^ = K_(x y)^\^ / sqrt(S_x^2  S_y^2) $
]

== Свойства выборочных моментов

- $ E mu_k^\^= E(1/n sum_(i = 1)^n x_i^k) = 1/n sum_(i = 1)^n E(x_i^k) = E x_1^k
  = mu_k $

  $ E overline(x) = m_(x_i) $

- $ D mu_k^\^
    = 1/(n^2) sum_(i = 1)^n D(x_i^k)
    = (D x_1^k) / n
    = 1/n (E x_1^(2k) - (E x_1^k)^2)
    = 1/n (mu_(2 k) - mu_k^2) $

    Чем больше выборка, тем меньше дисперсия

- $ D overline(x) = (sigma^2 x) / n $

- По УЗБЧ:
    $ mu_k^\^ = 1/n sum_(i = 1)^n x_i^k ->_(n -> oo)^"п.н." E mu_k^\^ = mu_k $

- По УЗБЧ:
    $ nu_k^\^ ->^"п.н." nu_k $

- По ЦПТ:
    $ (mu_k^\^ - mu_k) / sqrt((mu_(2k) - mu_k^2) / n)) ->_(n -> oo)^P U ~ N(0; 1) $

    $ (sqrt(n) (overline(x) - m_(x_1))) / sigma ->_(n -> oo)^d U $

- $ E s^2 = E(1/n sum_(i = 1)^n (x_i - overline(x))^2) = (n - 1)/n sigma^2 $

- $ E K_(x y)^\^ = (n - 1)/n "cov"(x, y) $

= Оценка параметра

#def[
    #defitem[Оценкой $theta^\^$ параметра $theta$] называется функция $theta =
    T(x_1, ...,  x_n)$, не зависящая от $theta$.
]

#def[
    Оценка $theta^\^$ называется #defitem[несмещенной], если $E theta^\^ =
    theta$, если $forall theta in Theta$.
]

#def[
    Оценка $theta^\^ (x_1, ..., x_n)$ называется #defitem[асимптотически несмещенной], если
    $lim_(n -> oo) E theta^\^ (x_1, ..., x_n) = theta$.
]

#def[
    #defitem[Несмещенная (исправленная) выборочная дисперсия]:
    $ s^(2\~) = 1/(n - 1) sum_(i = 1)^n (x_i - overline(x))^2 $
]

#def[
    Оценка $theta^\^$ называется #defitem[состоятельной], если
    $ theta^\^ (x_1, ...,  x_n) ->_(n -> oo)^P theta $
]

#def[
    Оценка $theta^\^$ называется #defitem[сильно состоятельной], если
    $ theta^\^ (x_1, ...,  x_n) ->_(n -> oo)^"п.н." theta $
]

#def[
    #defitem[Эффективная оценка] --- оценка с минимальной дисперсией среди
    несмещенных.
]

== R-эффективные оценки

$ x_1, ...,   x_n ~ f(x, theta), theta in Theta subset R^1 $

#def[
    Назовем модель $(S, f(x, theta))$ регулярной, если

    + функция $f(x, theta) = f(x_1, ...,  x_n, theta) > 0 forall x in s$ и
        дифференцируема по $theta$
    + $ diff / (diff theta) integral_delta f(x, theta) d x
        = integral_s diff/(diff theta) f(x, theta) d x $
      $ diff / (diff theta) integral_s T(x) f(x, theta) d x
        = integral_s diff / (diff theta) T(x) f(x, theta) d x $
]

Пусть $T(x) = T(x_1, ...,  x_n)$ --- несмещенная оценка параметра $theta$
$ 0 = integral_s diff / (diff theta) f(x, theta) d x $
$ 1 = integral_s diff / (diff theta) T(x) f(x, theta) d x $

#def[
    #defitem[Информация Фишера] о параметре $theta$, содержащейся в выборке,
    называет величина
    $ I_n (theta) = E ((diff ln f(x, theta))/(diff theta))^2
        = integral_s ((diff ln f (x, theta))/(diff theta)) f(x, theta) d x $
]

#blk(title: [Теорема Рао-Крамера])[
    Если $(s, f(x, theta))$ --- регулярная модель и $theta^\^$ --- несмещеная
    оценка $theta$, то
    $ D theta^\^ >= 1/(I_n (theta)) $
]

#blk(title: [Неравенство Коши-Буянковского])[
    $ (integral phi_1 (x) phi_2 (x))
        <= integral phi_1^2 (x) d x integral phi_2^2 (x) d x $
]

#proof[
    *Рао-Крамера*
    $ 0 = integral_s diff / (diff theta) f(x, theta) d x
        = integral (diff f(x, theta)) / (diff theta) (f(x, theta))/(f(x, theta)) d x
        = integral (diff ln f(x, theta)) / (diff theta) f(x, theta) d x $
    $ 1 = integral_s diff / (diff theta) T(x) f(x, theta) d x
        = integral T(x) (diff f(x, theta)) / (diff theta) (f(x, theta))/(f(x, theta)) d x
        = integral T(x) (diff ln f(x, theta)) / (diff theta) f(x, theta) d x $

    $ 1 = integral (T(x) - theta) (diff ln f(x, theta)) / (diff theta) f(x, theta) d x
        = {#stack(
            $ phi_1 (x) = (T(x) - theta) sqrt(f(x, theta)) $,
            $ phi_2 (x) = (diff ln f(x, theta)) / (diff theta) sqrt(f(x, theta)) $
        )} <= \
        <= integral (T(x) - theta)^2 f(x, theta) d x
            integral ((diff ln f(x, theta)) / (diff theta))^2 f(x, theta)
        = D theta^\^ I_n (theta) $
]

#def[
    Несмещенная оценка называется #defitem[R-эффективной], если её дисперсия
    равная $1/(I_n (theta)).$
]
