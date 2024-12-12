#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Совеменное образование",
    subtitle: "Семинары",
    notes_author: "Чубий Савва Андреевич",
    teacher: "Стремилова Екатерина Константиновна",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-11")
#include "2024-09-11.typ"

#datestamp("2024-09-18")
#include "2024-09-18.typ"

#datestamp("2024-09-25")
#include "2024-09-25.typ"

#datestamp("2024-10-09")
#include "2024-10-09.typ"

#datestamp("2024-10-16")
#include "2024-10-16.typ"

#datestamp("2024-10-23")
#include "2024-10-23.typ"

#datestamp("2024-11-06")
#include "2024-11-06.typ"
