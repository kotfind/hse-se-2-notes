#import "../../utils/template.typ": conf
#import "../../utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Android",
    subtitle: "Лекции",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-14")
#include "./2024-09-14.typ"
