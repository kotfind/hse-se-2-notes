#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "C++",
    subtitle: "Лекции",
    author: "Савва Чубий, БПИ233",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-13")
#include "./2024-09-13.typ"

#datestamp("2024-09-20")
#include "2024-09-20.typ"

#datestamp("2024-09-27")
#include "2024-09-27.typ"

#datestamp("2024-10-04")
#include "2024-10-04.typ"

#datestamp("2024-10-11")
#include "2024-10-11.typ"

#datestamp("2024-10-18")
#include "2024-10-18.typ"

#datestamp("2024-11-01")
#include "2024-11-01.typ"
