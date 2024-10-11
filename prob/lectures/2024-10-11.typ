#import "/utils/math.typ": *

= Непрерывные случайные величины

Нельзя задать рядом распределения

Можно задать функцией распределения

#def[
    #defitem[Плотность $f_xi (x)$] случайно величины --- такая неотрицательная
    кусочная функция, что $ forall x in R: F_xi (x) = integral_(-oo)^x f_xi (t)
    d t $
]

#def[
    Случайные величины, для которых определена плотность определения, будем
    называть #defitem[непрерывными]#footnote[
        На самом деле есть три вида величин:
        + Дискретные
        + Сингулярные
        + Абсолютно неприрывные
        Но мы рассматриваем только два вида
    ].
]

#blk(title: [*Канторова лестница*])[
    Пример функции, которая непрерывна, но плотности не имеет 

    $ F(x)= cases(
        0 ","                    &x <= 0,
        1/2 F(3 x) ","           &0 <= x <= 1/3,
        1/2 ","                  &1/3 <= x <= 2/3,
        1/2 + 1/2 F(3 x - 2) "," &2/3 <= x <= 1,
        1 ","                    &x >= 1,
    ) $
]

В точках дифференцируемости функции $F(x)$: $f(x) = F'(x)$

С какой вероятностью будет принято какое-то конкретное значение $x$:
$ f(x) = lim_(Delta x -> 0) (F(x + Delta x) - F(x)) / (Delta x) =
    lim_(Delta x -> 0) P(x < xi <= x + Delta x) / (Delta x) $
$ f(x) Delta x underbrace(=, Delta x -> 0) P(x < xi <= x + Delta x) $
Итого, ответ 0

== Свойства плотности распределения

- $forall x: f(x) >= 0$
- $integral_(-oo)^(oo) f(x) d x = F(+oo) = 1$
- $integral_(x_1)^(x_2) f(x) d x = F(x_2) - F(x_1) = P(x_1 < xi <= x_2)$
- Пусть СВ $xi$ имеет плотность распределения $f_xi (x)$, а функция $phi(x)$ ---
  монотонная, дифференцируемая, детерминированная. СВ $eta = phi(xi)$. $f_eta (y) = ?$:

    + Пусть $phi(x)$ --- монотонно возрастающая

        $ F_eta (y) = P(eta <= y) = P(phi(xi) <= y) = P(xi <= phi^(-1) (y)) 
            = F_xi (phi^(-1) (y)) $
        $ f_eta (y) = (F_eta (y))' = f_eta (phi^(-1) (y)) (phi^(-1) (y)) $

    + Пусть $phi(x)$ --- монотонно убывающая

        $ F_eta (y) = P(eta <= y) = P(phi(xi) <= y) = P(xi >= phi^(-1) (y)) 
            = 1 - F_xi (phi^(-1) (y)) $
        $ f_eta (y) = (F_eta (y))' = -f_eta (phi^(-1) (y)) underbrace((phi^(-1)
        (y)), <0) $

    + *Итого*, $f_eta (y) = f_xi (phi^(-1) (y)) abs((phi^(-1) (y))')$

- Если функция не монотонная, то нужно разделить её на интервалы монотонности и
    применить прошлый пункт

== Числовые характеристики

=== Математическое ожидание

#def[
    #defitem[Математическим ожиданием] непрерывной случайной величины $xi$
    называется число
    $ E xi = integral^(oo)_(-oo) x f_xi (x) d x, $
    если интеграл сходится абсолютно:
    $ E xi = integral^(oo)_(-oo) abs(x) f_xi (x) d x. $

    Для бесконечностей:
    - Если $f(x) > 0$ только при $x > 0$ и $integral^(oo)_(-oo) x f_xi (x) d x$
      расходится, то $E xi = +oo$
    - Если $f(x) > 0$ только при $x < 0$ и $integral^(oo)_(-oo) x f_xi (x) d x$
      расходится, то $E xi = -oo$
]

==== Свойства математического ожидания

+ $E c = c$
+ $E(c xi) = c E(xi)$
+ Если $a <= xi <= b$, то $a <= E xi <= b$.
+ $E(xi_1 + xi_2) = E(xi_1) + E(xi_2)$
+ Пусть $eta = phi(xi)$, где $phi$ --- детерминированная функция, тогда
    $E eta = integral_(-oo)^(oo) phi(x) f_xi (x) d x$

= Квантиль

#def[
    Число $z_gamma, 0 < gamma < 1$ называется #defitem[$gamma$-квантилью]
    непрерывного строго монотонного распределения $F_xi (x)$, если
    $underbrace(F_xi (z_gamma), = P(xi <= z_gamma)) = gamma$

    Для непрерывного распределения верно:
    $ integral_(-oo)^(z_gamma) f_xi (x) d x = gamma $

    Для дискретных величин в качестве квантили берут минимальное подходящее
    число:
    $ z_gamma = min { x : F(x) >= gamma } $
]

Если $forall x: f(-x) = f(x)$, то $z_gamma = -z_(1 - gamma)$.

#def[
    Квантиль уровня $0.5$ называется #defitem[медианой].
]

#def[
    Квантили уровня $0.25$ и $0.75$ называются #defitem[нижним и верхним квартилью].
]

== Примеры распределений

=== Равномерное на интервале $(a; b)$

$ xi ~ R(a, b) $

$ f(x) = cases(
    0 ","         &x in.not (a, b),
    1/(b - a) "," &x in (a, b),
) $

$ E xi = integral_a^b x dot 1/(b - a) d x = (a + b) / 2 $

$ D xi = E xi^2 - (E xi)^2
    = integral_a^b x^2 / (b - a) d x - ((a + b) / 2)^2
    = (b - a)^2 / 12 $

$ F(x) = integral_(-oo)^x f(t) d = cases(
    0 "," & x <= a,
    integral
) $
