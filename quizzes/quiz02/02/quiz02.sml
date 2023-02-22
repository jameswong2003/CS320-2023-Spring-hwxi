(* ****** ****** *)
(* end of [CS320-2023-Spring-quizzes-quiz02_01.sml] *)
(* Quiz02-02: *)

val abs =
fn(x:int) => if x >= 0 then x else ~x

fun quiz02_02 (xs: int list, ys: int list): bool =
    let
        fun checkPairs (x: int, ys: int list): bool =
            case ys of
                [] => false
              | y::ys => if abs(x - y) < 10 then true else checkPairs(x, ys)
    in
        case xs of
            [] => false
          | x::xs => checkPairs(x, ys) orelse quiz02_02(xs, ys)
    end