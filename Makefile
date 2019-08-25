.PHONY: build doc test

all: build

build:
	dune build

doc:
	dune build @doc

test:
	dune runtest -f
