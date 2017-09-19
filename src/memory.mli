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

(** Describe a Zipper to manage the Memory *)

type t


(** Initialize a new memory box *)
val create : unit -> t

(** Move into the memory with a particuliar amount *)
val cursor : t -> int -> t

(** Set the current value to zero *)
val nullify : t -> t

(** Change the memory with a particular amount  *)
val memory : t -> int -> t

(** Input a value in the memory *)
val input : t -> t

(** Output a value from the memory  *)
val output : ?interactive:bool -> t -> t
