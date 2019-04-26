(* A Simple BF Interpreter (teaching material)
 *
 * Copyright (C) 2019  Xavier Van de Woestyne <xaviervdw@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
*)

open Error

type token =
  | Memory of int
  | Cursor of int
  | Input
  | Output
  | Loop of tokens
  | Clear

and tokens = token list

type program = tokens * bool

let stream_peek stream =
  match Stream.next stream with
  | '+' ->
    `Plus
  | '-' ->
    `Minus
  | '<' ->
    `Left
  | '>' ->
    `Right
  | '.' ->
    `Point
  | ',' ->
    `Period
  | '[' ->
    `Opened_bracket
  | ']' ->
    `Closed_bracket
  | value ->
    `Char value
  | exception Stream.Failure ->
    `Empty
;;

let finalize_parsing is_pure acc = function
  | None ->
    Result.pure (List.rev acc, is_pure)
  | Some location ->
    Result.err (Unclosed_loop location)
;;

let memory operation acc =
  let offset = (function `Plus -> 1 | `Minus -> -1) operation in
  (match acc with
  | Memory x :: xs ->
    let value = x + offset in
    if value = 0 then xs else Memory value :: xs
  | xs ->
    Memory offset :: xs)
  |> Result.pure
;;

let cursor operation acc =
  let offset = (function `Right -> 1 | `Left -> -1) operation in
  (match acc with
  | Cursor x :: xs ->
    let value = x + offset in
    if value = 0 then xs else Cursor value :: xs
  | xs ->
    Cursor offset :: xs)
  |> Result.pure
;;

let io acc subject =
  let token =
    match subject with `Point -> Output | `Period -> Input
  in
  Result.pure (token :: acc)
;;

let from_stream stream =
  let rec parse bracket_stack is_pure potential_accumulator =
    let open Result.Infix in
    potential_accumulator
    >>= fun acc ->
    match stream_peek stream with
    | `Empty ->
      finalize_parsing is_pure acc bracket_stack
    | (`Plus | `Minus) as operation ->
      parse bracket_stack is_pure (memory operation acc)
    | (`Left | `Right) as operation ->
      parse bracket_stack is_pure (cursor operation acc)
    | (`Point | `Period) as operation ->
      operation |> io acc |> parse bracket_stack false
    | _ ->
      parse bracket_stack is_pure potential_accumulator
  in
  parse None true (Result.pure [])
;;
