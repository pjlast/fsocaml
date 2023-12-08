open Base

let run_tailwind () =
  let cmd =
    "npx tailwindcss -c tailwind.config.js -i assets/tailwind.css -o \
     assets/css/app.css"
  in
  let ic = Unix.open_process_in cmd in
  Unix.close_process_in ic

let () =
  let _ = run_tailwind () in

  Dream.run ~interface:Fsoconf.host ~port:Fsoconf.port ~adjust_terminal:false
    ~error_handler:Dream.debug_error_handler
  @@ Dream.set_secret Fsoconf.secret_key
  @@ Dream.logger
  @@ Dream.sql_pool ~size:Fsoconf.sql_pool_size Fsoconf.sql_url
  @@ Dream.sql_sessions
  @@ Dream_livereload.inject_script ()
  @@ Dream.router Fsocaml.Router.router
