#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Групповая динамика",
    subtitle: "Лекции",
    author: "Савва Чубий, БПИ233",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-03")
#include "./2024-09-03.typ"
