#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Основы операционных систем",
    subtitle: "Лекции",
    notes_author: "Чубий Савва Андреевич",
    teacher: "Карпов Владимир Ефимович",
    year: [2024--2025],
    body,
)

#datestamp("2024-09-02")
#include "./2024-09-02.typ"

#datestamp("2024-09-09")
#include "./2024-09-09.typ"

#datestamp("2024-09-16")
#include "./2024-09-16.typ"

#datestamp("2024-09-23")
#include "2024-09-23.typ"

#datestamp("2024-09-30")
#include "2024-09-30.typ"

#datestamp("2024-10-07")
#include "2024-10-07.typ"

#datestamp("2024-10-14")
#include "2024-10-14.typ"

#datestamp("2024-10-21")
#include "2024-10-21.typ"

#datestamp("2024-11-11")
#include "2024-11-11.typ"

#datestamp("2024-11-18")
*\*Тут пропущена одна лекция\**

#datestamp("2024-11-25")
#include "2024-11-25.typ"

#datestamp("2024-12-02")
#include "2024-12-02.typ"

#datestamp("2024-12-09")
*\*Тут пропущена одна лекция\**

#datestamp("2024-12-16")
#include "2024-12-16.typ"
