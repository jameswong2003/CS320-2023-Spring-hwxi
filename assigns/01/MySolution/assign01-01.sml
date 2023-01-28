use "./../assign01-lib.sml";

fun size_of_xlist(xs: 'a xlist): int =
    (
        case xs of
            xlist_nil => 0
        |   xlist_cons(x, xs') => 1 + size_of_xlist(xs')
        |   xlist_snoc(xs', x) => 1 + size_of_xlist(xs')
        |   xlist_append(xs', ys') => size_of_xlist(xs') + size_of_xlist(ys')
        |   xlist_reverse(xs') => size_of_xlist(xs')
    )
