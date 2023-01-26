use "./../MySolution/assign00-03.sml";

fun stringrev(cs: string): string =
let
    fun reverse(x: string, index: int): string = 
        if index = 0 then String.str(String.sub(x, index))
        else String.str(String.sub(x, index)) ^ reverse(x, index - 1)
in
    if String.size cs = 0 then "" else reverse(cs, String.size cs - 1)
end