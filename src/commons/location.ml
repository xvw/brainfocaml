type t =
  { line : int
  ; column : int
  }

let make ?(line = 1) ?(column = 0) () = { line; column }
let move_left loc = { loc with column = loc.column - 1 }
let move_right loc = { loc with column = loc.column + 1 }
let move_down loc = { loc with column = loc.line + 1 }
let move_up loc = { loc with column = loc.line - 1 }

let pp ppf location =
  Format.fprintf ppf "{line = %d; column = %d}" location.line location.column
;;

let eq a b = a.line = b.line && a.column = b.column
let to_string = Format.asprintf "%a" pp
