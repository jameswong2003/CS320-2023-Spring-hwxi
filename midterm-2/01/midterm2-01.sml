(* ****** ****** *)

use "./../../mysmlib/mysmlib-cls.sml";

(* ****** ****** *)

(*
//
// HX-2023-04-20: 20 points
//
Given a stream fxs of real numbers a0, a1, a2, ...
and a real number x0, stream_evaluate(fxs, x0)
returns another stream of real number that enumerates
all of the following partial sums:
a0, a0 + a1*x0, a0 + a1*x0 + a2*x0^2, ...
The general form of the enumerated sums is given as follows:
(a0 + a1*x0 + a2*x0^2 + ... + an * x0^n)
//
Assume:
a0 = 0, a1 = 1, a2 = -1/2, a3 = 1/3, a4 = -1/4, ...
Then we have ln2 = stream_evaluate(fxs, 1.0) // see Assign06-01
//
*)

(* ****** ****** *)

fun power(x: real, n: int) : real =
  if n = 0 then 1.0
  else if n mod 2 = 0 then power(x * x, n div 2)
  else x * power(x * x, n div 2)

fun
stream_evaluate
(fxs: real stream, x0: real): real stream = 
    let fun help(fxs, xn, n) = fn() =>
      case fxs() of
        strcon_nil => strcon_nil
      | strcon_cons(an, fxs) =>
          let
            val x1 = xn + an * power(x0 ,n)
          in
            strcon_cons(x1, help(fxs, x1, n+1))
          end
  in
    help(fxs, 0.0, 0)
  end

(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm2-01.sml] *)
