module R = struct

  type t = { uri : string option; path : string }

  let make_uri ?path ~uri () =
    let path = match path with
      | Some p -> p
      | None ->
        let pos = String.rindex uri '/' in
        try
          String.sub uri (succ pos) (String.length uri - pos - 1)
        with _ -> Printf.printf "%s %d\n" uri pos; assert false
    in {uri=Some uri;path}
  let make ~path = {uri=None;path}
  let download_uri ?(force=false) r = match r.uri with
    | None -> Lwt.return_unit
    | Some uri ->
      if (not (Sys.file_exists r.path)) || force
      then
        lwt ps = Lwt_process.exec ("curl", [| "curl"; uri; "-o"; r.path |]) in
        match ps with
        | Unix.WEXITED 0 -> Lwt.return_unit
        | _ -> Lwt.fail (Failure "Could not get the ressouce")
      else if Sys.file_exists r.path
      then Lwt.return_unit
      else Lwt.fail (Failure "Could not get the ressouce")

  let to_jsonm ?encoding r =
    lwt () = download_uri r in
    let ic = open_in r.path in
    Lwt.return (Jsonm.decoder ?encoding (`Channel ic))

  let to_yojson r =
    lwt () = download_uri r in
    Lwt.return (Yojson.Safe.from_file r.path)
  (* let to_tyxml r = *)
  (*   lwt () = download_uri r in *)
  (*   Lwt.return (Simplexmlparser.xmlparser_file r.path) *)
  let to_xml r =
    lwt () = download_uri r in
    Lwt.return (Xml.parse_file r.path)

  let to_dtd r =
    lwt () = download_uri r in
    Lwt.return (Dtd.parse_file r.path)

  let to_stream r =
    lwt () = download_uri r in
    Lwt.return (Lwt_io.lines_of_file r.path)


end
