#import "/utils/math.typ": *

== Очереди сообщений

Примитивы обмена информацией
+ `send(address, message)`: отправить сообщение `message` в очередь `address`

    Блокируется при попытке записи в полный буфер
+ `receive(address, message)`: получить сообщение `message` из очереди `address`

    Блокируется при чтении из пустого буфера. Получение сообщений в порядке FIFO

Работают атомарно

Обеспечивают взаимоисключение при работе с буфером

=== Задача Producer--Consumer

#grid(
    columns: 2,
    row-gutter: 5pt,
    [Producer:], [Consumer:],

    // Producer
    ```c
    while (1) {
        produce_item();
        send(address, item);
    }
    ```,

    // Consumer
    ```c
    while (1) {
        receive(address, item);
        consume_item();
    }
    ```
)

== Эквивалентность механизмов

Все механизмы синхронизации эквиваленты: имея один механизм можно написать все
другие

=== Мониторы Хора через семафоры Дейкстры

```c
Semaphore mut_ex = 1; // Для организации взаимоисключения

// При входе в монитор
void mon_enter(void) {
    P(mut_ex);
}

// Для выхода по return (в конце метода)
void mon_exit(void) {
    V(mut_ex);
}

// Для каждой условной переменной
Semaphore c_i = 0;
shared int f_i = 0;

// Для операции wait на условной переменной i
void wait(i) {
    f_i += 1;
    V(mut_ex);
    P(c_i);
    f_i -= 1;
}

// Для операции signal
void signal_exit(i) {
    if (f_i) {
        V(c_i);
    } else {
        V(mut_ex);
    }
}
```

=== Очереди сообщений через Семафоры Дейкстры

```c
// Для очереди сообщений A
Semaphore Amut_ex = 1;
Semaphore Afull = 0;
Semaphore Aempty = N; // N - системный размер буфера
```

#grid(
    columns: (1fr, 1fr),
    align: center,
    row-gutter: 15pt,

    ```c
    void send (A, msg) {
        P(Aempty);
        P(Amut_ex);
        put_item(A, msg);
        V(Amut_ex);
        V(Afull);
    }
    ```,

    ```c
    void receive(A, msg) {
        P(Afull);
        P(Amut_ex);
        get_item(A, msg);
        V(Amut_ex);
        V(Aempty);
    }
    ```
)

=== Семафоры Дейкстры через Мониторы Хора

```c
Monitor sem {
    unsigned int count;
    Condition c;

    void P(void) {
        if (count == 0) {
            c.wait;
        }
        count -= 1;
    }

    void V(void) {
        count += 1;
        c.signal;
    }

    { count = N; }
}
```

=== Семафоры Дейкстры через Очереди сообщений

```c
void Sem_init(int N) {
    int i;
    создать очередь сообщений m;
    for (int i = 0; i < N; ++i) {
        send(M, msg);
    }
}

void Sem_P() {
    receive(M, msg);
}

void Sem_V() {
    send(M, msg);
}
```

== Пример решения задачи

В лесу стоит пустая бочка меда. Прилетают пчелы и кладут по капле.
Только одна пчела может класть каплю меда.

Медведь ест полную бочку меда. Пчела, положившая последнюю каплю, кусает
медведя, чтобы позвать его есть мед.

=== Через семафоры

Нужно понять, где процессы могут уходить в ожидание:
- Пчела, когда другая пчела в бочке
- Пчела, когда бочка полная
- Медведь, когда бочка пуста

```c
Semaphore bee = 1;
Semaphore bear = 0;
shared int Count = 0;
```

#grid(
    columns: (1fr, 1fr),
    align: center,
    row-gutter: 15pt,

    [Пчела:], [Медведь:],

    ```c
    while (1) {
        P(bee);
        Count++;
        if (Count == N) {
            V(bear);
        } else {
            V(bee);
        }
        // улетает за медом
    }
    ```,

    ```c
    while (1) {
        P(bear);
        Count = 0;
        V(bee);
        // идет бродить
    }
    ```
)

=== Через очереди сообщений

```c
shared int Count = 0;
MessageQueue bee, bear;
```

#grid(
    columns: (1fr, 1fr),
    align: center,
    row-gutter: 15pt,

    [Пчела:], [Медведь:],

    ```c
    while (1) {
        receive(bee, m);
        Count++;
        if (Count == N) {
            send(bear, m);
        } else{
            send(bee, m);
        }
        // улетаем за медом
    }
    ```,

    ```c
    send(bee, m);
    while (1) {
        receive(bear, m);
        Count = 0;
        send(bee, m);
        // идет бродить
    }
    ```
)

=== Через мониторы

```c
Monitor bb {
    Condition cbee, cbear;
    int Count;

    void bee() {
        if (Count == N) {
            cbee.wait;
        }
        Count++;
        if (Count == N) {
            cbear.signal;
        } else {
            cbee.signal;
        }
    }

    void bear() {
        if (Count != N) {
            cbear.wait;
            Count = 0;
            cbee.signal
        }
    }

    { Count = 0; }
}
```
#grid(
    columns: (1fr, 1fr),
    align: center,
    row-gutter: 15pt,

    [Пчела:], [Медведь:],

    ```c
    while (1) {
        bb.bee();
        // летим за медом
    }
    ```,

    ```c
    while (1) {
        bb.bear();
        // идет бродить
    }
    ```
)

= Планирование процессов

Нужно распределить ограничить ресурсы между многими потребителями. Для этого
нужно:
+ Поставить цель планирования (*критерий*)
+ Придумать *алгоритм*, который опирается на некоторые *параметры* системы

== Уровни планирования

- *Долгосрочное планирование* (например, планирование заданий)

    Обычно на процессоре пытаются поддерживать фиксированное число работающих
    заданий. Это число называется *степенью мультипрограммирования*.
    Тогда новое задание появляется только, когда завершается другое. Решение о
    запуске задач принимается редко и надолго.

- *Среднесрочное планирование* (например, swapping)

    Не завершившийся процесс временно выкачивают из оперативной памяти в
    постоянную. Потом когда-то возвращают.

- *Краткосрочное планирование* (например, планирование запуска процессов)

    Решение принимается часто, каждый квант времени (каждые ~100мс).

== Цели планирования

- *Справедливость*: все процессам давать примерно одинаковое число времени

- *Эффективность*: ЦП загружен на 100% (на практике обычно не достигается)

    Иногда на процессоре запускают IDLE процесс (работающий вхолостую)

- *Сокращение* [среднего] *полного времени выполнения* (turnaround time)

- *Сокращение времени ожидания* (waiting time): часть времени от turnaround
  time, когда мы не исполняемся

- *Сокращение времени отклика* (response time): время от момента нажатия до
  появления реакции

- Существуют некоторые другие цели

Цели друг другу противоречат

== Желаемые свойства алгоритмов

- *Предсказуемость*: можно заранее оценить время работы программы; программа
  всегда должна работать примерно одно и то же время

- *Минимизация накладных расходов* (overhead)

- *Равномерность загруженности* вычислительной системы

- *Масштабируемость*: небольшое увеличение нагрузки не должно приводить к
  резкому ухудшению характеристик

== Параметры планирования

- *Статические* (со временем не меняются): используются алгоритмами
  долгосрочного планирования

    - Статические параметры вычислительной системы (например, объем ОЗУ)

    - Статические параметры процесса: известны ещё до запуска (например, кем
      запущен, степень важность, требуемые ресурсы)

- *Динамические* (меняются со времением): используются алгоритмами всех уровней
  планирования

    - Динамические параметры вычислительной системы (например, объем свободной
      ОЗУ в данный момент)

    - Статические параметры процесса (например, уже использованное процессорное время)

#def[
    #defitem[CPU Burst] --- куски программы, которые могут непрерывно выполняться на
    процессоре (без работы с *IO Burst*).
]

== Когда нужно делать краткосрочное планирование?

- Вынужденное принятие решений
    - "исполнение" $->$ "закончил исполнение"
    - "исполнение" $->$ "ожидание"
- Невынужденное принятие решений
    - "исполнение" $->$ "готовность"
    - "ожидание" $->$ "готовность"

Типы планирования:
- *Невытесняющее*: принимаем только вынужденные решения
- *Вытесняющее*: принимаем только и вынужденные, и невынужденные решения

== Конкретные алгоритмы

=== FCFS (First Come -- First Served) (невытесняющий)

Все готовые процессы выстраиваются в очередь FIFO.
Когда освобождается место, мы берем процесс из головы очереди, новые добавляем в
конце.

*Преимущество*: Очень простой

*Недостаток*: результирующие характеристики очень зависят от порядка появления
процессов
