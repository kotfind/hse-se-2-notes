#import "../../utils/template.typ": conf
#import "../../utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Современное образование",
    subtitle: "Лекции",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-04")
#include "./2024-09-04.typ"

#datestamp("2024-09-11")
#include "./2024-09-11.typ"
