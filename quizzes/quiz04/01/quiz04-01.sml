(* ****** ****** *)
use "./../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
Please put your implementation here for quiz04-01
*)

val theAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

fun alphabeta_cycling_list(): char stream strcon =
let
    val char_stream = string_streamize(theAlphabet)
    fun create_stream(c: char stream): char stream strcon =
        strcon_cons(c, fn () => create_stream(c))
in
    create_stream(char_stream)
end
(* ****** ****** *)

(* end of [CS320-2023-Spring-quizzes-quiz04-01.sml] *)