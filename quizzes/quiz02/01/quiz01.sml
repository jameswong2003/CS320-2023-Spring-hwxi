(* Quiz02-01: *)
(* ****** ****** *)
use "./../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
val strlen = (* length *)
foreach_to_length(string_foreach)
val strsub = (* subscripting *)
foreach_to_get_at(string_foreach)
(* ****** ****** *)
(*
HX-2023-02-20:
Please implement a function
[quiz02_01' of the following type:
//
fun
quiz02_01
(word: string): char -> int =
//
Given a word 'word' (of the type string),
'quiz02_01(word)' returns a function of the
type 'char -> int'; when applied to a char,
this function returns the number of times this
char appears in 'word'.
For instance, we have
quiz02_01("$abb^cccdddd")(#"0") = 0
quiz02_01("$abb^cccdddd")(#"1") = 0
quiz02_01("$abb^cccdddd")(#"a") = 1
quiz02_01("$abb^cccdddd")(#"b") = 2
quiz02_01("$abb^cccdddd")(#"c") = 3
quiz02_01("$abb^cccdddd")(#"d") = 4
quiz02_01("$abb^cccdddd")(#"z") = 0
quiz02_01("$abb^cccdddd")(#"$") = 1
quiz02_01("$abb^cccdddd")(#"^") = 1
*)
(* ****** ****** *)

fun quiz02_01 (word: string) : char -> int = 
let
    val length = strlen(word)
    
    fun count(c: char): int =
    let
        fun loop(i: int, cnt: int): int =
        if i < length 
        then
            if strsub(word, i) = c 
            then loop(i + 1, cnt + 1)
            else loop(i + 1, cnt)
        else
            cnt
    in
        loop(0, 0)
    end
in
    count
end

(* ****** ****** *)
(* end of [CS320-2023-Spring-quizzes-quiz02_01.sml] *)
(* Quiz02-02: *)
(* ****** ****** *)
(* use "./../../../mysmlib/mysmlib-cls.sml"; *)
(* ****** ****** *)
(*
//
HX-2023-02-20: 60 points
//
Please implement a function of the name quiz02_02
that takes two lists xs and ys of integers and checks
whether there exists a pair (x, y) such that |x-y| < 10
where x is in xs and y is in ys.
//
*)
(* ****** ****** *)
(* val abs =
fn(x:int) => if x >= 0 then x else ~x *)
(* ****** ****** *)
(* val quiz02_02 : (int list * int list) : bool = ?? *)
(* ****** ****** *)
(* end of [CS320-2023-Spring-quizzes-quiz02_02.sml] *)

