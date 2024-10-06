#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Теория Вероятностей",
    subtitle: "Домашние задания",
    author: "Савва Чубий, БПИ233",
    year: [2024--2025],
    outline_opts: (
        depth: 1,
    ),
    body,
)

#datestamp( "2024-09-16")
#include "./to-2024-09-16.typ"

#datestamp( "2024-09-23")
#include "./to-2024-09-23.typ"

#datestamp("2024-09-30")
#include "to-2024-09-30.typ"

#datestamp("2024-10-07")
#include "to-2024-10-07.typ"

