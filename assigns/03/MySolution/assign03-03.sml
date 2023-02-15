(* ****** ****** *)
(*
use "./../assign03.sml";
use "./../assign03-lib.sml";
*)
(* ****** ****** *)

(*
//
HX-2023-02-10: 10 points
The function list_tabulate takes an integer
[n] and a function [f] and returns a list that
equals [f(0), f(1), ..., f(n-1)]
//
list_tabulate(n: int, f: int -> 'a): 'a list
//
*)

(* ****** ****** *)

(* end of [CS320-2023-Spring-assign03-03.sml] *)
fun list_tabulate(n: int, f: int -> 'a): 'a list = 
let
    fun create_list(n: int, f: int -> 'a, l: 'a list): 'a list =
    if n <= 0 then l
    else
        create_list(n - 1, f, f(n-1) :: l)
        
in
    create_list(n, f, nil)
end