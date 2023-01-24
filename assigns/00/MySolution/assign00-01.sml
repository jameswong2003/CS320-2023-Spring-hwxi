fun handleOverflow(x: int): int = 
let
    fun fact(x: int): int = if x > 0 then x * fact(x-1) else 1
in
    try fact(x)
        with Overflow x
    handleOverflow(x+1)
end