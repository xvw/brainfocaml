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


let usage = {|

    USAGE (order is important, because i'm tired...)

    ./brainofcaml.native "brainfuck sequence"
    ./brainofcaml.native -f file.bf
    ./brainofcaml.native compile -o output"brainfuck sequence"
    ./brainofcaml.native compile -o output -f file.bf
    ./brainofcaml.native transpile -o output.c "brainfuck sequence"
    ./brainofcaml.native transpile -o output.c -f file.bf
|}


let exec_string = Runner.run_string
let exec_file = Runner.run_file
let transpile_string seq out  =
  seq
  |> Runner.string_to_c
  |> fun x -> Runner.dump_c_file x out
                     
let transpile_file out file =
  Runner.read_file file
  |> fun x -> transpile_string x out
  

let compile_string output content =
  let f = "./temp_brainfuck.c" in
  let () =
    content
    |> Runner.string_to_c
    |> fun x -> Runner.dump_c_file x f
  in
  let _ = Sys.command (Format.sprintf "gcc -O2 -o %s %s" output f) in
  Sys.remove f
            
  
  
  
let compile_file out file =
  file
  |> Runner.read_file
  |> compile_string out

let () = match Sys.argv with
  | [|_; brainfuck |] -> exec_string brainfuck
  | [|_; "-f"; file|] -> exec_file file 
  | [|_; "compile"; "-o"; o;  brainfuck|] -> compile_string o brainfuck
  | [|_; "compile"; "-o"; o; "-f"; file|] -> compile_file o file
  | [|_; "transpile"; "-o"; o;  brainfuck|] -> transpile_string brainfuck o
  | [|_; "transpile"; "-o"; o; "-f"; file|] -> transpile_file o file
  | _ -> print_endline usage
