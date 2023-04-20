(* ****** ****** *)

use "./../../mysmlib//mysmlib-cls.sml";

(* ****** ****** *)

(*
//
// HX-2023-04-20: 20 points
//
The mytree datatype is defined as follows.
Each node in mytree contains a stored element
plus a list of children, where the list can be
empty.
//
Please implement a function mytree_dfs_streamize
that enumerates a given mytree in a depth-first manner.
//
*)
(* ****** ****** *)

datatype 'a mytree =
  mytree_node of 'a * ('a mytree list)

(* ****** ****** *)


fun mytree_dfs_streamize (t: 'a mytree): 'a stream =
  let
    fun mytree_dfs_helper (t: 'a mytree): 'a stream =
      case t of
        mytree_node (x, []) => stream_cons (x, stream_nil())
      | mytree_node (x, ts) => 
        let
          fun mytree_dfs_helper_list (ts: 'a mytree list): 'a stream =
            case ts of
              [] => stream_nil()
            | (t::ts) => stream_append (mytree_dfs_helper t, mytree_dfs_helper_list ts)
        in
          stream_cons (x, mytree_dfs_helper_list ts)
        end
  in
    mytree_dfs_helper t
  end



(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm2-02.sml] *)
