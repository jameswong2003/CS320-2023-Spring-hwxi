(* ****** ****** *)

use "./../../mysmlib/mysmlib-cls.sml";

(* ****** ****** *)
(*
HX-2023-04-20:
Given a finite or infinite stream fxss of
infinite streams: fxs_0, fxs_1, fxs_2, ...,
stream_zipstrm(fxss) returns an infinite stream
of streams: gxs_0, gxs_1, gxs_2, ..., where we have
gxs_j[i] = fxs_i[j]. Note that this is just the
stream version of stream_ziplst (see Assign07-01).
*)
(* ****** ****** *)


fun
stream_zipstrm
( fxss
: 'a stream stream): 'a stream stream = fn() =>
let
    fun helper(xs, n) =
    let
        val l = foreach_to_foldleft(stream_foreach)
        (xs, fn() => strcon_nil, fn(a, strm) => 
            stream_append(a, fn() => strcon_cons(stream_get_at(strm, n), fn() => strcon_nil))
        ) 
    in
        strcon_cons(l, fn() => helper(xs, n + 1))
    end
in
    helper(fxss, 0)
end

(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm2-03.sml] *)
