#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Математическая Статистика",
    subtitle: "Лекции",
    notes_author: "Чубий Савва Андреевич",
    teacher: "Горяинова Елена Рудольфовна",
    year: [2024--2025],
    body,
)

#datestamp("2025-01-10")
#include "2025-01-10.typ"

#datestamp("2025-01-17")
#include "2025-01-17.typ"
