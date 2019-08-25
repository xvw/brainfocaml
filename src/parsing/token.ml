type t =
  | Memory of int
  | Cursor of int
  | Input
  | Output
  | Loop of t list
  | Clear

module Pp = struct
  open Format

  let rec token formatter = function
    | Memory x ->
      fprintf formatter "Memory(%d)" x
    | Cursor x ->
      fprintf formatter "Cursor(%d)" x
    | Input ->
      fprintf formatter "Input"
    | Output ->
      fprintf formatter "Output"
    | Clear ->
      fprintf formatter "Clear"
    | Loop elts ->
      fprintf formatter "[@[<hov 1>%a@]]" tokens elts

  and tokens formatter = function
    | [] ->
      ()
    | x :: (_ :: _ as xs) ->
      let () = fprintf formatter "%a@ " token x in
      tokens formatter xs
    | x :: xs ->
      let () = fprintf formatter "%a" token x in
      tokens formatter xs
  ;;
end

module Eq = struct
  let rec token a b =
    match a, b with
    | Memory x, Memory y ->
      x = y
    | Cursor x, Cursor y ->
      x = y
    | Input, Input ->
      true
    | Clear, Clear ->
      true
    | Output, Output ->
      true
    | Loop xs, Loop ys ->
      tokens xs ys
    | _ ->
      false

  and tokens a b =
    match a, b with
    | x :: xs, y :: ys ->
      token x y && tokens xs ys
    | [], [] ->
      true
    | _ ->
      false
  ;;
end
