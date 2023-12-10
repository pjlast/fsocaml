open Base

(** Recompiles the Tailwind CSS file. *)
let run_tailwind () =
  let cmd =
    "npx tailwindcss -c tailwind.config.js -i assets/tailwind.css -o \
     assets/css/app.css"
  in
  let ic = Unix.open_process_in cmd in
  Unix.close_process_in ic

let () =
  let _ = run_tailwind () in

  if Poly.( = ) Fsoconf.env Fsoconf.Dev then
    Dream.initialize_log ~level:`Debug ();

  Dream.run ~interface:Fsoconf.host ~port:Fsoconf.port ~adjust_terminal:false
    ~error_handler:Dream.debug_error_handler
  @@ Dream.set_secret Fsoconf.secret_key
  @@ Dream.sql_pool ~size:Fsoconf.sql_pool_size Fsoconf.sql_url
  @@ Dream.cookie_sessions
  @@ Dream.flash
  @@ Fsocaml.Router.router ()
