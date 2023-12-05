open Tyxml

let render req content =
  let token = Dream.csrf_token req in
  [%html
    {html|
<!DOCTYPE html>
<html lang="en" class="[scrollbar-gutter:stable]">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="csrf-token" content="|html}
      token
      {html|" />
    <meta name="description" content="Full-stack OCaml, baby!" />
    <title>
      Full-stack OCaml
    </title>
    <link rel="stylesheet" href="/css/app.css" />
  </head>
  <body class="bg-white antialiased">|html}
      content {html|</body>
  </html>
|html}]
