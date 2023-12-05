open Base

let () =
  Dream.run ~interface:Config.host ~port:Config.port ~adjust_terminal:false
    ~error_handler:Dream.debug_error_handler
  @@ Dream.logger
  @@ Dream.sql_pool ~size:Config.sql_pool_size Config.sql_url
  @@ Dream.memory_sessions
  @@ Dream.router Fsocaml.Router.router
