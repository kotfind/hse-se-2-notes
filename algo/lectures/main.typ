#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Алгоритмы",
    subtitle: "Лекции",
    notes_author: "Чубий Савва Андреевич",
    teacher: "Мамай Игорь Борисович",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-03")
#include "2024-09-03.typ"

#datestamp("2024-09-10")
#include "2024-09-10.typ"

#datestamp("2024-09-17")
#include "2024-09-17.typ"

#datestamp("2024-09-24")
#include "2024-09-24.typ"

#datestamp("2024-10-01")
#include "2024-10-01.typ"

#datestamp("2024-10-08")
#include "2024-10-08.typ"

#datestamp("2024-10-15")
#include "2024-10-15.typ"

#datestamp("2024-11-05")
#include "2024-11-05.typ"

#datestamp("2024-11-12")
#include "2024-11-12.typ"

#datestamp("2024-11-19")
#include "2024-11-19.typ"
