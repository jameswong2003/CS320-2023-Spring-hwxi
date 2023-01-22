fun isPrime(n: int) bool =
    let
        fun checker(n: int, i: int) : bool =
            if i * i > n then true
            else if n mod i = 0 then false
            else checker(n, i + 1)
    in
        if n < 2 then false
        else checker(2, n)
    end