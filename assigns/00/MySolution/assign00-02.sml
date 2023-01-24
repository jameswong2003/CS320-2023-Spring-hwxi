use "./../assign00-lib.sml";

fun isPrime(n: int): bool =
    let
        fun helper(n: int, i: int) =
            if n < 2 then false
            else if i * i > n then true
            else if n mod i = 0 then false
            else helper(n, i+1)
    in
        helper(n, 2)
    end
