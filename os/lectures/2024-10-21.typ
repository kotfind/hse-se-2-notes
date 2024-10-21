#import "/utils/math.typ": *

== Функции ОС и Hardware
- Отображение логического адресного пространства процесса на физическое адресное
  пространство
- Распределение физической памяти между конкурирующими процессами
- Контроль доступа к адресным пространствам процессов
- Выгрузка процессов (целиком или частично) во внешнюю память (swapping)

== На конкретных примерах

=== Однопрограммная система

Есть адресное пространство: от `0` до `max`

ОС либо в младших адресах (в самом начале), либо в старших адресах (в самом
конце)

=== Фиксированные разделы

ОС в младших адресах

Всю свободную память (кроме памяти ОС) разобьем на несколько участков --
разделов (обычно разных размеров). К каждому разделу своя очередь процессов (в
зависимости от того, сколько памяти хочет процесс).

#blk(title: [Организация больших программ])[
    Что делать, если программе нужно данных больше, чем размер раздела или даже
    размер всей оперативной памяти?

    Оба следующих способа используют принцип локальности

    - *Оверлейная структура*

        Программа разбивается на несколько кусочков -- оверлеев. В памяти сидит
        только загрузчик оверлеев и один оверлей.

    - *Динамическая загрузка процедур*

        Загружаются в память не все функции, а только те, которые вызываются.
        Если функция давно не исполнялась, то её можно выкинуть из памяти.
]

Может возникнуть ситуация, когда какой-то раздел простаивает. Поэтому используют
одну общую очередь заданий (для всех разделов).

Количество параллельно обрабатываемых заданий не превышает число разделов.

#def[
    #defitem[Эффект внутренней фрагментации] --- потеря части памяти, которую мы
    процессу выделили, но которую он на самом деле не использует.
]

=== Динамические разделы

Пусть есть память с ячейками $0, 2, 3, ..., 1000$

ОC занимает ячейки $0, ..., 200$

Новым процессам будем выделять нужное количество памяти. Кусок памяти, выделенный под данный процесс -- это динамический раздел.

В таком случае происходит фрагментация: появляется много маленьких незанятых
кусков.

ОС поддерживает список свободных мест.

*Стратеги размещения нового процесса в памяти*:
- *First-fit* (первый подходящий). Процесс размещается в первое подходящее по
  размеру пустое место.
- *Next-fit* (следующий подходящий). Аналогично First-fit, но ищем не с нулевого
  адреса, а с того, на котором остановились в прошлый раз.
- *Best-fit* (наиболее подходящий). Выбираем наименьшее пустое место, куда влезает.
- *Worst-fit* (наименее подходящий). Процесс размещается в наибольшее свободное
  пустое место.

Стратегии примерно эквивалентны по результату.

#def[
    #defitem[Эффект внешней фрагментации] --- невозможность использования
    свободной памяти, из-за её раздробленности.
]

Хочется "сдвинуть" все занятые места влево, чтобы все пустые места превратились
в одно большое место: это достигается благодаря логическим адресам и сборке
мусора (garbage collection).

Сборка мусора делается редко, так как стоит дорого.

В процессах Intel и AMD используются сегментные регистры:
- Физический адрес = Сегментный регистр + Логический адрес
- Передвинуть процесс: Сегментный регистр += x

Если кусок пустой памяти меньше, чем размер элемент списка пустых адресов, то
элемент списка не заводится, а память приписывается к какому-то процессу.
Возникает внутренняя фрагментация.

*\*Планирование процессов и память. Задача\**

= Более сложные схемы управления памятью

== Линейное непрерывное отображение

Проблема с фрагментацией возникает т.к. мы хотим линейно непрерывно отобразить
логическую память в физическую память.

== Схема сегментной организации

Идея: вместо одного одномерного адресного пространства ввести несколько адресных
пространств. То есть для каждой функции вводить своё адресное пространство -- в
свой сегмент. Можно разбивать как-нибудь по-другому (то есть не по функциям).

Для задания *логического* адреса нужно теперь указывать пару: `(Nseg, offset)`
-- номер сегмента и смещение в нем.

Сегменты в оперативной памяти можно разместить в произвольном порядке.

`Физический адрес = Начало(Nseg) + offset`

В `PCB` хранится *таблица сегментов*. Она содержит
- физический адрес начала сегмента
- размер сегмента
- атрибуты (биты управления доступом)

Свойственна внешняя фрагментация, но в значительно меньшей степени.

Позволяет легко реализовать shared memory:
- В физической памяти выделяется сегмент под разделяемую память.
- В логической памяти каждого процесса создается сегмент, который указывает на
  ранее выделенный общий сегмент физической памяти.
