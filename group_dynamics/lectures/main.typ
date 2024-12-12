#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Групповая динамика",
    subtitle: "Лекции",
    notes_author: "Чубий Савва Андреевич",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-03")
#include "./2024-09-03.typ"
