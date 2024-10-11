== Структурные шаблоны

=== Адаптер

Хотим штуку с одним интерфейсом засунуть в функцию, которая ожидает другой
интерфейс

Есть такое:
```cpp
void draw(const PointsShape1& ps); // ps.begin(), ps.end()
class Line { Point a, b; };
```

Хотим использовать в таком:
```cpp
using V1 = std:vector<Point>::iterator;
void draw_points(V1 start, V1 end);
```

Делаем класс-обертку (адаптер) с правильным интерфейсом:
```cpp
using V1 = std::vector<Point>::iterator;
class LinePointShape : public Shape1 {
    public:
        V1 begin() override { ... }
        V1 end() override { ... }
    private:
        Line* line_;
}
```

== Мост (Bridge, Pimpl)

- Отделить интерфейс от реализации
- Скрыть детали реализации

Полезно, если интерфейс простой, а релизация сложная

```cpp
class Optimizer {
    public:
        using Target = float(Variablies&);
        virtual void set_target(Target* f);
        virtual Soution optimize(); // вызывает методы impl_

    private:
        class OptiomizerImpl {
            ...
        };

        std::unique_ptr<OptimizerImpl> impl_; // "Настоящая" реализация
};
```

Внутреннюю реализацию можно "подменять" в зависимости от задачи

== Компоновщик (Composite)

Позволяет единым образом трактовать индивидуальные и составные объекты

Пример: в графическом редакторе одни и те же действия можно выполнять как с
одним элементом, так сразу и со многими

```cpp
struct Component {
    virtualvoid op1();
    virtual add(Component*);
};

struct Leaf : Component {
    void op1() override;
}:

struct Group : Component {
    void op1() override;
    void add() override;
};
```

== Декоратор (Decorator)

Декоратор --- это "примесь объектов"

Объект помещается в другой объект, который повторяет интерфейс первого, но
что-то добавляет

Например: Shape, ColorShape, TransparentShape, Circle, Rectangle

```cpp
// Базовый класс
struct Shape {
    virtual void draw() const = 0;
};

// Конкретная реализация
struct Circle : Shape {
    Circle(float r);
    void draw() const override { ... };
};

// Декоратор, дополнительное свойство
struct ColoredShape : Shape {
    Shape& shape;
    float color;
    ColoredShape(Shape& s, float c) : shape(s), color(c) {}
    void draw() const override {
        set_color();
        shape.draw();
    }
};
```

Пример использования:
```cpp
Circle circle;
ColoreShape green_circle(circle, 0x00FF00);
green_circle.draw();
```

Декораторы можно композировать:
```cpp
TransparentShape circle {
    ColoredShape{
        Circle{0.5},
        0x00FF00
    }
}
```

== Фасад

Фасад --- интерфейс для внешних пользователей. Нужен для скрытия деталей
реализации для внешних пользователей.

== Заместитель (proxy)

Заглушка тяжелого объекта, локальный представитель удаленного объекта.

Реализует интерфейс основного объекта с некоторыми "техническими" улучшениями.

== Интератор

Как в `std`

= Шаблоны поведения
== Цепочка ответственности

Связывает объекты-получатели в цепочку и передает запрос вдоль этой цепочки,
пока его не обработают

```cpp
class Handler {
    public:
        void add(Handler* h) {
            next = h;
        }

        virtual void handle(Request& rq) {
            if (next) {
                next->handle();
            }
        }

    private:
        Handler* next; // указатель на следующего обработчика
};

class SomeHandler : public Handler {
    void handle(Request& r) override {
        Handler::handle(r);
    } 
};
```

== Команда

Представляет действие, как объект.

Команды можно ставить в очередь и отменять.

```cpp
// Класс банковского счета
class Account {
public:
    void deposit(int amount);
    void withdraw(int amount);

private:
    int ammount;
};
```

```cpp
struct Command {
    virtual void process() = 0;
};

struct BankAccountCommand : Command {
    BankAccount& account;
    enum Action {
        deposit,
        withdraw,
    } action;
    int amount;

    ...
}
```

== Наблюдатель

Задача: при изменении одного объекта информировать об этом изменении другие.
Publish and subscribe.

При изменении поля ввода меняется состояние кнопки.

Участники:
- Объекты, заинтересованные в информации
- Объекты, обладающие информацией

То есть одни объекты "подписываются" на изменения других

```cpp
class Subject {
    public:
        virtual ~Subject();
        virtual void attach(Observer*);
        virtual void detach(Observer*);
        virtual void notify();

    protected:
        Subject();

    private:
        List<Observer*> observers_;
};
```

== Состояние

Реализуем класс, как конечный автомат

Базовый класс State определяет нужные виртуальные методы, производные классы
переопределяют эти методы для конкретного состояние.

Внутри класса храним указатель на нужный State.

== Шаблонный метод

В базовом классе алгоритм, который вызывает некоторые виртуальные функции.
Эти функции (например, для оптимизации можно переопределить)

== Стратегия

Алгоритм решения выделяется в класс.

...

=== Посетитель

```cpp
class Visitor {
    public:
        virtual void visit(ElementA*) = 0;
        virtual void visit(ElementB*) = 0;

    protected:
        Visitor();
};

class Element {
    public:
        virtual ~Element();
        virtual void accept(Visitor& v) = 0;

    protected:
        Element();
};
```

Может, например, быть `SaveVisitor`.
