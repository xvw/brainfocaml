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
  { line : int
  ; column : int
  }

let make ?(line = 1) ?(column = 0) () = { line; column }
let move_left loc = { loc with column = loc.column - 1 }
let move_right loc = { loc with column = loc.column + 1 }
let move_down loc = { loc with column = loc.line + 1 }
let move_up loc = { loc with column = loc.line - 1 }

let pp ppf location =
  Format.fprintf
    ppf
    "{line = %d; column = %d}"
    location.line
    location.column
;;

let to_string = Format.asprintf "%a" pp
