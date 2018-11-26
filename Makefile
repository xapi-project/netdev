OPAM_PREFIX?=$(DESTDIR)$(shell opam config var prefix)
OPAM_LIBDIR?=$(DESTDIR)$(shell opam config var lib)

.PHONY: release build install uninstall clean test doc reindent

release:
	dune build @install --profile=release

build:
	dune build @install

install:
	dune install --prefix=$(OPAM_PREFIX) --libdir=$(OPAM_LIBDIR) -p xapi-netdev

uninstall:
	dune uninstall --prefix=$(OPAM_PREFIX) --libdir=$(OPAM_LIBDIR) -p xapi-netdev

clean:
	dune clean

test:
	dune runtest --profile=release

# requires odoc
doc:
	dune build @doc --profile=release

reindent:
	git ls-files '*.ml*' | xargs ocp-indent --syntax cstruct -i


.DEFAULT_GOAL := release
