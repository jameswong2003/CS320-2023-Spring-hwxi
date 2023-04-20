(* ****** ****** *)

use "./../../mysmlib/mysmlib-cls.sml";

(* ****** ****** *)

(*
//
// HX-2023-04-20: 20 points
//
A sequence xs of integers captures '231'
if there are three integers a, b, and c
appearing as a subsequence of xs satisfying
c < a < b. Note that a, b, and c do not have
to appear consecutively in xs.

For instance, [1,3,4,2] does capture '231'
For instance, [1,2,4,3] does not capture '231'
For instance, [1,2,3,4] does not capture '231'
*)

(* ****** ****** *)

fun
perm_capture_231(xs: int list): bool = 
let
    exception True
    val len = list_length(xs)
in
    let
        val _ = foreach_to_iforeach(list_foreach)(xs, 
            fn(i,x) => if (i >= len - 2) then () 
            else if (list_get_at(xs,i+2) < x andalso x < list_get_at(xs,i+1) ) then raise True else ()
        )
    in
        false
    end handle True => true
end

(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm2-05.sml] *)
