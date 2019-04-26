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

(** Build an AST over a brainfuck sequence *)

(** Describe the brainfuck operation *)
type token =
  | Memory of int (** [+] or [-] *)
  | Cursor of int (** [<] or [>] *)
  | Input (** [,] *)
  | Output (** [.] *)
  | Loop of tokens (** Loop expr. *)
  | Clear (** [[-]] *)

(** Describe a list of tokens (a parsed brainfuck sequence) *)
and tokens = token list

(** Describe a brainfuck program where [tokens] is the tokens 
    sequence, and the flag is "if" the program is pure or not.
 *)
type program = tokens * bool

(** {2 Parsing} *)

val from_stream : char Stream.t -> program Result.t
