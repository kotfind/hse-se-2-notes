#let _parse_date(date_str) = {
    let date_match = date_str.match(regex("^(\d{4})[-](\d{2})[-](\d{2})$"))
    if date_match == none {
        panic("failed to parse date (YYYY-MM-DD): " + date_str)
    }
    let (year, month, day) = date_match.captures

    datetime(
        year: int(year),
        month: int(month),
        day: int(day),
    )
}

#let datestamp(date) = {
    // Parse date
    if type(date) == str {
        date = _parse_date(date)
    }
    assert(type(date) == datetime)

    // Set mark (label)
    [#metadata(date) <datestamp>]

    // Print stamp
    let stroke = red + 0.5pt;
    block(
        breakable: false,
        grid(
            columns: (1fr, auto, 1fr),
            align: horizon + center,
            line(length: 100%, stroke: stroke),
            block(
                inset: 5pt,
                radius: 5pt,
                stroke: stroke,
                date.display()
            ),
            line(length: 100%, stroke: stroke),
        )
    )
}

#let datestamped_outline(
    title: "Содержание",
    depth: none,
    indent: 1cm,
    fill: repeat([.]),
) = context {
    let items = query(selector(label("datestamp")).or(selector(heading)))

    for item in items {
        if item.func() == heading {
            let level = item.level
            if depth == none or level <= depth {
                let ind = h((level - 1) * indent)
                let name = item.body
                let dots = box(width: 1fr, fill)
                let loc = item.location()
                let page = loc.page()
                link(loc)[#ind#name #dots #page\ ]
            }
        } else if item.func() == metadata {
            let date = item.value
            let loc = item.location()
             
            let data = grid(
                columns: (auto, 1fr),
                align: horizon + center,
                column-gutter: 5pt,

                text(fill: red, date.display()),
                line(length: 100%, stroke: 0.5pt + red)
            )

            link(loc, data)
        } else {
            panic("unreachable")
        }
    }
}
