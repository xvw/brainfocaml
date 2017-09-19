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

(** This module describes the Parsing tools for a Brainfuck sequence *)

(** Describe all brainfuck tokens *)
type token =
  | Memory of int
  | Cursor of int
  | Input
  | Output
  | Loop of token list


(** Parse a char Stream.t to a token list *)
val from_stream : char Stream.t -> token list  
