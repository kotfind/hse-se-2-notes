== Async: Асинхронные вызовы

```cpp
int f() {
    return 42;
}

int main() {
    std::future res = std::async(f); // Запуск
    res.wait(); // Блокирующий вызов. Просто ждет
    int value = res.get(); // get вызывает wait
}
```

=== promise и future

- promise --- неготовое значение со стороны поставщика; есть
  `set_value()`#footnote[`set_value()` можно делать только один раз]
- future --- неготовое значение со стороны получателя

== Проблема совместного доступа

- Чтение в нескольких потоках безопасно
- Плохо, когда
    - один читает другой пишет
    - несколько пишут

=== Методы решения

- Блокировки
- lock-free
- Трансляционная память (особо нигде не поддерживается)

== Mutex

"Mutex блокирует инвариант": пока mutex lock-нут, инвариант может нарушаться,
иначе --- нет

```cpp
std::mutex m;
std::list<int> the_list;

void safe_append(int v) {
    std::lock_guard lock(m);
    the_list.push_back(v);
}

void process_list() {
    std::lock_guard<std::mutex> lock(m); // Полная форма
    // *Что-то делаем*
}
```

=== Mutex --- не панацея

```cpp
template <typename T>
class stack {
    void push(const T& v); // Защищена mutex-ом
    void empty() const; // Защищена mutex-ом
    const T& top() const; // Защищена mutex-ом
    void pop(); // Защищена mutex-ом
};

stack<int> s;
if (!s.empty()) {
    // Ошибка, если в этом месте другой thread сделал s.pop()
    int v = s.top();
    s.pop();
}
```

Плохое решение --- сказать пользователю завернуть if в mutex

Хорошее решение --- по-умному изменить интерфейс, добавить "большие" операции:
```cpp
template <typename T>
class safe_stack {
    private:
        stack<T> s_;
        mutable std::mutex m_;

    public:
        std::shared_ptr<T> pop() {
            std::lock_guard lock(m_);
            if (s_.empty()) throw stack_exception();
            std::shared_ptr<T> res(std::make_shared<T>(s_.top()));
            s_.pop();
            return res;
        }

        bool empty() const {
            std::lock_guard lk(m_);
            return s_.empty();
        }
}
```

=== Сколько ставить Mutex-ов

- Один на программу --- слишком мало
- Один на структуру --- см. прошлый пример
- На каждый элемент

Меньше область блокирования --- выше параллелизм, но сложнее программа

=== `std::shared_mutex` --- блокировки чтения и записи

- `lock` / `try_lock` --- эксклюзивная блокировка (только один поток)
- `lock_shared` / `try_lock_shared` --- разделяемая блокировка (несколько
    потоков могут удерживать блокировку)

Эксклюзивная блокировка --- изменение объекта, разделяемые --- для чтения.

=== `std::scoped_lock`

Решает проблему взаимных блокировок

Как `std::lock_guard`, но атомарно блокирует все данные `mutex`-ы

```cpp
std::mutex m1, m2;
std::scoped_lock lk(m1, m2);
```

=== Проверка корректности

\*Сюжет про Сети Петри\*: строим модель нашей системы, модель анализируем (на
практике обычно идет сложно).

Советы:
- Избегать блокировки двух `mutex`-ов
- Не выполнять пользовательский код в момент удержания блокировки
- Ставить несколько блокировок в фиксированном порядке
- Иерархические блокировки

== Ожидание оповещения

```cpp
std::queue<Data> tasks;
std::mutex m;
std::condition_variable cond;

void task_maker() {
    while(1) {
        auto data = prepare();
        std::scoped_lock lk(m);
        tasks.push(data);
    }
    cond.notify_all();
}

void process() {
    while(1) {
        std::unique_lock lk(m);
        cond.wait(lk);
        auto data = task.front();
        tasks.pop();
        lk.unlock();
    }
}
```

В `wait` можно передать предикат
```cpp
cond.wait(lk, []() { return !tasks.empty(); });
```

== Ожидание с future/ promise

```cpp
std::promise<int> p;
std::future<int> f = p.get_future();

f.wait();
int res = f.get();

// В другом потоке
p.set_value(42);
```

== Защелки, барьеры, семафоры

- Барьер --- точка синхронизации, до которой все потоки должны дойти
    одновременно. Число потоков известно в момент создания барьера.

- Защелка --- одноразовый барьер.
