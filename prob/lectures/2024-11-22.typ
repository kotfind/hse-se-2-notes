#import "/utils/math.typ": *

= Условные распределения

== Для дискретных величин

#figure(table(
    columns: 4,
    align: center,
    $$,         $y_1$,      $...$,      $y_k$,
    $x_1$,      $p_(1 1)$,  $...$,      $p_(1 k)$,
    $dots.v$,   $$,         $$,         $$,
    $x_m$,      $p_(m 1)$,  $...$,      $p_(m k)$
))

$ P(xi = x_i | eta = y_i)
    = P(xi = x_i and eta = y_i) / P(eta = y_i)
    = p_(i j) / p(dot i) $

#def[
    Набор вероятностей $p_(i j) / p_(dot j), forall i = 1...m$ называется
    #defitem[условным распределением вероятности] $xi$ при условии ${eta = y_i}$.
]

#def[
    #defitem[Условной функцией распределения] $xi$ при условии ${eta = y_i}$
    называется $ F_xi (x | y_i) = P(xi <= x | eta = y_i) $
]

#def[
    #defitem[Условным математическим ожиданием] $xi$ при условии ${eta = y_i}$
    называется
    $ E(xi | eta = y_i)
        = sum_(i = 1)^m x_i P(xi = x_i | eta = y_i)
        = sum_(i = 1)^m x_i p_(i j) / p_(dot j) $
]

- Если $eta$ уже зафиксирована, то $E(xi | eta = y_i)$ --- число.
- Если $eta$ ещё неизвестна, то $E(xi | eta)$ --- функция от аргумента $eta$.

#figure(table(
    columns: 4,
    align: center,
    $E(xi | eta)$, $E(xi | eta = y_i)$, $...$, $E(xi | eta = y_k)$,
    $P$,           $p_(dot 1)$,         $...$, $p_(dot k)$
))

== Формула полного матожидания
$ E(E(xi | eta)) = E(xi) $

#proof[
    $ E(E(xi | eta)) = sum_(j = 1)^k  E(xi | eta = y_j) p_(dot j)
        = sum_(j = 1)^k sum_(i = 1)^m x_i p_(i j) / p_(dot j) p_(dot j) 
        = sum_(i = 1)^m x_i sum_(j = 1)^k p_(i j)
        = sum_(i = 1)^m x_i p_(i dot) = E xi
    $
]

== Для непрерывных величин

#def[
    Пусть $f(x, y)$ и $f_eta (y)$ --- непрерывны в точке $y$ и $f_eta (y) > 0$.
    Тогда #defitem[условной функцией распределения] $xi$ при условии ${eta = y}$
    называется функция
    $ F_xi (x | y)
        = lim_(Delta y -> 0+) P(xi <= x | y < eta <= y + Delta y) $
]

Корректность определения:
$ F_xi (x | y)
    &= lim_(Delta y -> 0+) P(xi <= x | y < eta <= y + Delta y)
    = lim_(Delta y -> 0+) P(xi <= x and y < eta <= y + Delta y) / P(y < eta <= y + Delta y) =\
    &= lim_(Delta y -> 0+)
        (integral_(-oo)^x integral_y^(y + Delta y) f (t, s) d s d t)
        / (integral_y^(y + Delta y) f_eta (s) d s)
    = {#stack(
        spacing: 5pt,

        [По теореме о среднем значении],

        $ s', s'' in (y; y + Delta y) $,

        $ Delta y -> 0 => s', s'' -> 0 $
    )} =\
    &= lim_(Delta y -> 0+)
        (Delta y integral_(-oo)^x f(t, s') d t)
        / (Delta y f_eta (s''))
    = (integral_(-oo)^x f(t, y) d t) / (f_eta (y)) $

#def[
    Пусть $f(x, y), f_eta (y)$ непрерывны в точке $y$ и $f_eta (y) > 0$.
    Функция $f_eta (x | y)$ называется #defitem[условной плотностью] $xi$
    при условии ${eta = y}$, если 
    $ F_xi (x | y) = integral_(-oo)^x f_xi (t | y) d t $
]

В точках дифференцируемости функции $F_xi (x | y)$:
$ F(x | y) = (F_xi (x | y))'_x $

#blk[
    *Утв:* $xi$ и $eta$ независимы, если $f(x | y) = f_xi (x)$

    #proof[
        $ f_xi (x | y)
            = ((integral_(-oo)^x f(t, y) d t) / (f_eta (y)))'_x
            = f(x, y) / (f_eta (y)) $
    ]
]

#blk(title: [Пример])[
    Пусть $(xi, eta)$ распределена равномерно в круге радиуса $R$ с центром в
    $(0, 0)$.

    $ f(x, y) = match(
        1 / (pi R^2),   x^2 + y^2 <= R^2;
        0,              x^2 + y^2 > R^2;
    ) $

    $ f_eta (y)
        = integral_(-sqrt(R^2 - y^2))^sqrt(R^2 - y^2) 1/(pi R^2)
        = match(
            (2 sqrt(R^2 - y^2)) / (pi R^2), abs(y) < R;
            0,                              abs(y) > R;
        ) $

    $ forall y space (abs(y) < R):
        f_xi (x | y)
        = f(x, y) / (f_eta (y)) = match(
            1/(2 sqrt(R^2 - y^2)), -sqrt(R^2 - y^2) < x < sqrt(R^2 - y^2);
            0;
        ) $

    Получаем равномерное распределение

    $ E(xi | eta = y) $
]

== Свойства условного матожидания

- $E(c | eta) = c$
- $E(c xi | eta) = c E(xi | eta)$
- $E(phi(xi) psi(eta) | eta) = psi(eta) E(phi(xi) | eta)$
- Пусть $xi$ и $eta$ независимы, тогда $E(xi | eta) = E(xi)$
- Формула полного матожидания: $E(E(xi | eta)) = E(xi)$

    #proof[
        $ E(E(xi | eta))
            &= integral_(-oo)^(+oo) (
                    integral_(-oo)^(+oo) x f(x | y) d x
                ) f_eta (y) d y =\
            &= integral_(-oo)^(+oo) integral_(-oo)^(+oo)
                x f(x, y) / cancel(f_eta (y)) cancel(f_eta (y)) d x d y
            = integral_(-oo)^(+oo) x f_xi (x) d x =\
            &= E xi
        $
    ]
