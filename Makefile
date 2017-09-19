lib:
	ocamlbuild -I src brainfuck.cma

clean:
	rm -rf *.byte
	rm -rf *.native
	rm -rf _build
	rm -rf .cache

repl: lib
	ledit ocaml -I _build/src brainfuck.cma
