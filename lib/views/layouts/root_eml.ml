let render req content =
  {%eml|
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="csrf-token" content="<%s Dream.csrf_token req %>" />
    <meta name="description" content="Full-stack OCaml, baby!" />
    <title>
      Full-stack OCaml
    </title>
    <link rel="stylesheet" href="/css/app.css" />
  </head>
  <body class="bg-white antialiased">
    <%s! content %>
  </body>
</html>
|}
