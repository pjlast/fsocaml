open Dream

let router () =
  Dream.router
    [
      scope "/"
        [ Dream.logger; Dream.flash; Dream.cookie_sessions ]
        [ get "/" @@ Controllers.Home.index ];
      get "/**" @@ static "assets";
    ]
