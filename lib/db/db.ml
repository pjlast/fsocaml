open Petrol

(** [collect_list db qry] executes the provided [qry] using the [db] connection
    and returns the result in a list. *)
let collect_list db qry =
  Dream.debug (fun log -> log "%s" (Format.asprintf "%a" Query.pp qry));
  let req = Request.make_many qry in
  Petrol.collect_list db req

(** [find db qry] executes the provided [qry] using the [db] connection and
    returns a single result. If no results are found, an error is returned. *)
let find db qry =
  Dream.debug (fun log -> log "%s" (Format.asprintf "%a" Query.pp qry));
  let req = Request.make_one qry in
  Petrol.find db req

(** [find_opt db qry] executes the provided [qry] using the [db] connection and
    returns a result as an [option]. *)
let find_opt db qry =
  Dream.debug (fun log -> log "%s" (Format.asprintf "%a" Query.pp qry));
  let req = Request.make_zero_or_one qry in
  Petrol.find_opt db req

(** [transact db fn] executes [fn] inside a database transaction. *)
let transact (module DB : Caqti_lwt.CONNECTION) fn = DB.with_transaction fn

(** Converts all the possible database errors to a printable string. *)
let error_to_string = function
  | `Connect_failed e -> Caqti_error.show (`Connect_failed e)
  | `Connect_rejected e -> Caqti_error.show (`Connect_rejected e)
  | `Decode_rejected e -> Caqti_error.show (`Decode_rejected e)
  | `Encode_failed e -> Caqti_error.show (`Encode_failed e)
  | `Encode_rejected e -> Caqti_error.show (`Encode_rejected e)
  | `Load_failed e -> Caqti_error.show (`Load_failed e)
  | `Load_rejected e -> Caqti_error.show (`Load_rejected e)
  | `Newer_version_than_supported _ -> "Newer version than supported"
  | `Post_connect e -> Caqti_error.show (`Post_connect e)
  | `Request_failed e -> Caqti_error.show (`Request_failed e)
  | `Request_rejected e -> Caqti_error.show (`Request_rejected e)
  | `Response_failed e -> Caqti_error.show (`Response_failed e)
  | `Response_rejected e -> Caqti_error.show (`Response_rejected e)

let decode_1 (v1, ()) = v1
let decode_2 (v1, (v2, ())) = (v1, v2)
let decode_3 (v1, (v2, (v3, ()))) = (v1, v2, v3)
let decode_4 (v1, (v2, (v3, (v4, ())))) = (v1, v2, v3, v4)
