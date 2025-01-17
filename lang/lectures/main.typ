#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Формальные языки и автоматы",
    subtitle: "Лекции",
    notes_author: "Чубий Савва Андреевич",
    teacher: "Игнатьев Валерий Николаевич",
    year: [2024--2025],
    body,
)

#datestamp("2025-01-17")
#include "2025-01-17.typ"
