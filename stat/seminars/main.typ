#import "/utils/template.typ": conf
#import "/utils/datestamp.typ": datestamp

#show: body => conf(
    title: "Математическая статистика",
    subtitle: "Семинары",
    notes_author: "Чубий Савва Андреевич",
    teacher: "Сизых Наталья Васильевна",
    year: [2024--2025],
    outline_opts: (
        depth: 1,
    ),
    body,
)
