(* ****** ****** *)
(*
use "./../assign03.sml";
use "./../assign03-lib.sml";
*)
(* ****** ****** *)

(*
HX-2023-02-10: 20 points
Given a list of integers xs,
please implement a function that find
the longest ascending subsequences of [xs].
If there are more than one such sequences,
the left most one should be returned.

fun list_longest_ascend(xs: int list): int list
*)

(* ****** ****** *)

(* end of [CS320-2023-Spring-assign03-04.sml] *)

fun list_longest_ascend(xs : int list) : int list =
    let
        fun list_size(xs : 'a list) : int =
            let
                fun help(xs : 'a list, i : int) : int =
                    case xs of
                        [] => i
                    | x :: xs => help(xs, i + 1)
            in
                help(xs,0)
            end

        fun list_size_compare(xs : 'a list, ys : 'a list) : 'a list =
            case list_size(xs) >= list_size(ys) of
                true => xs
            |   false => ys

        fun longest_head(xs : int list) : int list =
            case xs of
                [] => []
             | [x] => [x]
             | x1 :: x2 :: xs => 
            if x1 <= x2 then
            list_size_compare(x1 :: longest_head(x2 :: xs), longest_head(x1 :: xs))
            else
            longest_head(x1 :: xs)

        fun get_longest(xs : int list, long : int list) : int list =
            case xs of
                [] => long
             | x :: xs => let
                            val ys = longest_head(x :: xs)
                          in
                            if list_size(ys) > list_size(long) then get_longest(xs, ys) 
                            else get_longest(xs, long)
                          end
    in
        get_longest(xs,[])
    end