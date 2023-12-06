open Dream

let loader _root path _request =
    match Tailwindcss.read path with
    | None -> Dream.empty `Not_Found
    | Some asset -> Dream.respond asset

let router = [get "/" @@ Controllers.Home.index; get "/css/**" @@ static ~loader ""; get "/**" @@ static "assets"]
