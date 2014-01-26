open Common

let url_lat1 = R.make_uri ~uri:"http://www.w3.org/MarkUp/DTD/xhtml-lat1.ent" ()
let url_spe =  R.make_uri ~uri:"http://www.w3.org/MarkUp/DTD/xhtml-special.ent" ()
let url_sym=   R.make_uri ~uri:"http://www.w3.org/MarkUp/DTD/xhtml-symbol.ent" ()

let main =
  try_lwt
    lwt xml = R.to_dtd url_lat1 in
    (* begin match xml with *)
    (*   | Xml.PCData s -> print_endline s *)
    (*   | Xml.Element (name,attr,elts) -> print_endline name end; *)
    Lwt.return_unit
  with Dtd.Parse_error er ->
    print_endline (Dtd.parse_error er);
    Lwt.return_unit

let _ = Lwt_main.run main
