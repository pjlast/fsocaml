let schema = Schema.schema

open Petrol
open Petrol.Postgres

module Dream_session = struct
  let t, Expr.[ id; label; expires_at; payload ] =
    StaticSchema.declare_table schema ~name:"dream_session"
      Schema.
        [
          field "id" ~ty:(Type.null_ty Type.text);
          field "label" ~ty:Type.text;
          field "expires_at" ~ty:Type.real;
          field "payload" ~ty:Type.text;
        ]

  let create db =
    Db.transact db (fun () ->
        Query.insert ~table:t ~values:Expr.[ id := s_opt None ]
        |> Request.make_zero
        |> Petrol.exec db)
end

module User = struct
  let t, Expr.[ id; name; password ] =
    StaticSchema.declare_table schema ~name:"users"
      Schema.
        [
          field "id" ~ty:Type.int;
          field "name" ~ty:Type.text;
          field "password" ~ty:Type.text;
        ]
end

module User_session = struct
  let t, Expr.[ id; user_id ] =
    StaticSchema.declare_table schema ~name:"user_sessions"
      Schema.[ field "id" ~ty:Type.int; field "user_id" ~ty:Type.int ]
end

let x db =
  Db.transact db (fun () ->
      let open Query in
      let qry =
        select [ User_session.id; User.name ] ~from:User_session.t
        |> join (table User.t) ~on:Expr.(User_session.user_id = User.id)
      in

      let res =
        qry
        |> Db.collect_list db
        |> Lwt_result.map (List.map (fun (id, (name, ())) -> (id, name)))
      in

      res |> Lwt_result.map (List.map (fun (_, name) -> name)))

type user = { id : int; name : string } [@@deriving combust ~name:"user"]

type user_session = { id : int; user_id : int [@references user.id] }
[@@deriving combust ~name:"user_session"]

type dream_session = {
  id : int;
  label : string;
  expires_at : float;
  payload : string;
}
[@@deriving combust ~name:"dream_session"]
