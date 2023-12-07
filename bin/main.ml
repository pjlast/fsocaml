open Base

let migrate =
  let open Lwt_result.Syntax in
  let connection = Uri.of_string Fsoconf.sql_url in
  let* connection = Caqti_lwt.connect connection in
  Petrol.StaticSchema.initialise Models.Schema.schema connection

let () =
  let m = migrate in
  let res = Lwt_main.run m in
  let _ =
    match res with
    | Ok _ -> ()
    | Error e -> failwith (Db.error_to_string e)
  in

  Dream.run ~interface:Config.host ~port:Fsoconf.port ~adjust_terminal:false
    ~error_handler:Dream.debug_error_handler
  @@ Dream.set_secret Fsoconf.secret_key
  @@ Dream.logger
  @@ Dream.sql_pool ~size:Fsoconf.sql_pool_size Fsoconf.sql_url
  @@ Dream.sql_sessions
  @@ Dream.router Fsocaml.Router.router
