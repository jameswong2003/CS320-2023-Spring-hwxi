(* ****** ****** *)
use "./../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
Please put your implementation here for quiz04-02
*)
fun stream_supremov(fxs:int stream) = fn() =>
    let 
        fun help (prev, Cons(x, xs)) =
            if x = prev then help(prev, xs())
            else strcon_cons(x, fn () => help(x, xs()))
    in
        case xs of
            strcon_cons(x, xs') => strcon_cons(x, fn () => help(x, xs'))
        | strcon_nil => strcon_nil
    end
(* ****** ****** *)

(* end of [CS320-2023-Spring-quizzes-quiz04-02.sml] *)