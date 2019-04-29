let test name callback = name, `Quick, callback

module Pp = struct
  open Lib.Parser

  let rec token formatter = function
    | Memory x ->
      Format.fprintf formatter "Memory(%d)" x
    | Cursor x ->
      Format.fprintf formatter "Cursor(%d)" x
    | Input ->
      Format.fprintf formatter "Input"
    | Output ->
      Format.fprintf formatter "Output"
    | Clear ->
      Format.fprintf formatter "Clear"
    | Loop elements ->
      Format.fprintf formatter "[@[<hov 1>%a@]]" tokens elements

  and tokens formatter = function
    | x :: (_ :: _ as xs) ->
      let () = Format.fprintf formatter "%a@ " token x in
      tokens formatter xs
    | x :: xs ->
      let () = Format.fprintf formatter "%a" token x in
      tokens formatter xs
    | [] ->
      ()
  ;;

  let program formatter (elements, is_pure) =
    let flag = if is_pure then "Pure" else "Impure" in
    Format.fprintf formatter "%s(%a)" flag tokens elements
  ;;
end

module Eq = struct
  open Lib.Parser

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

  let program (a, b) (x, y) = tokens a x && b = y
end

module Testable = struct
  let program = Alcotest.testable Pp.program Eq.program
  let location = Alcotest.testable Lib.Location.pp Lib.Location.eq
  let error = Alcotest.testable Lib.Error.pp Lib.Error.eq
  let result a = Alcotest.result a error
end

module Check = struct
  let string message str expected =
    let result_program = str |> Stream.of_string |> Lib.Parser.from_stream in
    Alcotest.check Testable.(result program) message result_program expected
  ;;
end
