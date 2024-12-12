#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Android",
    subtitle: "Лекции",
    notes_author: "Чубий Савва Андреевич",
    teacher: "Макаров Сергей Львович",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-14")
#include "./2024-09-14.typ"
