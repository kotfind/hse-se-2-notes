#import "/utils/math.typ": *
= Полиморфизм

#def[
    #defitem[Полиморфизм] --- возможность написания кода, которым можно
    использовать для разных типов ("форм").
]

В C++ есть два полиморфизма:
- Времени компиляции (шаблоны)
- Времени исполнения (с помощью наследования и виртуальных функций)

== Наследование

#def[
    #defitem[Наследование] --- иерархическое отношение между классами.
    Механизм повторного использования и расширения класса без модификации его
    кода.
]

Обычно отражает отношение "общее--частное".

Как без наследования:
```cpp
struct A {
    void f();
};

struct B {
    A a;
    void something_new();
};

B obj;
obj.something_new();
obj.a.f();
// ^^^
```

С наследованием:
```cpp
struct A {
    void f();
};

struct B : public A {
    void something_new();
};

B obj;
obj.something_new();
obj.f();
// ^
```

=== Наследование и права доступа

- ```cpp class D : public B { ... }```
    - `public -> public`
    - `protected -> protected`
- ```cpp class D : private B { ... }```
    - `public, protected -> private`
- ```cpp class D : protected B { ... }```
    - `public, protected -> protected`

Изменить права доступа при наследовании:
```cpp
struct B { void f(); };

class D : public B {
private:
    using B::f; // делаем f приватным
}

D obj;
obj.f(); // ошибка
```

== Полиморфные функции

Функцию `pmf` можно вызвать для объекта класса `D`, несмотря на то, что она была
объявлена раньше самого класса:
```cpp
struct B {
    void f() {
        std::cout << "B::f()\n";
    }
};

void pmf(B& br) {
    br.f();
}

class D : public B {};

// Можем вызывать функцию pmf для класса
// объявленного после неё самой
D obj;
pmf(obj);
```

При вызове `pmf` объект `cast`-уется к типу `B`, вызывается изначальная функция
(из `B`), а не переопределение (из `D`):
```cpp
struct B {
    void f() {
        std::cout << "B::f()\n";
    }
};

void pmf(B& br)  {
    br.f();
}

class D : public B {
    void f() {
        std::cout << "D::f()\n";
    }
};

B b;
D d;
pmf(b); // -> "B::f()"
pmf(d); // -> "B::f()"
```

=== Виртуальные функции

Если сделать функцию `virtual`, то будет вызваться переопределенная функция, а
не изначальная.

```cpp
struct B {
    virtual void f() {
        std::cout << "B::f()\n";
    }
};

void pmf(B& br)  {
    br.f();
}

class D : public B {
    void f() override {
        std::cout << "D::f()\n";
    }
};

B b;
D d;
pmf(b); // -> "B::f()"
pmf(d); // -> "D::f()"
```

== Перегрузка, переопределение, сокрытие

- Перегрузка (overload): несколько функций с одним именем в одной области
    видимости
- Переопределение (override) виртуальной функции: объявление в дочернем
    классе функции с той же сигнатурой
- Сокрытие: объявление функции с тем же именем во вложенной области (в
    подклассе/ дочернем классе)

```cpp
struct B {
    virtual void f(int) { ... }
    virtual void f(double) { ... }
    virtual void g(int i = 20) { ... }
};

struct D : public B {
    void f(complex<double>);
    void g(int i = 20);
}

B b;
D d;
B* pb = new D;
b.f(1.0); // B::f(double)
d.f(1.0); // D::f(complex<double>) неявно кастуемся к double
pb->f(1.0); // B::f(double) нет более специальной реализации для double
b.g(); // B::g(int) 10
d.g(); // D::g(int) 20
pb->g(); // D::g(int) 10 <-- так не надо
```

`override` --- ключевое слово, которое проверяет, что данная функция, и правда,
является переопределением. Иначе выкидывает compile error. Его хорошо писать
везде, где оно подходит.

Если есть хотя бы одна виртуальная функция, то деструктор тоже должен быть
виртуальным.

== Интерфейсы и чистые виртуальные функции

Пример (как делать не надо):
Для добавления каждого нового logger-а приходится много и тривиально менять
метод logger:
```cpp
struct ConsoleLogger {
    void log_tx(long from, long to, double amount) { ... }
};

struct DBLogger {
    void log_tx(long from, long to, double amount) { ... }
    DBLogger(...) {...}
    ~DBLogger() { ... }
};

struct Processor {
    void transfer(long from, long to, double amount) {
        // ...
        switch (logger_type) {
            // ...
        }
        // ...
    }
};
```

Пример (как делать надо):
Сделать интерфейс `Logger`:
```cpp
struct Logger {
    virtual void log_tx(long from, long to, double amount) = 0;
    //                                                     ^^^^
    //                                      делает виртуальную функцию чистой
};

class Processor {
public:
    Processor(Logger* logger) { ... }
    void transfer() { ... }

private:
    Logger* logger_;
};
```

#def[
    #defitem[Абстрактные классы (интерфейсы)] --- классы с чистыми виртуальными функциями.
]

Абстрактный класс нельзя создать, можно только унаследовать.

== Принципы проектирования

- Минимизация зависимостей между частями системы (классами)
- DRY (Don't repeat yourself) -- не WET (write everything twice/ we enjoy typing)
- KISS (Keep it simple, stupid)
- YAGNI (You aren't gonna need it)
- SOLID
    - класс должен отвечать за одну конкретную сущность
    - разделение интерфейсов
    - открытость к расширению
    - принцип подстановки: класс ведет себя, как базовый
