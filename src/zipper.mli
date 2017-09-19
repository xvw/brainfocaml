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

(** This module describe a generic (and infinite) zipper *)

type 'a t

(** Create a new zipper *)
val create : 'a -> 'a t

(** move left in the zipper *)
val move_left : 'a t -> 'a t

(** move right in the zipper  *)
val move_right : 'a t -> 'a t

(** Get the current value of the zipper  *)
val current : 'a t -> 'a

(** Replace the current value by another  *)
val replace_by : 'a t -> 'a -> 'a t

(** Replace with a function the value of the current element *)
val replace : ('a -> 'a) -> 'a t -> 'a t
