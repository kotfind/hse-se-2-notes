#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Алгоритмы",
    subtitle: "Лекции",
    year: [2024--2025],
    body,
)


#datestamp("2024-09-03")
#include "2024-09-03.typ"

#datestamp("2024-09-10")
#include "2024-09-10.typ"

#datestamp("2024-09-17")
#include "2024-09-17.typ"
