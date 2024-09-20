#import "/utils/math.typ": *

= Обобщенное программирование (шаблоны)

#def[
    #defitem[Обобщенное программирование] --- набор методов для создания структур
    и алгоритмов, которые могут работать в различных ситуациях и с различными
    исходными данными.
]

Пример:
```cpp
double total(const double* data, size_t len) {
    double sum = 0;
    for (size_t i = 0; i < len; ++i) {
        sum += data[i];
    }
    return sum;
}
```

Плохой вариант: трижды сделать `Ctrl-C, Ctrl-V`

Мета программирование --- программы, которые пишут программы

Пример с шаблонами:
```cpp
template <typename V>
V total(const V* data, size_t len) {
    V sum = 0;
    for (size_t i = 0; i < len; ++i) {
        sum += data[i];
    }
    return sum;
}
```

Обращение к функции от конкретного типа создает реализацию перегруженной функции.
Т.е. шаблон создает семейство функций.

Улучшение. Из
```cpp
V sum = 0;
```
в
```cpp
V sum{};
```

Посчитать сумму:
```cpp
auto result = std::accumulate(A.begin(), A.end(), decltype(A)::value_type(0));

auto result = std::reduce(A.begin(), A.end());

std::for_each(A.begin(), A.end(), [&](int n) {
    result += n;
});
```

== Правила вывода типов шаблонов

```cpp
template<typename T>
void f(const T& param);

int x = 1;
f(x); // Чему равно T?
      // T = int
      // ParamType = const int&
```

Правила:
+ Если в `f(expr)`, `expr` --- ссылка, то ссылка отбрасывается
+ Тип `T` получается из сопоставления (pattern matching) типа `expr` и
  `ParamType`

*TODO:* см презентацию

== Виды шаблонов

- Функции
    ```cpp
    template<typename T> void f(T arg);
    ```

- Классы
    ```cpp
    template<typename T> class Matrix;
    ```

- Переменные
    ```cpp
    template<class T>
    T pi = T(3.1415926L);
    ```

- Типы (псевдонимы типов)
    ```cpp
    template<typename T> using ptr = T*;
    ptr<int> x;
    ```

- Концепты (будет позднее)
    ```cpp
    template<typename T>
    concept C1 = sizeof(T) != sizeof(int);
    ```

== Специализация

Специализации должны быть написаны до первого использования

=== Полная специализация

```cpp
// Общая реализация
template<typename T>
class Matrix {...}; 

// Более эффективная
// реализация для bool-ок
template<>
class Matrix<bool> {...}; 
```

=== Частичная специализация

```cpp
template<class T1, class T2, int I>
class A {}; // основной шаблон

template<class T, int I>
class A<T, T*, I> {}; // T2 --- указатель на T1

template<class T, class T2, int I>
class A<T*, T2, I> {}; // T1 --- указатель

template<class T>
class A<int, T*, 5> {}; // T1 = int, T2 --- указатель, I = 5
```

=== Контроль подставляемых типов

```cpp
template<typename T>
void swap(T& a, T& b) noexcept {
    static_assert(std::is_copy_constructable_v<T>, "Swap requires copying");
    static_assert(
        std::is_nothrow_copy_constructable_v<T> &&
            std::is_nothrow_copy_assinable_v<T>,
        "Swap requires copying"
    );

    auto c = b;
    b = a;
    a = c;
}
```

=== Предикаты времени компиляции

```cpp
#include <type_traits>
```

*TODO*: ...

=== Концепты

#def[
    #defitem[Концепт] --- семейство типов, обладающих определенными свойствами
    ("утинная типизация")
]

```cpp
template<typename T>
concept C1 = sizeof(T) != sizeof(int);

template<C1 T>
struct S1 {...};
```

=== Требования

```cpp
#include <type_traits>

template<typename T>
requires std::is_copy_constructible_v<T>
T get_copy(T* pointer) {
    if (!pointer) {
        throw std::runtime_error{"Null-pointer dereference"};
    }
    return *pointer;
}
```
