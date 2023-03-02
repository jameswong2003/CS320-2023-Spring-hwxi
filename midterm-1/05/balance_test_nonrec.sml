(* ****** ****** *)
(*
HX-2023-03-02: midterm-05: 20 points
//
No other library functions are allowed
for solving this problem. Not even those
in the library for this class are allowed.
//
*)
(* ****** ****** *)
datatype 'a bintr =
LEAF of 'a | NODE of 'a bintr * 'a bintr
(* ****** ****** *)

(*
HX-2023-03-01: 20 points
The following function is essentially
the same as mapt given on slide 16 in
SLIDE/Summary-SMLNJ.pdf
*)
val
bintr_fold =
fn
( t0: 'a bintr
, fleaf: 'a -> 'r
, fnode: 'r * 'r -> 'r) =>
let
(* ****** ****** *)
val
rec
fold =
fn(t0) =>
case t0 of
LEAF(x0) => fleaf(x0)
|
NODE(tl, tr) =>
fnode(fold(tl), fold(tr))
(* ****** ****** *)
in
  fold(t0)
end (* end of [bintr_fold(t0, fleaf, fnode)] *)

(* ****** ****** *)

val
int_max =
fn(x, y) => if x >= y then x else y

(* ****** ****** *)

(*
Here are some examples that are based
on the bintr_fold combinator
*)

val
bintr_size =
fn(t0) =>
bintr_fold
( t0
, fn _ => 1
, fn(tl, tr) => tl + tr)

val
bintr_height =
fn(t0) =>
bintr_fold
( t0
, fn _ => 1
, fn(tl, tr) => 1+int_max(tl,tr))

(* ****** ****** *)

(*
//
HX-2023-03-01:
//
The following recursive function
[bintr_balanced_rec] checks whether
a given bintr is perfectly balanced.
//
LEAF(x) is perfectly balanced.
NODE(tl, tr) is perfectly balanced if
(1) tl is perfectly balanced, and
(2) tr is perfectly balanced, and
(3) tl and tr are of the same size (or height)
*)

(* ****** ****** *)
(*
//
Here is a recursive implementation that
checks if a given bintr is perfectly balanced
//
fun
bintr_balanced_rec
(t0: 'a bintr): bool =
(
case t0 of
LEAF _ => true
|
NODE(tl, tr) =>
bintr_balanced_rec(tl)
andalso bintr_balanced_rec(tr)
andalso bintr_size(tl) = bintr_size(tr)
)
*)
(* ****** ****** *)

(*
val
bintr_balanced_nonrec = fn(t0: 'a bintr) => ...
*)

(* ****** ****** *)

(*
Some testing code:
val t0 = LEAF(0)
val t1 = NODE(t0, t0)
val t2 = NODE(t1, t1)
val t3 = NODE(t2, t2)
(* ans1 = true *)
val ans1 = bintr_balanced_nonrec(t3)
(* ans2 = false *)
val ans2 = bintr_balanced_nonrec(NODE(t2, t3))
*)

(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm1-balance_test_nonrec.sml] *)

val bintr_balanced_nonrec =
fn (t0: 'a bintr) =>
let
  (* Define a stack to store unvisited nodes *)
  val stack = ref([])

  (* Initialize the stack with the root node and its size *)
  val () = stack := [(t0, bintr_size t0)]

  (* Track the size of the left and right subtrees *)
  val (left_size, right_size) = ref(0), ref(0)

  (* Track if the tree is balanced or not *)
  val balanced = ref(true)

  (* Traverse the tree iteratively *)
  while !stack <> [] andalso !balanced do
    (* Pop the top node from the stack *)
    val (node, size) = hd(!stack)
    val () = stack := tl(!stack)

    (* Check if the node is a leaf *)
    case node of
      LEAF _ => ()

    (* If the node is a branch, push its children onto the stack *)
    | NODE(tl, tr) =>
        let
          val tl_size = bintr_size tl
          val tr_size = bintr_size tr

          (* Check if the sizes of the subtrees are equal *)
          val () = if !left_size = 0 then left_size := tl_size
                   else if tl_size <> !left_size then balanced := false
                   else ()
          val () = if !right_size = 0 then right_size := tr_size
                   else if tr_size <> !right_size then balanced := false
                   else ()

          val () = stack := (tl, tl_size) :: (tr, tr_size) :: !stack
        end
  (* If we get here, all subtree sizes were equal *)
  in
    !balanced
  end
