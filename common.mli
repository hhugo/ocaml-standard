module R : sig

  type t = { uri : string option; path : string }

  val make_uri : ?path:string -> uri:string -> unit -> t
  val make : path:string -> t
  val download_uri : ?force:bool -> t -> unit Lwt.t
  val to_jsonm : ?encoding:[< Jsonm.encoding ] -> t -> Jsonm.decoder Lwt.t
  val to_yojson : t -> Yojson.Safe.json Lwt.t
  (* val to_tyxml : t -> Simplexmlparser.xml list Lwt.t *)
  val to_xml : t -> Xml.xml Lwt.t
  val to_dtd : t -> Dtd.dtd Lwt.t
  val to_stream : t -> string Lwt_stream.t Lwt.t
end
