use "./../assign01.sml";

(* From assignment 00 *)
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


(* checker function that checks if valid string *)
fun checker(cs: string): bool=
let
    fun substring_helper(s: string, x: int): string= 
        if x > (String.size(s) - 1) then "" 
        else String.str(String.sub(s, x)) ^ substring_helper(s, x + 1)
in
    if cs = "" then true 
    else (
        if Char.ord(String.sub(cs, 0)) > 57 
        then false
        else(
            if Char.ord(String.sub(cs, 0)) < 48 then false
            else checker(substring_helper(cs, 1))
        )
    )
end

fun str2int_opt(cs: string): int option =
    if cs = "" then NONE
    else ( if checker(cs) then SOME(str2int(cs)) else NONE)