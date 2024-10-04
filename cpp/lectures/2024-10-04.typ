= Шаблоны проектирования

`Ctrl+C, Ctrl+V` --- плохо

При разработке систем стараются предусматривать возможность будущего расширения:
- Framework --- общее решение в некоторой ограниченной области
- Библиотека классов. Например, STL, Boost
- Шаблоны (patterns) проектирования

Виды паттернов проектирования:
- Паттерн создания (как создавать новые объекты): фабрика, прототип, одиночка
- Структурные паттерны (как компоновать сущности): адаптер, мост, proxy
- Паттерны поведения: итератор, команда, цепочка ответственности

== Некоторые стандартные приемы (не шаблоны)

- Интерфейс (базовый класс определяет набор чистых виртуальных функций,
    производные классы их реализуют)
- CRTP (см. дальше)
- Примеси (см. дальше)

=== The Curiously Recurring Template Pattern (CRTP)

```cpp
template <class T>
struct Base {
    void generic_fun() {
        static_cast<T*>(this)->implementation();
    }
};

struct Derived : public Base<Derived> {
    void implementation();
};
```

Как виртуальные функции, но выбор функции происходит в compile time.

=== Примеси

```cpp
struct Number {
    int n;
    void set(int v) { n = v; }
    int get() const { return n; }
};
```

Хотим добавить `undo`;

```cpp
struct Number {
    int n;
    int old_n;
    void set(int v) { old_n = n; n = v; }
    void undo() { n = old_n; } // undo на один шаг
    int get() const { return n; }
};
```

Хотим это для произвольного класса.

Если состояние --- `int`:
```cpp
template <typename T>
struct Undoable : public B {
    int before;
    void set(int v) { before = B::get(); B::set(v); }
    void undo() { B::set(before); }
};

using UNumber = Undoable<Number>;
```

Если состояние любого типа:
```cpp
template <typename B, typename T = typename B::value_type>
struct Undoable : public B {
    using value_type = T;
    T before;
    void set(T v) { before = B::get(); B::set(v); }
    void undo() { B::set(before); }
};

using UNumber = Undoable<Number>;
```

```cpp
template <typename B, typename T = typename B::value_type>
struct Redoable : public B {
    using value_type = T;
    T after;
    void set(T v) { after = v; B::set(v);}
    void redo() { B::set(after); }
};

using RUNmber = Redoable<Undoable<Number>>;
```

== Паттерны создания
=== Зависимости и ограничения

Для создания объекта нужно указать класс.
Конструкторы могут требовать сложных аргументов.

Проблемы:
- Хотим минимизировать количество зависимостей между разными частями кода.
- Ограничивает множество классов

=== Абстрактная фабрика

Взаимодействие следующих сущностей:
- `AbstractFactory` (интерфейс), `ConcreteFactory` (несколько классов,
    конкретные реализации)
- `AbstractProduct` (интерфейс), `ConcreteProduct` (несколько классов,
    конкретные реализации)

```cpp
class Shape { // AbstractProduct
public:
    virtual std::string text() = 0; // имя
    virtual double area() const = 0; // площадь
    virtual ~Shape();
};

class Rectangle : public Shape {
public:
    std::string text() override { ... }
    double area() const override { ... }
private:
    double w_, h_;
}
```

```cpp
class ShapeFactory {
public:
    // ...TODO
};

// ...TODO
```

Нужна функция для создания фабрик:
```cpp
ShapeFactory* makeShapeFactory(std::string shape) {
    if (shape == "triangle") {
        return new TriangleFactory();
    } else if (shape == "rectange") {
        return new RectangleFactory();
    } else {
        throw std::invalid_argument("wrong shape name");
    }
}
```

=== Саморегистрирующиеся классы

Идея:
- Все фабрики наследуются от базового класса
- В этом базовом классе создается статический реестр фабрик
- При создании фабрики регистрируют себя

```cpp
class AbstractFactory {
public:
    using create_f = std::unique_ptr<AbstractFactory>();

    staic void registrate(std::string const& name, crate_f* fp) {
        registry[name] = fp;
    }

    static std::unique_ptr<AbstractFactory> make(std::string const& name) {
        auto it = registry.find(name);
        return it == registry.end() ? nullptr : (it->second)();
    }

    template <typename F>
    struct Registrar {
        explicit Registrar(std::string const& name) {
            AbstractFactory::registrate(name, &F::create);
        }
    }

private:
    static std::map<std::string, create_f*> registry;
};
```

Конкретная фабрика:
```cpp
class ConcreteFactory : public AbstractFactory {
    static std::unique_ptr<AbstractFactory> create() {
        return std::make_unique<ConcreteFactory>();
    }
};

// В cpp-файле
namespace {
    ConcreteFactory::Registrar<ConcreteFactory> reg("my_name");
}
```

=== Фабричный метод

- `Product`, `ConcreteProduct`
- `Creator`, `ConcreteCreator`

```cpp
class Creator {
public:
    virtual Product* Create() = 0;
}
```

=== Паттерн Строитель (Builder)

Строим сложный объект по частям

- `Builder`, `ConcreteBuilder`
- `Director` --- распорядитель (вызывает методы Строителя)
- `Product`

```cpp
class DocBuilder {
public:
    virtual DocBuilder& build_title(std::string& title) { ... }
    ...
    virtual Product* build() { ... }
}:

class HTMLBuilder : public DocBuilder { ... };
class LaTeXBuilder : public DocBuilder { ... };
```

Пример использования:
```cpp
Doc transformer(const string& src, Builder& builder);
```

=== Одиночка (Singleton)

```cpp
template <class T>
class Singleton {
public:
    T& get() {
        static T* obj;
        return obj;
    }
};
```
