#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Конструирование прогаммного обеспечения",
    subtitle: "Лекции",
    notes_author: "Чубий Савва Андреевич",
    teacher: "Сергей Александрович Виденин",
    year: [2024--2025],
    body,
)

#datestamp("2025-01-11")
#include "2025-01-11.typ"
