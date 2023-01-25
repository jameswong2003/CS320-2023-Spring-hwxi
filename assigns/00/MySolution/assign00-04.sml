use "./../MySolution/assign00-03.sml";

fun str2int(cs: string): int =
let
    (* Function that converts a single char to its corresponding digit *)
    fun helper(x: char): int = Char.ord(x) - 48
    (* Function that does exponents *)
    fun power(b: int, e: int): int = if e = 0 then 1 else b * power(b, (e-1));
    (* Function that removes the first char of a string starting at index 0*)
    fun removeFirst(x: string, index: int): string =
    if (String.sub(x, 0); false) handle Subscript => true then ""
    else if index = 0 then "" ^ removeFirst(x, index + 1)
    else String.str(String.sub(x, index)) + removeFirst(x, index + 1)
in
    (* if (String.sub(cs, 0); false) handle Subscript => true then 0 else
    (helper(String.sub(cs, 0)) * (power(10, String.size(cs) - 1))) + str2int(cs: string) *)
    removeFirst(cs)
end