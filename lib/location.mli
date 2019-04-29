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

(** Describe a Location *)

(** Location *)
type t =
  { line : int
  ; column : int
  }

(** {2 Helpers} *)

val make : ?line:int -> ?column:int -> unit -> t
val move_left : t -> t
val move_right : t -> t
val move_up : t -> t
val move_down : t -> t
val pp : Format.formatter -> t -> unit
val eq : t -> t -> bool
val to_string : t -> string
