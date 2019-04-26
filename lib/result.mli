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

(** Result Helper *)

type 'a t = ('a, Error.t) result

(** {2 Builders} *)

val pure : 'a -> 'a t
val err : Error.t -> 'a t

(** {2 API} *)

val map : ('a -> 'b) -> 'a t -> 'b t
val and_then : ('a -> 'b t) -> 'a t -> 'b t

(** {2 Infix} *)

module Infix : sig
  val ( <$> ) : 'a t -> ('a -> 'b) -> 'b t
  val ( >>= ) : 'a t -> ('a -> 'b t) -> 'b t
end

include module type of Infix
