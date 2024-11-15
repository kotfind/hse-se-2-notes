#let def(
    body,
    supplement: "Опр.",
) = context {
    let sup = text(weight: "bold", supplement)
    let sup_wid = measure(sup).width
    par(hanging-indent: sup_wid)[#sup #body]
}

#let defitem(body) = {
    [#strong(body)<defitem>]
}

// TODO: defenitions list

#let blk(
    title: none,
    body,
) = context {
    let has_title = if type(title) == str or type(title) == content {
        true
    } else if title == none {
        false
    } else {
        panic("title must be content or string, not " + type(title))
    }

    let stroke = black + 0.5pt
    let padding = 10pt
    let title_padding = 5pt

    let title_blk = block(
        inset: title_padding,
        radius: title_padding,
        stroke: stroke,
        fill: white,
        strong(title),
    )

    let title_hei = measure(title_blk).height

    if has_title {
        v(5pt)
    }
    block(
        inset: padding,
        radius: padding,
        stroke: stroke,
        width: 100%,
        {
            if has_title {
                place(
                    top + left,
                    dy: -title_hei / 2 - padding,
                    dx: -2 * padding,
                    title_blk,
                )
                v(5pt)
            }
            body
        }
    )
}

#let proof(
    supplement: "Док-во",
    body
) = {
    blk(title: "Док-во", body)
}


#let match(..args) = {
    let cases = ()

    let pushed_otherwise_case = false
    for arg in args.pos() {
        /// each line should be in form
        ///     '{value}, {condition};'
        /// or (for the last line)
        ///     '{value};'
        assert(arg.len() == 2 or arg.len() == 1);

        let value = arg.at(0)

        if arg.len() == 2 {
            assert(pushed_otherwise_case == false)

            let cond = arg.at(1)

            cases.push($#value", " space &"if" space #cond$)
        } else {
            cases.push($#value", " space &"otherwise"$)

            pushed_otherwise_case = true
        }
    }

    math.cases(..args.named(), ..cases)
}

