open Tyxml

let render content =
  [%html
    {|
<header class="px-4 sm:px-6 lg:px-8">
  <div class="flex items-center justify-between border-b border-zinc-100 py-3 text-sm">
    <div class="flex items-center gap-4">
      <a href="/">
        <img alt="logo" src="/images/logo.png" width="36" />
      </a>
      <p class="bg-brand/5 text-brand rounded-full px-2 font-medium leading-6">
        v1
      </p>
    </div>
    <div class="flex items-center gap-4 font-semibold leading-6 text-zinc-900">
      <a href="https://twitter.com/elixirphoenix" class="hover:text-zinc-700">
        @elixirphoenix
      </a>
      <a href="https://github.com/phoenixframework/phoenix" class="hover:text-zinc-700">
        GitHub
      </a>
      <a
        href="https://hexdocs.pm/phoenix/overview.html"
        class="rounded-lg bg-zinc-100 px-2 py-1 hover:bg-zinc-200/80"
      >
        Get Started <span aria-hidden="true">&rarr;</span>
      </a>
    </div>
  </div>
</header>
<main class="px-4 py-20 sm:px-6 lg:px-8">
  <div class="mx-auto max-w-2xl">
    |}
      content {|
  </div>
</main>
|}]
