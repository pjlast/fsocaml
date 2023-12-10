let render ?(layout = Layouts.Root_eml.render) req page =
  page |> layout req |> Dream.html
