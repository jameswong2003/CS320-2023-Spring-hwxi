####################################################
#!/usr/bin/env python3
####################################################
import sys
sys.path.append('./../../../../mypylib')
from mypylib_cls import *
####################################################
#
# HX-2023-03-14: 20 points
# Please *translate* into Python the posted solution
# on Piazza for word_neighbors (which is writtend in SML)
#
def word_neighbors(word):
    """
    Note that this function should returns a fnlist
    (not a pylist)
    Your implementation should be combinator-based very
    much like the posted solution.
    """
    def string_implode(word_list):
        return foreach_to_foldleft(pylist_foreach)(word_list, "", lambda s, chr: s + chr)
    def string_tabulate(length, fopr):
        return string_implode(pylist_foldright(int1_foldleft(length, [], lambda xs, i: [[fopr(i)]] + xs), [], lambda r, x: x + r))

    length = len(word)
    AB = "abcdefghijklmnopqrstuvwxyz"

    return fnlist_concat(string_imap_fnlist(word, lambda i, c: fnlist_concat(string_imap_fnlist(AB, lambda _, c1: fnlist_sing(string_tabulate(length, lambda j: word[j] if i != j else c1)) if (c != c1) else fnlist_nil()))))

    

    raise NotImplementedError
#
####################################################
