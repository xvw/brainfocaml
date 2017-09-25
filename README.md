# Brainofcaml 
Yet another random and useless brainfuck interpreter/compiler

## Compilation 

Require OCaml (=< 4.05)

`make` : produce a library **Brainfuck.cma** and an executable
**brainofcaml.native**

## Usage (in the order)

```
./brainofcaml.native "brainfuck sequence"
./brainofcaml.native -f file.bf
./brainofcaml.native compile -o output"brainfuck sequence"
./brainofcaml.native compile -o output -f file.bf
./brainofcaml.native transpile -o output.c "brainfuck sequence"
./brainofcaml.native transpile -o output.c -f file.bf
```
