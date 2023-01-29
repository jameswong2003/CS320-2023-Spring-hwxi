use "./../assign01.sml";
use "./../MySolution/assign01-01.sml";

fun xlist_sub(xs: 'a xlist, i0: int): 'a =
    case xs of
        xlist_nil => raise XlistSubscript
    |   xlist_cons(x, xs) => if i0 = 0 then x else xlist_sub(xs, i0-1)
    |   xlist_snoc(xs, x) => if i0 = xlist_size(xs) then x else xlist_sub(xs, i0)
    |   xlist_append(xs, ys) => if i0 < xlist_size(xs) then xlist_sub(xs, i0) else xlist_sub(ys, i0 - xlist_size(xs))
    |   xlist_reverse(xs) => xlist_sub(xs, xlist_size(xs) - i0 - 1)