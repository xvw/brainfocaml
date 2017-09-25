.PHONY: clean all

all: exe

lib:
	ocamlbuild -I src brainfuck.cma

exe: lib
	ocamlbuild -I src brainofocaml.native

clean:
	rm -rf *.byte
	rm -rf *.native
	rm -rf _build
	rm -rf .cache

repl: lib
	ledit ocaml -I _build/src brainfuck.cma
