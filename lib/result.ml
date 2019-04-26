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

type 'a t = ('a, Error.t) result

let pure x = Ok x
let err x = Error x
let and_then f = function Ok x -> f x | Error x -> err x
let map f = and_then (fun x -> pure (f x))

module Infix = struct
  let ( <$> ) x f = map f x
  let ( >>= ) x f = and_then f x
end

include Infix
