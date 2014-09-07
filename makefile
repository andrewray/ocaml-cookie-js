all:
	ocamlbuild -use-ocamlfind cookie.cmo

clean:
	ocamlbuild -clean
	- find . -name "*~" | xargs rm -f

install:
	ocamlfind install cookie-js META _build/src/cookie.cmo _build/src/cookie.cmi

uninstall:
	ocamlfind remove cookie-js

