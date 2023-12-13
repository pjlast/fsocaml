open Base

let new_migration name =
  let name =
    Int.to_string (Float.to_int (Unix.time ()))
    ^ "_"
    ^ Str.global_replace (Str.regexp_string " ") "_" name
  in
  let folder_path = "migrations/" ^ name in
  let () = Core_unix.mkdir_p folder_path in

  let oc = Stdio.Out_channel.create (folder_path ^ "/up.sql") in
  Stdio.Out_channel.fprintf oc "%s\n" "-- Write your up migration here";
  Stdio.Out_channel.close oc;

  let oc = Stdio.Out_channel.create (folder_path ^ "/down.sql") in
  Stdio.Out_channel.fprintf oc "%s\n" "-- Write your down migration here";
  Stdio.Out_channel.close oc;

  folder_path

let collect_dirs handle =
  let rec aux acc =
    match Core_unix.readdir_opt handle with
    | Some "." -> aux acc
    | Some ".." -> aux acc
    | Some f -> aux (acc @ [ "migrations/" ^ f ])
    | None -> acc
  in
  aux []

let execute_qry sql =
  let open Lwt_result.Syntax in
  let open Caqti_request.Infix in
  let q = (Caqti_type.unit ->. Caqti_type.unit) sql in
  let connection_uri = Fsoconf.sql_url |> Uri.of_string in
  let* (module DB : Caqti_lwt.CONNECTION) = Caqti_lwt.connect connection_uri in
  DB.exec q ()

(* Use the pool to execute queries *)

let migrate_up_all () =
  Core_unix.mkdir_p "migrations" |> ignore;
  let dir = Core_unix.opendir "migrations" in
  let dirs = collect_dirs dir in
  dirs
  |> List.map ~f:(fun dir -> dir ^ "/up.sql")
  |> List.map ~f:(fun file -> (file, Stdio.In_channel.read_all file))
  |> List.iter ~f:(fun (file, qry) ->
         match Lwt_main.run (execute_qry qry) with
         | Ok () -> Stdio.print_endline ("Ran up migration " ^ file)
         | Error err -> Stdio.print_endline (Caqti_error.show err))

let migrate_down_all () =
  let dir = Core_unix.opendir "migrations" in
  let dirs = collect_dirs dir |> List.rev in
  dirs
  |> List.map ~f:(fun dir -> dir ^ "/down.sql")
  |> List.map ~f:(fun file -> (file, Stdio.In_channel.read_all file))
  |> List.iter ~f:(fun (file, qry) ->
         match Lwt_main.run (execute_qry qry) with
         | Ok () -> Stdio.print_endline ("Ran down migration " ^ file)
         | Error err -> Stdio.print_endline (Caqti_error.show err))

let create_db () =
  let fn =
    let sql =
      Stdlib.Format.sprintf {|CREATE DATABASE %s;|} Fsoconf.db_params.database
    in
    let open Lwt_result.Syntax in
    let open Caqti_request.Infix in
    let q = (Caqti_type.unit ->. Caqti_type.unit) sql in
    let connection_uri =
      Fsoconf.conn_url ~with_db:false Fsoconf.db_params |> Uri.of_string
    in
    let* (module DB : Caqti_lwt.CONNECTION) =
      Caqti_lwt.connect connection_uri
    in
    DB.exec q ()
  in
  match Lwt_main.run fn with
  | Ok () -> Stdio.print_endline "Database created"
  | Error err -> Stdio.print_endline (Caqti_error.show err)

let () =
  Clap.description "Manage database migrations";

  let command =
    Clap.subcommand
      [
        ( Clap.case "new" ~description:"Create a new migration" @@ fun () ->
          let migration_name =
            Clap.mandatory_string ~placeholder:"MIGRATION_NAME" ()
          in
          if migration_name |> String.equal "" then
            `error
          else
            `new_migration migration_name );
        (Clap.case "up" ~description:"Run all up migrations" @@ fun () -> `up);
        ( Clap.case "down" ~description:"Run all down migrations" @@ fun () ->
          `down );
        ( Clap.case "create"
            ~description:"Create the database specified in the config"
        @@ fun () -> `create );
      ]
  in
  match command with
  | `new_migration name ->
      Stdio.print_endline ("Migration created at " ^ new_migration name)
  | `up -> migrate_up_all ()
  | `down -> migrate_down_all ()
  | `create -> create_db ()
  | `error -> Clap.help ~out:Stdio.print_string ()
