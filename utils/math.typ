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
