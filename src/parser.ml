(*
 * A Simple BF Interpreter (teaching material)
 *
 * Copyright (C) 2017  Xavier Van de Woestyne <xaviervdw@gmail.com>
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

 
exception Brace_mismatch
exception Useless_infinite_loop

type token =
  | Memory of int
  | Cursor of int
  | Input
  | Output
  | Loop of token list
  | Nullify

type parsed = (token list * bool)


type end_of =
  | End_of_loop
  | End_of_stream


let memory current acc =
  let offset = if current = '+' then 1 else - 1 in
  let (value, rest) =
    match acc with
    | Memory x :: xs -> (x + offset, xs)
    | rest -> (offset, rest)
  in if value = 0 then rest else (Memory value) :: rest


let cursor current acc =
  let offset = if current = '>' then 1 else - 1 in
  let (value, rest) =
    match acc with
    | Cursor x :: xs -> (x + offset, xs)
    | rest -> (offset, rest)
  in if value = 0 then rest else (Cursor value) :: rest


let optimize = function
  | [Memory (-1)] -> Nullify
  | [] -> raise Useless_infinite_loop
  | [Memory x] when x >= 0 -> raise Useless_infinite_loop
  | result -> Loop result

let from_stream stream =
  
  let rec parse purity acc =
    
    match Stream.next stream with
      
    | ('+' | '-') as current ->
       parse purity (memory current acc)
      
    | ('>' | '<') as current ->
       parse purity (cursor current acc)
      
    | '.' -> parse purity (Output :: acc)
    | ',' -> parse false (Input :: acc)

    | '[' ->
       let (result, kind, new_purity) = parse purity [] in
       begin
         match kind with
         | End_of_stream -> raise Brace_mismatch
         | End_of_loop ->
            let loop = optimize result in 
            parse new_purity (loop :: acc)
       end
       
    | ']' -> (List.rev acc, End_of_loop, purity)

    | _   -> parse purity acc 
    | exception Stream.Failure ->
       (List.rev acc, End_of_stream, purity)

  in
  let (tokens, _, purity) = parse true [] in
  (tokens, purity)


let from_string string_value =
  string_value
  |> Stream.of_string
  |> from_stream


let is_pure = snd
let tokens = fst
