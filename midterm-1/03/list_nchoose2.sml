(* ****** ****** *)
use "./../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
(*
HX-2023-03-01: midterm1-03: 10 points
*)
(* ****** ****** *)

(*
//
Given a list of distnct integers xs,
list_nchoose2(xs) returns a list of all
the pairs (x1, x2) such that x1 and x2 are
two elements from xs satisfying x1 <= x2.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//
For instance,
list_nchoose2([1,3,2]) =
[ (1,3), (1,2), (2,3) ]
list_nchoose2([3,2,1]) =
[ (2,3), (1,3), (1,2) ]
list_nchoose2([3,2,1,4]) =
[(2,3),(1,3),(1,2),(1,4),(2,4),(3,4)]
Note that the returned list is treated as a
set, and the order of the elements in the list
is insignificant.
*)

(* ****** ****** *)

(*
fun
list_nchoose2(xs: int list): (int * int) list = ...
*)

(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm1-list_nchoose2.sml] *)

fun
list_nchoose2(xs: int list): (int * int) list =
    let
        val a = ref []
        val _ = foreach_to_iforeach(list_foreach)(xs, fn(i, n) =>  
                foreach_to_iforeach(list_foreach)(xs, fn(p, x) => if (p = i) then () else if
                (n < x) then a := list_append(!a, [(n,x)])
                else () )
        )
    in
        !a
    end