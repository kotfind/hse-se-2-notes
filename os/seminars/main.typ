#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Основы операционных систем",
    subtitle: "Семинары",
    notes_author: "Чубий Савва Андреевич",
    teacher: "Белов Максим Александрович",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-06")
#include "./2024-09-06.typ"

#datestamp("2024-09-13")
#include "./2024-09-13.typ"

#datestamp("2024-09-20")
#include "2024-09-20.typ"
