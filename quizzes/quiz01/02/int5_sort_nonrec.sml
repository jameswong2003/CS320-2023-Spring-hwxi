(* ****** ****** *)
(*
HX-2023-02-07: 50 points
*)
(* ****** ****** *)

type int2 = int * int
type int3 = int * int * int
type int4 = int * int * int * int
type int5 = int * int * int * int * int

(* ****** ****** *)

(*
The following function int5_sort
is based on ListMergeSort.sort, which is
defined recursively. Given a tuple of 5
integers, int5_sort returns an ordered tuple
of the same 5 integers. For instance,
int5_sort(1, 2, 1, 2, 2) = (1, 1, 2, 2, 2)
int5_sort(3, 1, 2, 5, 2) = (1, 2, 2, 3, 5)
int5_sort(3, 1, 2, 5, 4) = (1, 2, 3, 4, 5)
*)

(*
val
int5_sort =
fn(xs: int5): int5 =
let
val (x1, x2, x3, x4, x5) = xs
val ys =
ListMergeSort.sort(op>=)[x1,x2,x3,x4,x5]
val y1 = hd(ys) and ys = tl(ys)
val y2 = hd(ys) and ys = tl(ys)
val y3 = hd(ys) and ys = tl(ys)
val y4 = hd(ys) and ys = tl(ys)
val y5 = hd(ys) and ys = tl(ys)
in
  (y1, y2, y3, y4, y5)
end
*)

(* ****** ****** *)
(*
Please give a non-recursive implementation of int5_sort
as int5_sort_nr. That is, please implement int5_sort_nr
in a non-recursive manner such that int5_sort(xs) equals
int5_sort_nr(xs) for every 5-tuple xs of the type int5.
*)
(* ****** ****** *)

fun
int5_sort_nr(xs: int5): int5 =
(*
Please Give your implementation as follows:
*)
let
  val c1 = #1 xs
  val c2 = #2 xs
  val c3 = #3 xs
  val c4 = #4 xs
  val c5 = #5 xs

  fun helper_int2(xs: int2): int2 =
    if (c1 < c2)
    then (c1,c2)
    else (c2,c1)

  fun helper_int3(xs: int2): int3 =
    if (c3 < #1 xs)
    then (c3, #1 xs, #2 xs)
    else if (c3 < #2 xs)
    then (#1 xs, c3, #2 xs)
    else (#1 xs, #2 xs, c3)

  fun helper_int4(xs: int3): int4 =
    if(c4 < #1 xs)
    then (c4, #1 xs, #2 xs, #3 xs)
    else if (c4 < #2 xs)
    then (#1 xs, c4, #2 xs, #3 xs)
    else if (c4 < #3 xs)
    then (#1 xs, #2 xs, c4, #3 xs)
    else (#1 xs, #2 xs, #3 xs, c4)

  fun helper_int5(xs: int4): int5 =
    if(c5 < #1 xs)
    then (c5, #1 xs, #2 xs, #3 xs, #4 xs)
    else if (c5 < #2 xs)
    then (#1 xs, c5, #2 xs, #3 xs, #4 xs)
    else if (c5 < #3 xs)
    then (#1 xs, #2 xs, c5, #3 xs, #4 xs)
    else if (c5 < #4 xs)
    then (#1 xs, #2 xs, #3 xs, c5, #4 xs)
    else (#1 xs, #2 xs, #3 xs, #4 xs, c5)
in
  helper_int5(helper_int4(helper_int3(helper_int2((c1, c2)))))
end

(* ****** ****** *)

(* end of [CS320-2023-Spring-quiz01-int5_sort_nonrec.sml] *)
