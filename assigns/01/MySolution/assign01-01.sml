use "./../assign01.sml";

fun xlist_size(xs: 'a xlist): int =
    (
        case xs of
            xlist_nil => 0
        |   xlist_cons(x, xs') => 1 + xlist_size(xs')
        |   xlist_snoc(xs', x) => 1 + xlist_size(xs')
        |   xlist_append(xs', ys') => xlist_size(xs') + xlist_size(ys')
        |   xlist_reverse(xs') => xlist_size(xs')
    )
