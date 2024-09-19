= Введение

Препод: Сергей Александрович

Оценка:
$ "Итог"
    = 0.5 dot (0.1 dot "А" + 0.2 dot "Дз1" + 0.35 dot "Дз2" + 0.35 dot "Дз3")
    + 0.5 dot (0.3 dot "Кр" + 0.7 dot "Экз") $

Будет:
- ООП
- Параллельное и конкурентное программирование
- Функциональное программирование
- Всякое

= Классы

Классы --- исторически первое отличие C++ от C

```cpp
class Matrix {
    private:
        size_t n_rows_;
        size_t n_cols_;
        double *data_;

    public:
        Matrix(size_t n_rows, size_t n_cols);
        Matrix(const Matrx& other);
        Matrix() = delete;  // Явно удаляем default-ный конструктор,
                            // хотя он, и так, не создается

        int rank() const;

        size_t n_rows() const { return n_rows_; }
}

int main() {
    Matrix m(10, 10);

    m.rank();
}
```

"Программы надо писать для людей"

Методы, реализованные внутри объявления класса, часто становятся inline-овыми.

Инкапсуляция --- скрытие внутреннего состояния (private в классах). Позволяет:
+ меньше косячить в программах
+ отделять реализацию от интерфейса

#figure(caption: "Инкапсуляция в Си")[
    `public.h`:
    ```c
        typedef void* Matrix;
        Matrix matrix_create();
        int matrix_rank(Matrix m);
    ```

    `public.h`:
    ```c
        Matrix matrix_create() { ... }
        int matrix_rank(Matrix m) {
            struct MatrixData* = (MatrixData*)m;
            ...
        }
    ```
]

const --- после называния метода, значит метод не меняет экземпляр

```cpp
Matrix m; // default-ный конструктор
Matrix m(1, 1); // конструктор
Matrix m(); // объявление функции
Matrix m{}; // default-ный консруктор
Matrix m2 = m; // конструктор копирования
```

Удалять, как создавали:
```cpp
Matrix* pm = new Matrix(1, 1);
Matrix* a = new Matrix[100];

delete pm;
delete[] a;
```

New по уже выделенной памяти:
```cpp
void* addr = malloc(...);
new (addr) Matrix(1, 1);
a.~Matrix();
```

Если у полей нет default-ного конструктора или поля константы или ссылки, то делать так:
```cpp
class X {...};

X::X(int y) : a(y) { ... }
```

Поля инициализирются в том порядке, в котором указаны в классе

`X&&` --- r-value

```cpp
X::X(X&& other) {...}
```

Нельзя перегрузить оператор внутри класса, если первый аргумент другого типа

Правило трех:
- *TODO*
- *TODO*
- *TODO*

Правило пяти:
- .. правило трех
- *TODO*
- *TODO*

Не стоит бросать exception в деструкторе тк exception во время обработки
exception-а --- плохо

exception в конструкторе --- можно

Хорошо делать exception только с типами, унаследованными от std::exception
