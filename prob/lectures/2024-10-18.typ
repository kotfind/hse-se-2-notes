#import "/utils/math.typ": *

#blk[
    Пусть есть генератор случайно величины $xi ~ R(0; 1)$.

    Хотим получить случайную величину $eta ~ F_eta (y)$

    $ eta = F_eta^(-1) (xi) $

    Обратная функция всегда существует т.к. $F$ возрастает
]

=== Экспоненциальное (показательное) распределение

$ xi ~ E(lambda), lambda > 0 $

$ f(x) = cases(
    lambda e^(-lambda x) "," & x >= 0,
    0 ","                    & x < 0
) $

$ E xi = integral_0^oo x lambda e^(-lambda x) d x =
    = { "по частям" } =\
    = underbrace(-e(-lambda x) |_0^oo, 0)
        + 1/lambda underbrace(integral_0^(+oo) lambda e^(-lambda x) d x, = 1 "(из усл. нормировки)")
    = 1/lambda $

$ D xi = E xi^2 - 1/lambda^2
    = integral_0^oo x^2 lambda e^(-lambda x) d x - 1/lambda^2 
    = ... = 2/lambda^2 - 1/lambda^2 = 1/lambda^2 $

$ F(x) = cases(
    0 "," & x <= 0,
    integral_0^x lambda e^(-lambda x) d t
        = -e^(-lambda t) |_0^x= 1 - e^(-lambda x) "," & x >= 0
) $

#blk(title: [Характеристическое свойство экспоненциального распределения])[
    Пусть:
    $ xi ~ E(lambda) $
    Тогда:
    $ forall t > 0 forall tau > 0: P(xi > t + tau | xi > t) = P(xi > tau) $

    #proof[
        $ P(xi > t + tau | xi > t) = P(xi > t + tau) / P(xi > t)
            = (1 - F(t + tau)) / (1 - F(t)) =\
            = (e^(-lambda (t + tau)))/(e^(-lambda t)) = e^(-lambda tau)
            = 1 - F(tau) = P(xi > tau) $
    ]

    Из непрерывных только экспоненциальное обладает этим свойством.
    Из дискретных --- только геометрическое.
]

Пример применения: теория массового обслуживания (например, обслуживание
клиентов, обработка интернет-запросов)

=== Распределение Гаусса (Нормальное распределение)

$ xi ~ N(m, sigma^2) $

$m$ --- математическое ожидание

$sigma^2$ --- дисперсия

$ f(x) = 1/(sqrt(1 pi) sigma) exp(- (x-m)^2 / (2 sigma^2)) $

Симметрична относительно прямой $x = m$

$ f_max = f(m) = 1/(sqrt(1 pi) sigma) $
$ lim_(x -> plus.minus oo) f(x) = 0 $

При увеличении $sigma$ график становится шире, но ниже.

Интеграл от $f(x)$ не берется, $F(x)$ записать нельзя, поэтому используют таблички.

$ E xi = integral_(-oo)^(+oo) x f(x) d x
    = integral_(-oo)^(+oo) x/(sqrt(2 pi) sigma) exp(- (x-m)^2 / (2 sigma^2)) d x
    = integral_(-oo)^(+oo) (x - m + m)/(sqrt(2 pi) sigma) exp(- (x-m)^2 / (2 sigma^2)) d x =\
    = integral_(-oo)^(+oo) underbrace((x - m)/(sqrt(2 pi) sigma) exp(- (x-m)^2 / (2 sigma^2)), "нечетная") d x
        + m underbrace(integral_(-oo)^oo f(x) d x, = 1)
    = m $

$ D xi = integral_(-oo)^(+oo) (x - m)^2/(sqrt(1 pi) sigma) exp(- (x-m)^2 / (2 sigma^2))
    = {y = (x - m) / sigma} =\
    = 2 sigma^2 integral_0^(+oo) y^2 / sqrt(2 pi) exp(- y^2/2) d y
    = 2 sigma^2 (
        underbrace(y / sqrt(2 pi) exp(- y^2 / 2) |_0^(+oo), = 0)
        - underbrace(integral_0^oo f(y) d y, = 1/2)
    ) = sigma^2 $

=== Стандартное распределение Гаусса

Чтобы использовать таблички, используем *стандартное* гауссовское распределение.

$ xi ~ N(0; 1) $

$ f(x) = 1/sqrt(2 pi) exp(- x^2 / 2) $

#figure(
    caption: [Купюра с изображением гауссовского распределения],
    image("deutsche_mark_gauss.jpg", height: 5cm)
)

==== Уравнение Лапласса

$ Phi_0 (x) = integral_0^x exp(-t^2/x)/sqrt(2 pi) d t $

Очень быстро стремится к нулю (для числа пять почти равна нулю (до 7-ого знака))

$ Phi_0 (+oo) = 1/2 $
$ Phi_0 (-x) = - Phi_0 (x) $
$ -1/2 <= Phi_0 (x) <= 1/2 $

$ Phi(x) := F(x) = Phi_0 (x) + 1/2 $

==== Вероятность попадания в заданный интервал

Хотим посчитать вероятность попадания $xi$ в интервал $(alpha, beta)$.

Общий случай:
$ P(alpha < xi < beta) = {y = (x - m)/sigma; d y = 1/sigma d x }
    = integral_((alpha - m) / sigma)^((beta - m)/sigma) exp(- y^2 / 2) / sqrt(2 pi)
    = Phi_0((beta - m) / sigma) - Phi_0((alpha - m) / sigma) $

Если интервал симметричен относительно $m$
$ P(abs(xi - m) < delta) = Phi_0 (delta / sigma) - Phi_0 (- delta / sigma)
    = 2 Phi_0 (delta / sigma) $

Правило трех сигм:
$ P(abs(xi - m) < 3 sigma) = 2 Phi_0 ((3 sigma) / sigma)
    = 2 Phi_0 (3) approx 0.997 $

Т.е. почти все значение лежат в промежутке $(-3 sigma, 3 sigma)$.
