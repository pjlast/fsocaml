let schema = Schema.schema

open Petrol
open Petrol.Postgres

module Dream_session = struct
  type t = {
    id : string;
    label : string;
    expires_at : float option;
    payload : string;
  }
  [@@deriving combust ~name:"dream_session"]
end

module User = struct
  type t = {
    id : int;
    name : string;
    password : string;
    created_at : Ptime.t option;
  }
  [@@deriving combust ~name:"users"]
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
        select [ User_session.id; User.f_name ] ~from:User_session.t
        |> join (table User.table) ~on:Expr.(User_session.user_id = User.f_id)
      in

      let res =
        qry |> Db.collect_list db |> Lwt_result.map (List.map Db.decode_2)
      in

      res |> Lwt_result.map (List.map (fun (_, name) -> name)))

type user = { id : int; name : string } [@@deriving combust ~name:"user"]

type user_session = { id : int; user_id : int [@references user.id] }
[@@deriving combust ~name:"user_session"]
