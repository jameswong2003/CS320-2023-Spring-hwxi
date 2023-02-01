use "./../assign01.sml";

 fun xlist_remove_reverse(xs: 'a xlist): 'a xlist = 
  let 
    (* Reverses the xlist *)
    fun helper(xs: 'a xlist, acc: 'a xlist): 'a xlist = 
      (
        case xs of 
        xlist_nil => acc
        | xlist_cons(x, xs') => helper(xs', xlist_cons(x, acc))
        | xlist_snoc(xs', x) => helper(xs', xlist_snoc(acc, x))
        | xlist_append(xs1, xs2) => helper(xs2, helper(xs1, acc))
        | xlist_reverse(xs') => 
      )
  in 
      case xs of 
      xlist_reverse(xs') => helper(xs', xlist_nil)
      | _ => xs
  end 
