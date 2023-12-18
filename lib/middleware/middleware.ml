open Base

let mailer_field : (module Mailer.Mailer) Dream.field = Dream.new_field ()
let get_mailer req = Option.value_exn (Dream.field req mailer_field)

(** [mail req fn] retrieves the mailer from the request and calls [fn] with the
    mailer. The [mailer_middleware] must be set up, or else an exception will be
    raised. *)
let mail req fn =
  let mailer = get_mailer req in
  fn mailer

(** Makes the provided mailer available in requests. A [Mailer.dev_mailer] is
    available for development that simply logs all emails using Dream.log *)
let mailer_middleware mailer inner_handler req =
  Dream.set_field req mailer_field mailer;
  inner_handler req
