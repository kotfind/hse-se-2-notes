#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Теория Вероятностей",
    subtitle: "Лекции",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-06")
#include "./2024-09-06.typ"

#datestamp("2024-09-13")
#include "./2024-09-13.typ"
