open Base

module type Mailer = sig
  val send :
    from:string ->
    to_:string ->
    subject:string ->
    body:string ->
    (unit, string) Result.t Lwt.t
end

(** [DevMailer] logs the provided email instead of sending it to a provider. It
    is intended for development use. *)
let dev_mailer =
  (module struct
    let send ~from ~to_ ~subject ~body =
      Dream.log {|From: %s
To: %s
Subject: %s
Body: %s|} from to_ subject body;

      Lwt.return_ok ()
  end : Mailer)

(** [make_mandrill_mailer] creates a [Mailer] for the MailChimp/Mandrill
    platform. It requires an [api_key], but the [username] is optional, although
    the Mandrill API docs recommend you use your Mailchimp account's primary
    contact email. *)
let make_mandrill_mailer ?(username = "") api_key =
  let module M = struct
    let config =
      Letters.Config.create ~username ~password:api_key
        ~hostname:"smtp.mandrillapp.com" ~with_starttls:false ()

    let send ~from ~to_ ~subject ~body =
      Lwt.try_bind
        (fun () ->
          let email =
            Letters.create_email ~from ~recipients:[ To to_ ] ~subject
              ~body:(Plain body) ()
            |> Result.ok_or_failwith
          in
          Letters.send ~config ~sender:from ~recipients:[ To to_ ]
            ~message:email)
        (fun () -> Lwt.return_ok ())
        (fun exc -> Lwt.return_error (Exn.to_string exc))
  end in
  (module M : Mailer)
