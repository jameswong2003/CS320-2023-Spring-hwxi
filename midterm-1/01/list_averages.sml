(* ****** ****** *)
use "./../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
(*
int2real
coerces an int into a real:
*)
val int2real = Real.fromInt
(* ****** ****** *)
(*
HX-2023-03-01: midterm1-01: 10 points
*)
(* ****** ****** *)
(*
Given a list of reals xs, list_averages(xs)
returns another list ys of reals such that:
ys[0] = xs[0] / 1.0
ys[1] = (xs[0] + xs[1]) / 2.0
ys[2] = (xs[0] + xs[1] + xs[2]) / 3.0
In general, ys[i] is the average of the first
(i+1) elements in xs.
//
For instance,
list_averages([]) = []
list_averages([1.0,2.0,3.0]) = [1.0,1.5,2.0]
list_averages([1.0,2.0,3.0,4.0]) = [1.0,1.5,2.0,2.5]
//
Note that you are allowed to define recursive
functions in your implementation of list_averages.
//
*)
(* ****** ****** *)
(*
fun
list_averages(xs: real list): real list = ...
*)
(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm1-list_averages.sml] *)

fun list_averages(xs: real list): real list =
    let
        fun loop([], _, _, ys) = ys
          | loop(x::xs', prev_sum, i, ys) =
            let
                val new_sum = prev_sum + x
                val new_average = new_sum / (int2real (i + 1))
            in
                loop(xs', new_sum, i + 1, new_average::ys)
            end
    in
        list_reverse(loop(xs, 0.0, 0, []))
    end
