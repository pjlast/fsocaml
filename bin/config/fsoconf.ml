(** This module is used to configure your FSOCaml project. *)
open Base

(** Determines the environment your project is running in. If FSO_ENV is unset,
    a dev environment is assumed. *)
let env =
  match Sys.getenv "FSO_ENV" with
  | Some e -> e
  | None -> "dev"

type db_params = {
  username : string;
  password : string;
  hostname : string;
  database : string;
  pool_size : int;
}

(** Parameters to connect to your development database.

    Production database access is determined via the DATABASE_URL environment
    variable. *)
let db_params =
  {
    username = "postgres";
    password = "postgres";
    hostname = "localhost";
    database = "fsocaml_dev";
    pool_size = 10;
  }

let conn_url params =
  Stdlib.Format.sprintf "postgresql://%s:%s@%s/%s" params.username
    params.password params.hostname params.database

(** If FSO_HOST is set, it is used as the IP address of your application.
    Otherwise defaults to localhost. *)
let host = Sys.getenv "FSO_HOST" |> Option.value ~default:"localhost"

(** If FSO_PORT is set, it is used as the port of your application. Otherwise
    defaults to 8080. *)
let port =
  Sys.getenv "FSO_PORT"
  |> Option.map ~f:Int.of_string
  |> Option.value ~default:8080

(** If [FSO_ENV] is set to anything other than "dev", this will use the
    [DATABASE_URL] environment variable. Otherwise a database connection string
    is built using [db_params]. *)
let sql_url =
  if env |> String.equal "dev" then
    conn_url db_params
  else
    Sys.getenv "DATABASE_URL"
    |> Option.value_exn ~message:"environment variable DATABASE_URL is missing"

let sql_pool_size =
  if env |> String.equal "dev" then
    db_params.pool_size
  else
    Sys.getenv "POOL_SIZE"
    |> Option.map ~f:Int.of_string
    |> Option.value ~default:10

(** A secret key used to sign sessions. In any environment other than ["dev"],
    the [SECRET_KEY] environment variable must be set. *)
let secret_key =
  if env |> String.equal "dev" then
    "3X71hxtzZBO+MNVDiUpVUNevxRru2N8vtI3DHTUW6gPMtcdq+pyGmVeh8DrPvHn3"
  else
    Sys.getenv "SECRET_KEY"
    |> Option.value_exn ~message:"environment variable SECRET_KEY is missing"
