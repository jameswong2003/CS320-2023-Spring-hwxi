fun fact(x: int): int =
if x > 0 then x * fact(x-1) else 1;

fun catchOverflow(n: int) : int =
    fact(n)
    catchOverflow (n + 1)
    handle Overflow => n