open Dream

let router = [ get "/" @@ Controllers.Home.index; Dream_livereload.route (); get "/**" @@ static "assets"]
