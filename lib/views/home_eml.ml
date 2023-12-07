let render =
    {%eml|
<div class="left-[40rem] fixed inset-y-0 right-0 z-0 hidden lg:block xl:left-[50rem]">
  <svg
    viewBox="0 0 1480 957"
    fill="none"
    aria-hidden="true"
    class="absolute inset-0 h-full w-full"
    preserveAspectRatio="xMinYMid slice"
  >
    <path fill="#EE7868" d="M0 0h1480v957H0z" />
    <path
      d="M137.542 466.27c-582.851-48.41-988.806-82.127-1608.412 658.2l67.39 810 3083.15-256.51L1535.94-49.622l-98.36 8.183C1269.29 281.468 734.115 515.799 146.47 467.012l-8.928-.742Z"
      fill="#FF9F92"
    />
    <path
      d="M371.028 528.664C-169.369 304.988-545.754 149.198-1361.45 665.565l-182.58 792.025 3014.73 694.98 389.42-1689.25-96.18-22.171C1505.28 697.438 924.153 757.586 379.305 532.09l-8.277-3.426Z"
      fill="#FA8372"
    />
    <path
      d="M359.326 571.714C-104.765 215.795-428.003-32.102-1349.55 255.554l-282.3 1224.596 3047.04 722.01 312.24-1354.467C1411.25 1028.3 834.355 935.995 366.435 577.166l-7.109-5.452Z"
      fill="#E96856"
      fill-opacity=".6"
    />
    <path
      d="M1593.87 1236.88c-352.15 92.63-885.498-145.85-1244.602-613.557l-5.455-7.105C-12.347 152.31-260.41-170.8-1225-131.458l-368.63 1599.048 3057.19 704.76 130.31-935.47Z"
      fill="#C42652"
      fill-opacity=".2"
    />
    <path
      d="M1411.91 1526.93c-363.79 15.71-834.312-330.6-1085.883-863.909l-3.822-8.102C72.704 125.95-101.074-242.476-1052.01-408.907l-699.85 1484.267 2837.75 1338.01 326.02-886.44Z"
      fill="#A41C42"
      fill-opacity=".2"
    />
    <path
      d="M1116.26 1863.69c-355.457-78.98-720.318-535.27-825.287-1115.521l-1.594-8.816C185.286 163.833 112.786-237.016-762.678-643.898L-1822.83 608.665 571.922 2635.55l544.338-771.86Z"
      fill="#A41C42"
      fill-opacity=".2"
    />
  </svg>
</div>
<div class="px-4 py-10 sm:px-6 sm:py-28 lg:px-8 xl:px-28 xl:py-32">
  <div class="mx-auto max-w-xl lg:mx-0">
  <img class="h-24" alt="camel logo" src="/images/logo.png" />
    <h1 class="mt-10 flex items-center text-sm font-semibold leading-6">
      Full-stack OCaml
    </h1>
    <p class="text-[2rem] mt-4 font-semibold leading-10 tracking-tighter text-zinc-900">
      We do what we must because we can.
    </p>
    <p class="mt-4 text-base leading-7 text-zinc-600">
      Build rich, interactive web applications quickly, with less code and fewer moving parts. Join our growing community of developers using Phoenix to craft APIs, HTML5 apps and more, for fun or at scale.
    </p>
    <div class="flex">
      <div class="w-full sm:w-auto">
        <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-3">
          <a
            href="https://hexdocs.pm/phoenix/overview.html"
            class="group relative rounded-2xl px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6"
          >
            <span class="absolute inset-0 rounded-2xl bg-zinc-50 transition group-hover:bg-zinc-100 sm:group-hover:scale-105">
            </span>
            <span class="relative flex items-center gap-4 sm:flex-col">
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true" class="h-6 w-6">
                <path d="m12 4 10-2v18l-10 2V4Z" fill="#18181B" fill-opacity=".15" />
                <path
                  d="M12 4 2 2v18l10 2m0-18v18m0-18 10-2v18l-10 2"
                  stroke="#18181B"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>
              Guides &amp; Docs
            </span>
          </a>
          <a
            href="https://github.com/phoenixframework/phoenix"
            class="group relative rounded-2xl px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6"
          >
            <span class="absolute inset-0 rounded-2xl bg-zinc-50 transition group-hover:bg-zinc-100 sm:group-hover:scale-105">
            </span>
            <span class="relative flex items-center gap-4 sm:flex-col">
              <svg viewBox="0 0 24 24" aria-hidden="true" class="h-6 w-6">
                <path
                  fill-rule="evenodd"
                  clip-rule="evenodd"
                  d="M12 0C5.37 0 0 5.506 0 12.303c0 5.445 3.435 10.043 8.205 11.674.6.107.825-.262.825-.585 0-.292-.015-1.261-.015-2.291C6 21.67 5.22 20.346 4.98 19.654c-.135-.354-.72-1.446-1.23-1.738-.42-.23-1.02-.8-.015-.815.945-.015 1.62.892 1.845 1.261 1.08 1.86 2.805 1.338 3.495 1.015.105-.8.42-1.338.765-1.645-2.67-.308-5.46-1.37-5.46-6.075 0-1.338.465-2.446 1.23-3.307-.12-.308-.54-1.569.12-3.26 0 0 1.005-.323 3.3 1.26.96-.276 1.98-.415 3-.415s2.04.139 3 .416c2.295-1.6 3.3-1.261 3.3-1.261.66 1.691.24 2.952.12 3.26.765.861 1.23 1.953 1.23 3.307 0 4.721-2.805 5.767-5.475 6.075.435.384.81 1.122.81 2.276 0 1.645-.015 2.968-.015 3.383 0 .323.225.707.825.585a12.047 12.047 0 0 0 5.919-4.489A12.536 12.536 0 0 0 24 12.304C24 5.505 18.63 0 12 0Z"
                  fill="#18181B"
                />
              </svg>
              Source Code
            </span>
          </a>
          <a
            href="https://github.com/phoenixframework/phoenix/blob/v1/CHANGELOG.md"
            class="group relative rounded-2xl px-6 py-4 text-sm font-semibold leading-6 text-zinc-900 sm:py-6"
          >
            <span class="absolute inset-0 rounded-2xl bg-zinc-50 transition group-hover:bg-zinc-100 sm:group-hover:scale-105">
            </span>
            <span class="relative flex items-center gap-4 sm:flex-col">
              <svg viewBox="0 0 24 24" fill="none" aria-hidden="true" class="h-6 w-6">
                <path
                  d="M12 1v6M12 17v6"
                  stroke="#18181B"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
                <circle
                  cx="12"
                  cy="12"
                  r="4"
                  fill="#18181B"
                  fill-opacity=".15"
                  stroke="#18181B"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>
              Changelog
            </span>
          </a>
        </div>
        <div class="mt-10 grid grid-cols-1 gap-y-4 text-sm leading-6 text-zinc-700 sm:grid-cols-2">
          <div>
            <a
              href="https://twitter.com/elixirphoenix"
              class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900"
            >
          <svg
                viewBox="0 0 16 16"
                aria-hidden="true"
                class="h-4 w-4 fill-zinc-400 group-hover:fill-zinc-600"
              >
                <path d="M5.403 14c5.283 0 8.172-4.617 8.172-8.62 0-.131 0-.262-.008-.391A6.033 6.033 0 0 0 15 3.419a5.503 5.503 0 0 1-1.65.477 3.018 3.018 0 0 0 1.263-1.676 5.579 5.579 0 0 1-1.824.736 2.832 2.832 0 0 0-1.63-.916 2.746 2.746 0 0 0-1.821.319A2.973 2.973 0 0 0 8.076 3.78a3.185 3.185 0 0 0-.182 1.938 7.826 7.826 0 0 1-3.279-.918 8.253 8.253 0 0 1-2.64-2.247 3.176 3.176 0 0 0-.315 2.208 3.037 3.037 0 0 0 1.203 1.836A2.739 2.739 0 0 1 1.56 6.22v.038c0 .7.23 1.377.65 1.919.42.54 1.004.912 1.654 1.05-.423.122-.866.14-1.297.052.184.602.541 1.129 1.022 1.506a2.78 2.78 0 0 0 1.662.598 5.656 5.656 0 0 1-2.007 1.074A5.475 5.475 0 0 1 1 12.64a7.827 7.827 0 0 0 4.403 1.358" />
              </svg>
              Follow on Twitter
            </a>
          </div>
          <div>
            <a
              href="https://elixirforum.com"
              class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900"
            >
              <svg
                viewBox="0 0 16 16"
                aria-hidden="true"
                class="h-4 w-4 fill-zinc-400 group-hover:fill-zinc-600"
              >
                <path d="M8 13.833c3.866 0 7-2.873 7-6.416C15 3.873 11.866 1 8 1S1 3.873 1 7.417c0 1.081.292 2.1.808 2.995.606 1.05.806 2.399.086 3.375l-.208.283c-.285.386-.01.905.465.85.852-.098 2.048-.318 3.137-.81a3.717 3.717 0 0 1 1.91-.318c.263.027.53.041.802.041Z" />
              </svg>
              Discuss on the Elixir Forum
            </a>
          </div>
          <div>
            <a
              href="https://web.libera.chat/#elixir"
              class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900"
            >
              <svg
                viewBox="0 0 16 16"
                aria-hidden="true"
                class="h-4 w-4 fill-zinc-400 group-hover:fill-zinc-600"
              >
                <path
                  fill-rule="evenodd"
                  clip-rule="evenodd"
                  d="M6.356 2.007a.75.75 0 0 1 .637.849l-1.5 10.5a.75.75 0 1 1-1.485-.212l1.5-10.5a.75.75 0 0 1 .848-.637ZM11.356 2.008a.75.75 0 0 1 .637.848l-1.5 10.5a.75.75 0 0 1-1.485-.212l1.5-10.5a.75.75 0 0 1 .848-.636Z"
                />
                <path
                  fill-rule="evenodd"
                  clip-rule="evenodd"
                  d="M14 5.25a.75.75 0 0 1-.75.75h-9.5a.75.75 0 0 1 0-1.5h9.5a.75.75 0 0 1 .75.75ZM13 10.75a.75.75 0 0 1-.75.75h-9.5a.75.75 0 0 1 0-1.5h9.5a.75.75 0 0 1 .75.75Z"
                />
              </svg>
              Chat on Libera IRC
            </a>
          </div>
          <div>
            <a
              href="https://discord.gg/elixir"
              class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900"
            >
              <svg
                viewBox="0 0 16 16"
                aria-hidden="true"
                class="h-4 w-4 fill-zinc-400 group-hover:fill-zinc-600"
              >
                <path d="M13.545 2.995c-1.02-.46-2.114-.8-3.257-.994a.05.05 0 0 0-.052.024c-.141.246-.297.567-.406.82a12.377 12.377 0 0 0-3.658 0 8.238 8.238 0 0 0-.412-.82.052.052 0 0 0-.052-.024 13.315 13.315 0 0 0-3.257.994.046.046 0 0 0-.021.018C.356 6.063-.213 9.036.066 11.973c.001.015.01.029.02.038a13.353 13.353 0 0 0 3.996 1.987.052.052 0 0 0 .056-.018c.308-.414.582-.85.818-1.309a.05.05 0 0 0-.028-.069 8.808 8.808 0 0 1-1.248-.585.05.05 0 0 1-.005-.084c.084-.062.168-.126.248-.191a.05.05 0 0 1 .051-.007c2.619 1.176 5.454 1.176 8.041 0a.05.05 0 0 1 .053.006c.08.065.164.13.248.192a.05.05 0 0 1-.004.084c-.399.23-.813.423-1.249.585a.05.05 0 0 0-.027.07c.24.457.514.893.817 1.307a.051.051 0 0 0 .056.019 13.31 13.31 0 0 0 4.001-1.987.05.05 0 0 0 .021-.037c.334-3.396-.559-6.345-2.365-8.96a.04.04 0 0 0-.021-.02Zm-8.198 7.19c-.789 0-1.438-.712-1.438-1.587 0-.874.637-1.586 1.438-1.586.807 0 1.45.718 1.438 1.586 0 .875-.637 1.587-1.438 1.587Zm5.316 0c-.788 0-1.438-.712-1.438-1.587 0-.874.637-1.586 1.438-1.586.807 0 1.45.718 1.438 1.586 0 .875-.63 1.587-1.438 1.587Z" />
              </svg>
              Join our Discord server
            </a>
          </div>
          <div>
            <a
              href="https://fly.io/docs/elixir/getting-started/"
              class="group -mx-2 -my-0.5 inline-flex items-center gap-3 rounded-lg px-2 py-0.5 hover:bg-zinc-50 hover:text-zinc-900"
            >
              <svg
                viewBox="0 0 20 20"
                aria-hidden="true"
                class="h-4 w-4 fill-zinc-400 group-hover:fill-zinc-600"
              >
                <path d="M1 12.5A4.5 4.5 0 005.5 17H15a4 4 0 001.866-7.539 3.504 3.504 0 00-4.504-4.272A4.5 4.5 0 004.06 8.235 4.502 4.502 0 001 12.5z" />
              </svg>
              Deploy your application
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
|}
