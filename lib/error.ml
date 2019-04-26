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

type t =
  | Unknown of string
  | Unclosed_loop of Location.t
  | Unopened_loop of Location.t
  | Loop_stagnation of Location.t

let pp ppf = function
  | Unknown s ->
    Format.fprintf ppf "Unknown(%s)" s
  | Unclosed_loop loc ->
    Format.fprintf ppf "Unclosed_loop(%a)" Location.pp loc
  | Unopened_loop loc ->
    Format.fprintf ppf "Unopened_loop(%a)" Location.pp loc
  | Loop_stagnation loc ->
    Format.fprintf ppf "Loop_stagnation(%a)" Location.pp loc
;;

let to_string = Format.asprintf "%a" pp
