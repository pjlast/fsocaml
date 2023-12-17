open Dream

let router () =
  Dream.router
    [
      scope "/"
        [
          Dream.logger;
          Dream.flash;
          Dream.cookie_sessions;
          Middleware.mailer_middleware Mailer.dev_mailer;
        ]
        [ get "/" @@ Controllers.Home.index ];
      get "/**" @@ static "assets";
    ]
