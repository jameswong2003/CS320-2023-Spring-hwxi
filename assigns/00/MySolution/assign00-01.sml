fun catchOverflow(x: int) = 
let
    fun fact(x: int): int = if x > 0 then x * fact(x-1) else 1
in
    if (fact x; false) handle overflow => true
    then x else catchOverflow(x+1)
end

val N = catchOverflow 0