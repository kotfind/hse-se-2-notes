#import "datestamp.typ": datestamped_outline

#let _heading_builder(
    is_bold: true,
    is_smallcapsed: false,
    is_underlined: false,
    font_size: 16pt,
    line_len: 2cm,
    vspace: 0.5cm,
    body
) = {
    if is_smallcapsed {
        body = smallcaps(body)
    }

    if is_underlined {
        body = underline(body)
    }

    let body = text(
        size: font_size,
        weight: if is_bold { "bold" } else { "regular" },
        body
    )

    let line = line(
        length: line_len,
        stroke: if is_bold { 1pt } else { 0.5pt },
    )

    v(vspace, weak: true)
    grid(
        columns: (1fr, auto, 1fr),
        align: (horizon + right, horizon + center, horizon + left),
        column-gutter: 5pt,
        line,
        body,
        line,
    )
    v(vspace, weak: true)
}

#let conf(
    title: none,
    subtitle: none,
    notes_author: none,
    teacher: none,
    year: none,
    outline_opts: none,
    body
) = {
    // Set metadata
    set document(
        title: [#title. #subtitle],
        author: notes_author,
    )

    [
        #metadata((
            title: title,
            subtitle: subtitle,
        )) <document_info>
    ]

    // Set language and font size
    set text(lang: "ru", size: 11pt)
    set par(justify: true)

    // Title page
    align(center + horizon, [
        #text(27pt, weight: "bold", title)

        #text(25pt, weight: "bold", subtitle)

        #text(16pt, grid(
            columns: 2,
            align: (right, left),
            row-gutter: 1em,
            column-gutter: 0.5em,

            [Автор конспектов:],
            notes_author,

            if teacher != none { [Преподаватель:] },
            if teacher != none { teacher },
        ))

        #text(16pt, year)
    ])

    // Outline
    datestamped_outline(..outline_opts)
    pagebreak(weak: true)

    // Page style
    set page(
        header: align(center)[
            #title. #subtitle
            #line(length: 100%, stroke: 0.5pt)
        ],
        footer: align(center, {
            line(length: 100%, stroke: 0.5pt)
            context counter(page).display("1")
        }),
    )

    // Headings style
    show heading.where(level: 1): h => _heading_builder(
        is_bold: true,
        font_size: 16pt,
        line_len: 2cm,
        h.body
    )

    show heading.where(level: 2): h => _heading_builder(
        is_bold: false,
        is_smallcapsed: true,
        font_size: 14pt,
        line_len: 1cm,
        h.body
    )

    show heading.where(level: 3): h => _heading_builder(
        is_bold: false,
        is_smallcapsed: true,
        is_underlined: true,
        font_size: 12pt,
        line_len: 0cm,
        h.body
    )

    // Terms style
    show terms.item: it => [
        *Опр. *
        #text(weight: "bold", it.term): #it.description
    ]

    // Table style
    set table(align: left)

    // Figure style
    set figure.caption(position: top)

    // Body
    body
}
