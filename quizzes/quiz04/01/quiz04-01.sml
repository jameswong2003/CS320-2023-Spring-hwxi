(* ****** ****** *)
use "./../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
Please put your implementation here for quiz04-01
*)

val theAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

fun alphabeta_cycling_list():char stream = fn() =>
  let
    val theAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    fun cycle i = 
      strcon_cons(String.sub(theAlphabet, i mod 26), fn () => cycle (i + 1))
  in
    cycle 0
  end
(* ****** ****** *)

(* end of [CS320-2023-Spring-quizzes-quiz04-01.sml] *)