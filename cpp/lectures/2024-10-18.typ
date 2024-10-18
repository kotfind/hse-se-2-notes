= Параллельное программирование

Зачем:
- хотим выполнять разные операции в одно и то же время (например, одновременно
  считать и взаимодействовать с пользователем)
- ускорение на многоядерной системой

Параллельное или конкурентное:
- Параллельное --- хотим решить одну задачу быстрее
- Конкурентное --- есть много задач, которые мы хотим решать одновременно

Возможности C++:
- Потоки
- Асинхронный вызов
- Сопрограмммы (не совсем конкурентность)
- Параллельные алгоритмы STL

Средства создать параллельных приложений:
- Примитивы C++
- OpenMP (стандарт для написания параллельных программ)
- MPI (для кластеров)
- Сторонние библиотеки (Intel TBB, HPX)

== Параллельные алгоритмы STL

```cpp
#include <vector>
#include <algorithm>
#include <execution>

int main() {
    std::vector<int> vec{1, 5, 2, 10, 3};
    std::sort(std::execution::par, vec.begin(), vec.end());
}
```

== OpenMP

```cpp
double res[LEN];
int i;

#pragma omp parallel for num_threads(10)
for (i = 0; i < LEN; ++i) {
    res[i] = long_running(i);
}

g++ -openmp file.cpp
```

== С процессом

```c
int main(void) {
    pid_t pid;
    if (signal(SIGCHLD, SIG_IGN) == SIG_ERR) {
        exit(EXIT_FAILURE);
    }
    pid = fork();
    switch(pid) {
        case -1: // ошибка
        case 0: // родитель
        default: // родитель
    }
}
```

== Потоки (thread)

С функцией:
```cpp
void do_some_work();
std::thread my_thread(do_some_work);
```

С функтором:
```cpp
void do_some_work();
struct X {
    void operator()() { ... }
}

std::thread my_thread{X()};
```

У нового thread-а и его родителя общее адресное пространство.
До удаления std::thread нужно сделать либо:
- `join()` --- блокируемся до завершения
- `detach()` --- отсоединяем процесс, он работает в фоне

Отсоединенный (detach) процесс завершится либо сам, либо вместе с main

```cpp
#include <thread>
#include <iostream>

void f() {
    for (size_t i = 0; i < 100; ++i) {
        std::cout << i << std::endl;
    }
}

int main() {
    std::thread t(f);
    t.detach(); // ничего не выведетя
    // t.join(); // так выведется всё
}
```

=== Передача аргументов
```cpp
void f(int val);
struct X {
    f(int val);
};

// Вызов функции
std::thread t1(f, 42):

// Вызов метода
X obj;
std::thread(&X::f, &obj, 42);
```

Аргументы копируются во внутреннее хранилище, а затем передаются, как r-value.

=== Проблемы с life-time-ом
```cpp
void f(int*);

void caller() {
    int data[100];
    std::thread t(f, data); // UB: data умирает раньше завершения f
    t.detach();
}
```

=== Полезные вещи
- `std::thread`
- `std::thread::hardware_concurrency()`
- `std::this_thread::get_id()`
- `std::this_thread::sleep_for(/* time */)` --- надо делать так, ибо обычный
  `sleep` усыпит весь процесс (все thread-ы)
- `std::this_thread::sleep_until(/* ... */)`
- `std::this_thread::yield()`

=== Проблема совместного доступа

Всё хорошо только тогда, когда есть
- либо только много читающих thread-ов
- либо только один пишущий thread

=== Алгоритм Дейкстры (нет, другой)

```
status[i] in {competing, out, crit}
turn in {1, ..., N}
repeat
    while turn != i do
        if status[turn] == out then
            turn := i
        end if
    end while
    status[i] = cs
until not exists other : satus[other] = cs
CS
status[i] = out
```

=== `std::mutex` и `std::lock_guard`

Реализует взаимное исключение
