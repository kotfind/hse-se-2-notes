#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Основы операционных систем",
    subtitle: "Лекции",
    author: "Савва Чубий, БПИ233",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-02")
#include "./2024-09-02.typ"

#datestamp("2024-09-09")
#include "./2024-09-09.typ"

#datestamp("2024-09-16")
#include "./2024-09-16.typ"

#datestamp("2024-09-23")
#include "2024-09-23.typ"

#datestamp("2024-09-30")
#include "2024-09-30.typ"

#datestamp("2024-10-07")
#include "2024-10-07.typ"

#datestamp("2024-10-14")
#include "2024-10-14.typ"

