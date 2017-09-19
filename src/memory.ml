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


type t = (int Zipper.t * Bytes.t)

let create () =
  (Zipper.create 0, "")

let cursor (mem, tape) value =
  let f =
    if value > 0
    then Zipper.move_right
    else Zipper.move_left
  in 
  let rec loop acc = function
    | 0 -> (acc, tape)
    | x -> loop (f acc) (succ x)
  in loop mem (abs value)

let memory (mem, tape) value =
  (Zipper.replace ((+) value) mem, tape)

let nullify (mem, tape) =
  (Zipper.replace_by mem 0, tape)

let input (mem, tape) =
  let z =
    (fun x -> x)
    |> Scanf.scanf "%c"
    |> int_of_char
    |> Zipper.replace_by mem
  in (z, tape)

let output ?(interactive=true) (mem, tape) =
  let char =
    mem
    |> Zipper.current
    |> char_of_int
  in
  let () = if interactive then print_char char in
  (mem, tape)
