#import "../../utils/template.typ": conf
#import "../../utils/datestamp.typ": datestamp

#show: body => conf(
    title: "C++",
    subtitle: "Лекции",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-13")
#include "./2024-09-13.typ"
