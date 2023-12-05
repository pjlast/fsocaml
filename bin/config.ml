(** This module is used to configure your FSOCaml project. *)
open Base

(** Determines the environment your project is running in. If FSO_ENV is unset, a dev environment is assumed. *)
let env = match Sys.getenv "FSO_ENV" with Some e -> e | None -> "dev"

type db_params =
  { username: string
  ; password: string
  ; hostname: string
  ; database: string
  ; pool_size: int }

(** Parameters to connect to your development database.
    
    Production database access is determined via the DATABASE_URL environment variable. *)
let db_params =
  { username= "postgres"
  ; password= "postgres"
  ; hostname= "localhost"
  ; database= "fsocaml_dev"
  ; pool_size= 10 }

let conn_url params =
  Stdlib.Format.sprintf "postgresql://%s:%s@%s/%s" params.username
    params.password params.hostname params.database

(** If FSO_HOST is set, it is used as the IP address of your application. Otherwise defaults to localhost. *)
let host = Option.value (Sys.getenv "FSO_HOST") ~default:"localhost"

(** If FSO_PORT is set, it is used as the port of your application. Otherwise defaults to 8080. *)
let port =
  Option.value
    (Option.map (Sys.getenv "FSO_PORT") ~f:Int.of_string)
    ~default:8080

(** If [FSO_ENV] is set to anything other than "dev", this will use the [DATABASE_URL] environment variable. Otherwise a database connection string is built using [db_params]. *)
let sql_url =
  if String.equal env "dev" then conn_url db_params
  else
    Option.value_exn ~message:"environment variable DATABASE_URL is missing"
      (Sys.getenv "DATABASE_URL")

let sql_pool_size =
  if String.equal env "dev" then db_params.pool_size
  else
    match Sys.getenv "POOL_SIZE" with Some s -> Int.of_string s | None -> 10

(** A secret key used to sign sessions. In any environment other than ["dev"], the [SECRET_KEY] environment variable must be set. *)
let secret_key =
  if String.equal env "dev" then
    "3X71hxtzZBO+MNVDiUpVUNevxRru2N8vtI3DHTUW6gPMtcdq+pyGmVeh8DrPvHn3"
  else
    Option.value_exn ~message:"environment variable SECRET_KEY is missing"
      (Sys.getenv "SECRET_KEY")
