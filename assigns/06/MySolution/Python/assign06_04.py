####################################################
#!/usr/bin/env python3
####################################################
import sys
import queue
sys.path.append('../../../06')
sys.path.append('./../../../../mypylib')
from dictwords import *
from mypylib_cls import *
####################################################
"""
HX-2023-03-24: 30 points
Solving the doublet puzzle
"""
####################################################
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
####################################################

def children(curr_words, q):
    neighbors = word_neighbors(curr_words[-1])
    def helper(wd):
        if word_is_legal(wd):
            q.put(curr_words + (wd,))
    fnlist_foreach(neighbors, lambda w: helper(w))
    return None

def doublet_bfs(wordq, fchildren):
    def helper(words):
        if words.empty():
            return strcon_nil()
        else:
            curr = words.get()
            fchildren(curr,words)
            return strcon_cons(curr, lambda: helper(words))
    return lambda: helper(wordq)

def doublet_stream_from(word):
    """
    Please revisit assign05_02.py.
    ######
    Given a word w1 and another word w2, w1 and w2 are a
    1-step doublet if w1 and w2 differ at exactly one position.
    For instance, 'water' and 'later' are a 1-step doublet.
    The doublet relation is the reflexive and transitive closure
    of the 1-step doublet relation. In other words, w1 and w2 are
    a doublet if w1 and w2 are the first and last of a sequence of
    words where every two consecutive words form a 1-step doublet.
    Here is a little website where you can use to check if two words
    for a doublet or not:
    http://ats-lang.github.io/EXAMPLE/BUCS320/Doublets/Doublets.html
    ######
    Given a word, the function [doublet_stream_from] returns a stream
    enumerating *all* the tuples such that the first element of the tuple
    is the given word and every two consecutive words in the tuple form a
    1-step doublet. The enumeration of tuples should be done so that shorter
    tuples are always enumerated ahead of longer ones.
    ######
    """
    initq = queue.Queue()
    initq.put((word,))
    return doublet_bfs(initq,children)

# stream_iforall(doublet_stream_from("horse"), lambda i,x: i < 200 and not print(x))
####################################################