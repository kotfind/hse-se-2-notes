= О процессах

Контекст пользователя:
- Стек пользователя
- Динамическая память
- Не инициализированные изменяемые данные
- Инициализированные изменяемые данные
- Инициализированные неизменяемые данные
- Исполняемый код

Контекст ядра:
- Стек ядра
- ... // TODO

#figure(
    caption: "Специальные процессы",
    table(
        columns: 2,
        table.header[*PID*][*Название*],
        [0], [Ядро],
        [1], [Init (Systemd)]
    )
)

fork-нутый процесс наследует весь пользовательский контекст

#figure(
    caption: "Return fork-а",
    table(
        columns: 2,
        [-1], [Ошибка],
        [0], [Ребенок],
        [PID ребенка], [Родитель],
    )
)
