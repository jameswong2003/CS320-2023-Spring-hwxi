use "./../assign00-lib.sml";

fun int2str(i: int): string =
let
    (* converts single digits into a string *)
    val digit = i mod 10
    fun helper(n: int): string =
        let 
            val a = Char.chr (n+48) 
        in 
            String.str a
        end
in
    if (i div 10) = 0 then helper i else int2str(i div 10) ^ helper(digit)
end