open Base

let env = match Sys.getenv "FSO_ENV" with Some e -> e | None -> "dev"

type db_params =
  { username: string
  ; password: string
  ; hostname: string
  ; database: string
  ; pool_size: int }

let db_params =
  { username= "postgres"
  ; password= "postgres"
  ; hostname= "localhost"
  ; database= "eldlixir_dev"
  ; pool_size= 10 }

let conn_url params =
  Stdlib.Format.sprintf "postgresql://%s:%s@%s/%s" params.username
    params.password params.hostname params.database

let host = Option.value (Sys.getenv "FSO_HOST") ~default:"localhost"

let port =
  Option.value
    (Option.map (Sys.getenv "FSO_PORT") ~f:Int.of_string)
    ~default:8080

let sql_url =
  if String.equal env "dev" then conn_url db_params
  else Sys.getenv_exn "DATABASE_URL"

let sql_pool_size =
  if String.equal env "dev" then db_params.pool_size
  else
    match Sys.getenv "POOL_SIZE" with Some s -> Int.of_string s | None -> 10
