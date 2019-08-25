type t =
  | Unknown of string
  | Unclosed_loop of Location.t
  | Unopened_loop of Location.t
  | Loop_stagnation of Location.t

let pp ppf = function
  | Unknown s ->
    Format.fprintf ppf "Unknown(%s)" s
  | Unclosed_loop loc ->
    Format.fprintf ppf "Unclosed_loop(%a)" Location.pp loc
  | Unopened_loop loc ->
    Format.fprintf ppf "Unopened_loop(%a)" Location.pp loc
  | Loop_stagnation loc ->
    Format.fprintf ppf "Loop_stagnation(%a)" Location.pp loc
;;

let eq a b =
  match a, b with
  | Unknown s, Unknown y ->
    s = y
  | Unclosed_loop a, Unclosed_loop b ->
    Location.eq a b
  | Unopened_loop a, Unopened_loop b ->
    Location.eq a b
  | Loop_stagnation a, Loop_stagnation b ->
    Location.eq a b
  | _ ->
    false
;;

let to_string = Format.asprintf "%a" pp
