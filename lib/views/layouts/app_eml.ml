let render _req content =
  {%eml|
    <header class="px-4 sm:px-6 lg:px-8">
      <div class="flex items-center justify-between border-b border-zinc-100 py-3 text-sm">
        <div class="flex items-center gap-4">
          <a href="/">
            <img alt="logo" src="/images/logo.png" width="36" />
          </a>
        </div>
        <div class="flex items-center gap-4 font-semibold leading-6 text-zinc-900">
          <a href="https://github.com/pjlast/fsocaml" class="hover:text-zinc-700">
            GitHub
          </a>
        </div>
      </div>
    </header>
    <main class="px-4 py-20 sm:px-6 lg:px-8 bg-cover bg-center" style="background-image: url('/images/background.png')">
      <div class="mx-auto max-w-2xl">
        <%s! content %>
      </div>
    </main>
  |}
