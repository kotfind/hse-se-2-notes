#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Теория Вероятностей",
    subtitle: "Домашние задания",
    year: [2024--2025],
    body,
)

#datestamp( "2024-09-16")
#include "./to-2024-09-16.typ"

#datestamp( "2024-09-23")
#include "./to-2024-09-23.typ"

#datestamp("2024-09-30")
#include "to-2024-09-30.typ"
