#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Совеменное образование",
    subtitle: "Семинары",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-11")
#include "2024-09-11.typ"

#datestamp("2024-09-18")
#include "2024-09-18.typ"

