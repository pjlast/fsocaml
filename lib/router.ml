open Dream

let router = [ get "/" @@ Controllers.Home.index; get "/**" @@ static "assets" ]
