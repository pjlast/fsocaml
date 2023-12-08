open Petrol

(** [collect_list db qry] executes the provided [qry] using the [db] connection
    and returns the result in a list. *)
let collect_list db qry =
  Dream.debug (fun log -> log "%s" (Format.asprintf "%a" Query.pp qry));
  qry |> Request.make_many |> Petrol.collect_list db

(** [find db qry] executes the provided [qry] using the [db] connection and
    returns a single result. If no results are found, an error is returned. *)
let find db qry =
  Dream.debug (fun log -> log "%s" (Format.asprintf "%a" Query.pp qry));
  qry |> Request.make_one |> Petrol.find db

(** [find_opt db qry] executes the provided [qry] using the [db] connection and
    returns a result as an [option]. *)
let find_opt db qry =
  Dream.debug (fun log -> log "%s" (Format.asprintf "%a" Query.pp qry));
  qry |> Request.make_zero_or_one |> Petrol.find_opt db

(** [transact db fn] executes [fn] inside a database transaction. *)
let transact (module DB : Caqti_lwt.CONNECTION) fn = DB.with_transaction fn

let decode_1 (v1, ()) = v1
let decode_2 (v1, (v2, ())) = (v1, v2)
let decode_3 (v1, (v2, (v3, ()))) = (v1, v2, v3)
let decode_4 (v1, (v2, (v3, (v4, ())))) = (v1, v2, v3, v4)
