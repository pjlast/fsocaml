let string_of_html html = Format.asprintf "%a" (Tyxml.Html.pp ()) html

let render_page doc = Dream.html @@ string_of_html @@ doc
