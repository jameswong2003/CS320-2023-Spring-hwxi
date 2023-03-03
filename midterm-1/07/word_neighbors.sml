(* ****** ****** *)
use "./../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
(*
HX-2023-03-01: midterm1-07: 20 points
*)
(* ****** ****** *)
(*
Note that you are not allowed to define
recursive functions for solving this one.
*)
(* ****** ****** *)
(*
Here are some functions that you
can use in your solution to this one.
*)
val
strsub = String.sub
val
string_length = String.size
val
string_implode = String.implode
val
string_filter =
foreach_to_filter_list(string_foreach)
val
string_tabulate =
fn(len, fopr) =>
string_implode(list_tabulate(len, fopr))

(* ****** ****** *)

(*
A word here is defined to be a (possibly empty)
sequence of lowcase letters in the English alphabet.
Two words w1 and w2 are neighbors if they are of the
same length and differ by exactly one letter.
//
For instance, [water] and [later] are neighbors.
For instance, [abcde] and [abxde] are neighbors.
For instance, [abcde] and [abcde] are not neighbors.
//
Given a word, the function [word_neighbors] returns
a list consisting of *all* the neighbors of the word.
//
fun word_neighbors(word: string): string list = ...
//
Please give an implementation of word_neighbors.
Note that you are NOT allowed to define recursive functions
in your implementation
//
*)

(* ****** ****** *)

val AB =
"abcdefghijklmnopqrstuvwxyz"

(* ****** ****** *)

val
string_iforeach =
foreach_to_iforeach(string_foreach)
val
string_imap_list =
fn(cs, ifopr) =>
foreach_to_map_list(string_iforeach)(cs, ifopr)

(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm1-word_neighbors.sml] *)

fun word_neighbors(word: string): string list =
    foreach_to_ifoldleft(string_foreach)(word, [], fn(l, i, c) =>
        let
            val final = ref [""]
            val _ = final := []
            val new_word_list = ref (string_listize(word))
            val r = ref ~1

            val make_nw = fn(p) =>
                if (p = i)
                    then new_word_list := !new_word_list @ [strsub(AB, !r)]
                else
                    new_word_list := !new_word_list @ [strsub(word, p)]
            val check = fn(n) =>
                if (strsub(AB, n) = c)
                    then ()
                else
                    let
                        val _ = r := n
                        val _ = new_word_list := []
                        val _ = int1_foreach(string_length(word), make_nw)
                        val nw = string_implode(!new_word_list)
                    in
                        if (list_exists(l, fn(x) => nw = x))
                            then ()
                        else
                            final := !final @ [nw]
                    end
            val _ = int1_foreach(26, check)
        in
            list_append(l, !final)
        end
    )
