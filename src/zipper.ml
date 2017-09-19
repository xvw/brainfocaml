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


type 'a t =
  {
    left    : 'a list
  ; right   : 'a list
  ; default : 'a
  }

let create default_value =
  {
    left    = [default_value]
  ; right   = [default_value]
  ; default = default_value
  }

let move_left zip =
  let (left, right) = match zip.left with
    | [] -> ([zip.default], zip.default :: zip.right)
    | x :: xs -> (xs, x :: zip.right)
  in { zip with left = left; right = right }

let move_right zip =
  let (left, right) = match zip.right with
    | [] -> (zip.default :: zip.left, [zip.default])
    | x :: xs -> (zip.left, xs)
  in { zip with left = left; right = right}

let current zip =
  match zip.left with
  | [] -> zip.default
  | x :: _ -> x

let replace f zip =
  let new_value = match zip.left with
    | [] -> [f zip.default]
    | x :: xs -> (f x) :: xs
  in { zip with left = new_value }

let replace_by zip value =
  replace (fun _ -> value) zip
