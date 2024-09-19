/Квант времени: время, пока программа работает подряд (без передачи управления
другим программам)

Раньше клавиатура и дисплей стали независимы, потом превратились в терминалы,
которые выводили данные во время выполнения программы

Появилась возможность *отладки*

Появляются *файловые системы* (много пользователей могут работать на одном
устройстве хранения данных)

Программа обычно считается частями: всё программу хранить в оперативной памяти
не обязательно

Появляется концепция *виртуальной памяти*: абстракция, иллюзия большой оперативной
памяти

Появилась идея *обратной совместимости*, *полной совместимости*, *линеек
устройств* (от слабых компьютеров до мейнфреймов)

Популярные линейки:
- IBM
- PDP

Обратная совместимость имеет преимущества, но и заставляет "тащить" за собой
недостатки

В опр момент IBM решили, что баги в системе править не будут, так как возникают
новые баги


=== 4-ый период (1980 -- 2005)

- 1980 год --- развитие больших интегральных схем: весь процессор мог быть на
    одном кристалле
- Первые персональные ЭВМ
- Дружественное программное обеспечение: программы пишутся для удобства
    пользователей
- Резкая деградация ОС: пропадает мультипроцессорность, защита памяти и т.д.
- Из-за роста мощности (в 90-е) деградация ОС прекращается
- Переосмысление роли сетей: из оборонки в пользовательские
- Сетевые и распределенные ОС

Сетевая ОС --- пользователь явно использует возможности сети

Распределенная ОС --- пользователь неявно использует возможности сети,
используется абстракция

Период широкого использования ЭВМ в быту, в образовании, на производстве

=== 5-ый период (2005 -- ??)

- Появление многоядерных процессоров
- Мобильные компьютеры
- Высокопроизводительные вычислительные системы
- Облачные технологии
- Виртуализация выполнения программ: выполнение программы на любом из
    компьютеров распределительной сети

Период глобальной компьютеризации

== Основные функции ОС

- Планирование заданий и использование процессора
- Обеспечение программ средствами коммуникации и синхронизации (межпроцессорные
    коммуникации)
- Управление памятью
- Управление файловой системой
- Управление вводом-выводом
- Обеспечение безопасности

Дальше в курсе будем изучать, как эти функции выполняются по отдельности и
совместно

= Архитектурные особенности построения ОС

== Внутреннее строение ОС

- Монолитное ядро:
    - Каждая процедура может вызывать каждую
    - Все процедуры работают в привилегированном режиме
    - Ядро совпадает со всей операционной системой (вся ОС всегда сидит в
      оперативной памяти)
    - Точки входа в ядро --- системные вызовы
    - #table(
        columns: 2,
        table.header([*+*, *-*]),
        [
            - Быстродействие
        ],
        [
            - Нужно много памяти
            - Невозможность модификации без полной перекомпиляции
        ]
    )

- Многоуровневая (Layered) система:
    - Процедура уровня $K$ может вызывать только процедуры уровня $K - 1$
    - [Почти] все уровни работают в привилигировнном режиме
    - Ядро [почти] совпадает со всей операционной системой
    - Точка входа --- верхний уровнеь
    - #table(
        columns: 2,
        table.header([*+*, *-*]),
        [
            - Легкая отладка (при удачном проектировании)
        ],
        [
            - Медленно
            - Нужно много памяти
            - Невозможность модификации без полной перекомпиляции
        ]
    )

- Микроядерная (microkernel) архитектура:
    - Функции микроядра:
        - взаимодействие между программами
        - планирование испльзования процессора
        - ...
    - Микроядро --- лишь малая часть ОС
    - Остальное --- отдельные программы-"менеджеры", раб в пользовательском режиме
    - Всё общение через микроядро
    - #table(
        columns: 2,
        table.header([*+*], [*-*]),
        [
            - Только ядро --- "особенное"
            - Легче отлаживать и заменять компоненты
        ],
        [
            - Ядро перезагружено --- bottleneck
            - Всё очень-очень медленно работает
        ]
    )

- Виртуальные машины
    - У каждого пользователя своя копия hardware
    - Пример:
        - Реальное hardware
            - Реальная ОС
                - Виртуальное hardware - Linux - Пользователь 1
                - Виртуальное hardware - Windows 11 - Пользователь 1
                - Виртуальное hardware - MS-DOS - Пользователь 1
    - #table(
        columns: 2,
        table.header([*+*], [*-*]),
        [ 
            - Удобно
        ],
        [
            - Медленно из-за многоуровневости
        ]
    )

- Экзоядерная (новая микроядерная) архитектура:
    - Функции экзоядра:
        - взаимодействие между программами
        - выделение и высвобождение физических ресурсов
        - контроль прав доступа
    - Весь остальной функционал выкидывается в библиотеки

Подходы *не* используются в чистом виде

= Понятие процесса. Операции над процессами

== Процесс

Термины "программа" и "задание" были придуманы для статических объектов

Для динамических объектов будем использовать "процесс"

Процесс характеризует совокупность:
- набора исполняющихся команд
- ассоциированных с ним ресурсов
- текущего момента его выполнения (контекст)

Процесс $eq.not$ программа, которая исполняется тк:
- одна программа может использовать несколько процессов
- один процесс может использовать несколько программ
- процесс может исполнять код, которого не было в программе

== Состояние процесса

// TODO: diagram состояние процесса

Процесс сам состояния не меняет, его переводит ОС, совершая "операцию"
