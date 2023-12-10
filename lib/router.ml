open Dream

let router () =
  Dream.router
    [
      scope "/" [ Dream.logger ] [ get "/" @@ Controllers.Home.index ];
      get "/**" @@ static "assets";
    ]
