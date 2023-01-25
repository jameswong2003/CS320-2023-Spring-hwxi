use "./../MySolution/assign00-03.sml";

fun str2int(cs: string): int =
let
    (* Function that converts a single char to its corresponding digit *)
    fun helper(x: char): int = Char.ord(x) - 48
    (* Function that does exponents *)
    fun power(b: int, e: int): int = if e = 0 then 1 else b * power(b, (e-1));
    (* Function that returns the string at the specified index till the end*)
    fun tillEnd(x: string, index: int): string =
        if index = (String.size x) - 1
        then String.str(String.sub(x, index))
        else String.str(String.sub(x, index)) ^ tillEnd(x, index + 1)
in
    if String.size(cs) = 1 then helper(String.sub(cs, 0))
    else (helper(String.sub(cs, 0)) * (power(10, String.size(cs) - 1))) + str2int(tillEnd(cs, 1))
end