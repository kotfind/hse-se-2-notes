#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Алгоритмы",
    subtitle: "Лекции",
    author: "Савва Чубий, БПИ233",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-03")
#include "2024-09-03.typ"

#datestamp("2024-09-10")
#include "2024-09-10.typ"

#datestamp("2024-09-17")
#include "2024-09-17.typ"

#datestamp("2024-09-24")
#include "2024-09-24.typ"

#datestamp("2024-10-01")
#include "2024-10-01.typ"

