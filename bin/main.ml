open Base

let () =
  Dream.run ~interface:Config.host ~port:Fsoconf.port ~adjust_terminal:false
    ~error_handler:Dream.debug_error_handler
  @@ Dream.set_secret Fsoconf.secret_key
  @@ Dream.logger
  @@ Dream.sql_pool ~size:Fsoconf.sql_pool_size Fsoconf.sql_url
  @@ Dream.sql_sessions
  @@ Dream.router Fsocaml.Router.router
