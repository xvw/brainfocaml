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

exception Not_inlinable

let eval interactive =
  let rec loop mem = function
    | [] -> mem
    | (Parser.Memory amount) :: xs ->
       loop (Memory.memory mem amount) xs
    | (Parser.Cursor amount) :: xs ->
       loop (Memory.cursor mem amount) xs
    | Parser.Output :: xs ->
       loop (Memory.output ~interactive:interactive mem) xs
    | Parser.Input :: xs ->
       loop (Memory.input mem) xs
    | Parser.Nullify :: xs ->
       loop (Memory.nullify mem) xs
    | ((Parser.Loop loop_ctn) :: xs) as tokens ->
       if Memory.need_jump mem
       then loop mem xs
       else
         let new_mem = loop mem loop_ctn in
         loop new_mem tokens
  in loop (Memory.create ())
   
let run_stream stream =
  stream
  |> Parser.from_stream
  |> Parser.tokens
  |> eval true
  |> ignore

let run_string string =
  string
  |> Stream.of_string
  |> run_stream

let run_file filename =
  filename
  |> open_in
  |> Stream.of_channel
  |> run_stream

let eval_stream stream =
  stream
  |> Parser.from_stream
  |> Parser.tokens
  |> eval false
  |> Memory.tape

let eval_string string =
  string
  |> Stream.of_string
  |> eval_stream
  
let eval_file filename =
  filename
  |> open_in
  |> Stream.of_channel
  |> eval_stream  

let inline string =
  let parsed = Parser.from_string string in
  if not (Parser.is_pure parsed) then
    raise Not_inlinable
  else
    parsed
    |> Parser.tokens
    |> eval false
    |> Memory.tape
