= Файлы и файловые системы (часть 2)

== Физические файлы и файловые системы

Для работы с файлами нужно уметь:
- работать с атрибутами файла
- расположение файла на внешнем носителе

Эта информация хранится в *FCB (File Control Block)*.

Где хранится FCB?:
- В записи директории с этим файлом
- Частично в директории, частично с файлом
- Частично в директории, частично в отдельной структуре
- Отдельно и от директории, и от файловой системы

== О физических носителях

Обмен информацией с носителем осуществляется не по одному байту, а по одному секторам.

Несколько (обычно первых) секторов отводятся под заголовок

Оставшиеся сектора разделяются на логические блоки

В заголовке:
- тип файловой системы
- размер заголовка
- количество блоков
- размер блока
- начальный блок корневой директории
- ...

В логических блоках хранятся данные файлов и, иногда, данный FCB

== Методы выделения блоков

*Как "раскидывать" файлы по блокам?*

Из-за системы блоков возникает внутренняя фрагментация (последний обычно
недозаполнен)

=== Непрерывное выделение

Файл лежит в блоках подряд

FCB хранится в записи директории

Преимущества:
- Чтение очень быстрое

Проблемы:
- Размещение файла при его увеличении
- Внешняя фрагментация

Аналогичен схеме динамических разделов. Есть стратегии first/ best/ worst fit

Используется для read-only файловых систем

=== Связный список

В конце блока оставляем небольшое пространство под служебную информацию, где
храним номер следующего блока

В FCB --- частично с файлом (номер следующего), частично в директории (номер
первого)

Преимущества:
- Нет внешней фрагментации

Недостатки:
- Прямой доступ сводится к последовательному. Т.е. нет random access
- Потеря памяти из-за хранения служебной информации в каждом блоке
- При потере одного из блоков (из-за поломке диска) теряется весь файл

Note: нет прямых аналогов в системах управления оперативной памятью

В прямом виде почти не применяется

=== FAT (File Allocation Table)

В табличке столько элементов, сколько блоков

Она содержит номер следующего блока

Т.е. просто перенесли служебную информацию из конца блока в отдельную структуру

FAT маленькая --- её можно полностью закачать в оперативную память и быстро
искать нужный блок

Преимущества:
- Быстро
- Нет внешней фрагментации

Недостатки:
- Если FAT потерся, то теряется информация со ВСЕГО диска, поэтому хранят три
  копии FAT

Note: нет прямых аналогов в системах управления оперативной памятью 

=== Прямая индексация

Храним табличку (массив), где последовательно храним номера физических блоков
файла

Саму табличку храним в одно из блоков. Он называется *индексным блоком* /
*блоком косвенной адресации*

=== Индексный узел

В начале индексного блока допишем атрибуты файла, получим *индексный узел*

Будем хранить его в заголовке

==== Косвенная адресация

Для больших файлов используем косвенную адресацию: индексный узел ссылается не
на блоки с данными, а на другие индексные узлы

==== Смешанная адресация

Структура индексного узла:
- Атрибуты
- Ссылки на блоки данных (прямая адресация)
- Адрес блока косвенной адресации (при необходимости)
- Адрес блока двойной косвенной адресации (при необходимости)
- Адрес блока тройной косвенной адресации (при необходимости)

При создании файловой системы фиксируется количество индексных узлов, чтобы был
фиксированный размер заголовка


== Файловая система, как часть ОС

Программные средства, которые обслуживают физическую файловую систему

=== Функции файловой подсистемы

- Распределение внешней памяти между файлами. Учет занятого и свободного
  пространства
- Идентификация файлов. Связывание: Имя файла $->$ расположения
- Операции над файлами
- Защита от несанкционированного доступа
- Совместный доступ
- Надежность

=== Распределение и учет

- Подсистема ОС делает начальное форматирование
- Модификация содержимого FCB
- Учет свободных логических блоков:
    - Битовый вектор: для каждого блока --- занят/ не занят
    - Связный список: в некотором блоке храним номера свободных блоков,
        на этих "специальных" блоках делаем связных список

=== Идентификация файлов. Проблема разрешения имен

Файл: `/a/b`

- ОС разбирает полное или относительное имя файла
- Читается FCB корневой директории
- В FCB корня
    - Проверяем, что `/a` --- существует
    - Проверяем, что `/a` --- директория
    - Читаем, расположение `/a`
- В FCB `/a`
    - Проверяем, что `/a` --- существует
    - Проверяем, что `/a` --- файл
    - Читаем, расположение `/a`

При каждом запросе чтения/ записи делать разрешение имени файла неэффективно.
Для этого функция `open` закачивает нужные данные в оперативу

Т.е. можно обойтись без `open`, но работать будет медленно

= Системы управления вводом-выводом

Виды деятельности компьютера:
- Обработка информации
- Ввод-вывод информации

С точки зрения программиста:
- Обработка информации: выполнение команд над данными, которые лежат в любом из
  уровней памяти
- Остальное --- обмен данными между памятью и внешними устройствами

С точки зрения оперативной системы:
- Обработка информации: выполнение команд над данными, которые лежат в уровне
  памяти *не ниже оперативной памяти*
- Остальное --- обмен данными между памятью и внешними устройствами

Далее предполагаем, что оперативы бесконечно $=>$ точки зрения совпадают

== Архитектура компьютера. Общие сведения

Есть:
- Процессор
- Память
- Диски
- Монитор
- Клавиатура

Всё это объединено *линиями*

Линии похожих целей объединяют в *шины*

*Локальная магистраль* --- совокупность шин

Основные шины:
- Шина данных
- Шина адреса
- Ширина управления и состояния

*Ширина шины* --- количество проводников в шине

=== Передача данных из процессора в память

- На адресной шине выставляется адрес
- На шине данных выставляются данных
- На шине управление выставляется "работа с оперативной памятью",
    на шине состояния выставляется направление "от оперативной памяти"

С памятью работать просто:
- Она локализована в пространстве
- Ячейки взаимнооднозначно отображаются на линейное адресное пространство

Другие устройства ввода-вывода подключаются через специальные точки входа -- *пОрты*.
Одному устройству может соответствовать несколько портов.

Если интерфейс работы с устройством совместим с интерфейсом памяти, то память
отображается в остальную память системы

=== Передача данных от процессора в порт

- На адресной шине выставить адрес порта ввода-вывода
- На шине данных выставить данные
- На шине управления выставить сигналы работы ввода-вывода и операции записи