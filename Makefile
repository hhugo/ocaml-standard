
ENT_LAT="http://www.w3.org/MarkUp/DTD/xhtml-lat1.ent"
ENT_SPE="http://www.w3.org/MarkUp/DTD/xhtml-special.ent"
ENT_SYM="http://www.w3.org/MarkUp/DTD/xhtml-symbol.ent"

download-entities-xml:
	mkdir -p doc/entities
	curl ${ENT_LAT} -o doc/entities/lat1.xml
	curl ${ENT_SPE} -o doc/entities/spe.xml
	curl ${ENT_SYM} -o doc/entities/sym.xml


entities:
	ocamlbuild -use-ocamlfind -syntax camlp4o -package xml-light,lwt.syntax,lwt.unix,yojson,jsonm web/entities.byte --
