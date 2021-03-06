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


(** Run brainfuck code *)

exception Not_inlinable

val run_stream : char Stream.t -> unit

val run_string : string -> unit

val run_file : string -> unit

val eval_stream : char Stream.t -> string

val eval_string : string -> string

val eval_file : string -> string

val inline : string -> string

val stream_to_c : ?size:int -> char Stream.t -> string

val string_to_c : ?size:int -> string -> string

val file_to_c : ?size:int -> string -> string

val dump_c_file : string -> string -> unit

val read_file : string -> string

