<div align="center">
  <img alt="fsocaml logo" src="https://github.com/pjlast/fsocaml/blob/main/assets/images/logo.png?raw=true" width="250" />
</div>

# FSOCaml

This is an opinionated template repository to get up and running with a full-stack OCaml web application. It's basically just Dream, but with some pre-configured setup to take some of the thought out of it.

## About

This project is heavily inspired by Elixir Phoenix/Ruby on Rails. It also follows the same Model View Controller (MVC) setup and the "convention over configuration" mindset. The idea is that adding features to your project should be a no-brainer. Database access functions go into `lib/models`, HTML rendering goes into `lib/views`, routing goes into `lib/router.ml`, the handling of routes goes into `lib/controllers`.

Hopefully this eliminates the decision fatigue around the trivial stuff, and lets you focus on simply building what you want to build.

## Getting started

### Dependencies

This project also uses Tailwind, so you'll need to have npm installed, and then install `tailwindcss`:

```bash
npm install -D tailwindcss
```

### Setup

Next, clone this repository and remove the `.git` folder. E.g. if you want to create a project named `myproject`, run the following command:

```bash
git clone --depth=1 --branch=main git@github.com:pjlast/fsocaml.git myproject
rm -rf ./myproject/.git

cd myproject
opam update
opam install . --deps-only
```

After that you'll need to rename all parts of the project to your new project name. Search for all occurances of `fsocaml` and `Fsocaml` and replace it with `myproject` and `Myproject` (or whatever you named your project).

You can do this manually or by running

```bash
dune exec setup
```

which will use the name of the project folder as the project name, or

```bash
dune exec setup myproject
```

which can be used to give at a different name.

## Running the project

Before you can run the project, you'll need to set up your database. FSOCaml assumes there's a Postgres instance running and that there is a `postgres` user with the password `postgres`. You can adjust these settings in `bin/config/fsoconf.ml`. In the `db_params` record, adjust the parameters as desired.

Once you've configured your DB paramaters to your liking, you'll have to create the database and run any existing migrations:

```bash
dune exec migrate create
dune exec migrate up
```

Start the project by running

```bash
dune exec myproject -w
```

This will start the server with live-reloading enabled. Whenever you change a source file, the project will be recompiled and executed, and any open tabs will be reloaded.

## Expanding your project

The project is set up in a way so that most of the work you'll be doing is in the `lib` directory.

You can add new routes in `lib/router.ml`.

Route handlers are added to `lib/controllers`.

Views to render are added to `lib/views` and uses a PPX to render Dream's `.eml`.

Database models are added to `lib/models`. More info on this to come later.

## Database migrations

FSOCaml has a CLI tool to manage database migrations.

To create a new database:

```bash
dune exec migrate create
```

To create a new migration:

```bash
dune exec migrate new 'your migration name'
```

To run all upward migrations:

```bash
dune exec migrate up
```

To run all downward migrations:

```bash
dune exec migrate down
```

## Tutorial - Adding user accounts

Let's extend the base app to allow a user to create an account and sign in.

We'll break this down into several tasks and implement it step by step:

- Add the register and login views
- Create the required database migrations
- Add the models
- Create routes to register, sign in, and sign out
- Add middleware and render conditionally

### Add the register and login views

First let's create some new views, starting with the register page. Create a new file `lib/views/user_registration_eml.ml`. Files ending with `_eml.ml` are scanned by the Tailwind configuration. Next we'll add a `render` function to our `user_registration_eml.ml` file:

```ocaml
let render req =
  {%eml|
    <div class="mx-auto max-w-sm">
        <h1>Register for an account</h1>
          <p class="mt-1">Already registered?
          <a href="/users/login">
            Sign in
          </a>
          to your account now.
        </p>

      <form class="flex flex-col mt-2" method="POST" action="/users/register">
        <%- Dream.csrf_tag req %>

        <label for="email">
        Email
        </label>
        <input id="email" type="email" name="email" required />

        <label for="password">
        Password
        </label>
        <input id="password" type="password" name="password" required />

        <button class="mt-2">Create an account</button>
      </form>
    </div>
    |}
```

`{%eml|...|}` is a preprocessor directive for embedded ML templates provided by the [embedded_ocaml_templates](https://github.com/EmileTrotignon/embedded_ocaml_templates) library. Indentation in these templates are important. The template needs to end on the same indentation level it starts.

We'll create a similar `user_login_eml.ml` file, except we'll change the words and the links a bit:

```ocaml
let render req =
  {%eml|
    <div class="mx-auto max-w-sm">
        <h1>Sign in</h1>
          <p class="mt-1">Don't have an account?
          <a href="/users/register">
            Create an account
          </a>
          now.
        </p>

      <form class="flex flex-col mt-2" method="POST" action="/users/login">
        <%- Dream.csrf_tag req %>

        <label for="email">
        Email
        </label>
        <input id="email" type="email" name="email" required />

        <label for="password">
        Password
        </label>
        <input id="password" type="password" name="password" required />

        <button class="mt-2">Sign in</button>
      </form>
    </div>
    |}
```

Next we need to create controllers that render these views. We'll start with `lib/controllers/user_registration.ml`:

```ocaml
let new_ req =
  Views.User_registration_eml.render req
  |> Layouts.App_eml.render req
  |> Page.render req
```

And similarly for the login page, `lib/controllers/user_login.ml`:

```ocaml
let new_ req =
  Views.User_login_eml.render req
  |> Layouts.App_eml.render req
  |> Page.render req
```

Finally, update `lib/router.ml` so we're able to navigate to these routes:

```ocaml
        (* ... *)
        [
          get "/" @@ Controllers.Home.index;
          scope "/users" []
            [
              get "/register" @@ Controllers.User_registration.new_;
              get "/login" @@ Controllers.User_login.new_;
            ];
        ];
        (* ... *)
```

If we start the app up again with `dune exec myproject -w` and navigate to `/users/register` and `/users/login`, we should see our newly created pages.

### Create the required database migrations

Next, let's create some database migrations to store our user details and user sessions.

```bash
dune exec migrate new 'create_users_table'
```

```bash
dune exec migrate new 'create_users_tokens_table'
```

This will create an `up.sql` and a `down.sql` file under each `migrations/` folder. We'll need to write an up and a down migration for each table:

```sql
-- migrations/xxxxxxx_create_users_table/up.sql
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email TEXT NOT NULL UNIQUE,
    hashed_password TEXT NOT NULL
);
```

We'll have an `id`, `email`, and `hashed_password` columns for the user.

And then to undo this creation:

```sql
-- migrations/xxxxxx_create_users_table/down.sql
DROP TABLE IF EXISTS users;
```

Then, for the `users_tokens` table:

```sql
-- migrations/xxxxxx_create_users_tokens_table/up.sql
CREATE TABLE IF NOT EXISTS users_tokens (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users NOT NULL,
    token TEXT NOT NULL UNIQUE
);
```

And similarly, the down migration:

```sql
-- migrations/xxxxxx_create_users_tokens_table/down.sql
DROP TABLE IF EXISTS users_tokens;
```

Finally, we can create our tables by running `dune exec migrate up`. If we ever need to undo these migrations, we run `dune exec migrate down`.

### Add the models

With our tables created we can create corresponding `lib/models`:

```ocaml
(* lib/models/users.ml *)
let schema = Schema.schema

type t = {
  id : int;
  email : string;
  hashed_password : string;
}
[@@deriving combust ~name:"users"]
```

We use a preprocessor called `combust` initially created by [TJ DeVries](https://github.com/tjdevries) to generate the required boilerplate to interface with [Petrol](https://ocaml.org/p/petrol/latest/doc/index.html), the ORM we'll be using.

In order to create a user and sign in, we'll need to be able to hash their password and verify a password. Let's create some functions for those first:

```ocaml
(* lib/models/users.ml *)
let hash_password password = Bcrypt.string_of_hash @@ Bcrypt.hash password

let validate_password ~hashed_password ~password =
  Bcrypt.verify password (Bcrypt.hash_of_string hashed_password)

let verify_user_password user ~password =
  if validate_password ~hashed_password:user.hashed_password ~password then
    Some user
  else
    None
```

Next, let's add functions to create a user as well as fetch a user by email and password:

```ocaml
(* lib/models/users.ml *)
let create email password db =
  let open Petrol in
  let open Petrol.Postgres in
  let hashed_password = password |> hash_password in

  Query.insert ~into:table
    ~values:Expr.[ f_email := s email; f_hashed_password := s hashed_password ]
    ~returning:fields
  |> Db.find db
  |> Lwt_result.map decode

let get_by_email_and_password email password db =
  let open Petrol in
  let open Petrol.Postgres in
  Query.select fields ~from:table
  |> Query.where Expr.(f_email = s email)
  |> Db.find_opt db
  |> Lwt_result.map (Option.map decode)
  |> Lwt_result.map (fun user ->
         Option.bind user (verify_user_password ~password))
```

As you can see, Petrol basically just reads like normal SQL. All of the `f_` variables, the `fields` and `table` variable, and the `decode` function are generated by `@@deriving combust`.

We'll also need a model for `users_tokens`:

```ocaml
(* lib/models/users_tokens.ml *)
let schema = Schema.schema

open Petrol
open Petrol.Postgres

type t = {
  id : int;
  user_id : int;
  token : string;
}
[@@deriving combust ~name:"users_tokens"]

let _ = Random.self_init ()

let rand_str len =
  String.init len (fun _ -> Char.chr (33 + Random.int 94))

let create user_id db =
  Query.insert ~into:table
    ~values:
      Expr.
        [
          f_user_id := i user_id;
          f_token := s (rand_str 32);
        ]
    ~returning:fields
  |> Db.find db
  |> Lwt_result.map decode
```

With the `users_tokens` model created, we can navigate back to `users.ml` and add a function to fetch a user by their session token:

```ocaml
(* lib/models/users.ml *)
let get_by_session_token ~token db =
  let open Petrol in
  let open Petrol.Postgres in
  Query.select fields ~from:table
  |> Query.join
       (Query.table Users_tokens.table)
       ~on:Expr.(f_id = Users_tokens.f_user_id)
  |> Query.where Expr.(Users_tokens.f_token = s token)
  |> Db.find_opt db
  |> Lwt_result.map (Option.map decode)
```

This should give us everything we need to create users and sign in.

### Create routes to register, sign in, and sign out

First, let's add some additional handlers to our controllers:

```ocaml
(* lib/controllers/user_registration.ml *)
let create req =
  match%lwt Dream.form req with
  | `Ok [ ("email", email); ("password", password) ] -> (
      let%lwt user_res = Models.Users.create email password |> Dream.sql req in
      match user_res with
      | Error (`Request_failed _) ->
          Dream.respond ~status:`Bad_Request "User already exists"
      | Error _ ->
          Dream.respond ~status:`Internal_Server_Error "Something went wrong"
      | Ok _user -> Dream.redirect ~status:`See_Other req "/users/login")
  | _ -> Dream.empty `Bad_Request
```

Pretty straightforward. Read the form contents, try to create a user, respond appropriately.

```ocaml
(* lib/controllers/user_login.ml *)
let sign_in_user req user_id =
  Dream.sql req (fun db ->
      let%lwt token_res = Models.Users_tokens.create user_id db in

      match token_res with
      | Error err ->
          Dream.error (fun log -> log "%s" (Caqti_error.show err));
          Dream.respond ~status:`Internal_Server_Error "Something went wrong"
      | Ok token ->
          let%lwt () = Dream.set_session_field req "token" token.token in
          Dream.redirect ~status:`See_Other req "/")

let create req =
  Dream.sql req (fun db ->
      match%lwt Dream.form req with
      | `Ok [ ("email", email); ("password", password) ] -> (
          let%lwt user_res =
            Models.Users.get_by_email_and_password email password db
          in

          match user_res with
          | Error err ->
              Dream.error (fun log -> log "%s" (Caqti_error.show err));
              Dream.add_flash_message req "Error" "Something went wrong";
              Dream.redirect req ~status:`See_Other "/users/login"
          | Ok user_opt -> (
              match user_opt with
              | Some user -> sign_in_user req user.id
              | None ->
                  Dream.add_flash_message req "Error"
                    "Email or password is incorrect";
                  Dream.redirect req ~status:`See_Other "/users/login"))
      | _ -> Dream.empty `Bad_Request)

let delete req =
  let%lwt () = Dream.set_session_field req "token" "" in
  Dream.redirect req ~status:`See_Other "/users/login"
```

This one's a little more complicated. We have a helper function that creates a token for the provided user's ID and sets it in the current session.

The `create` function reads the form as before, fetches the user with the corresponding email and password, and then signs in that user.

Finally we have a `delete` function that just deletes the session token from the current session, which essentially performs a logout.

Last but not least, let's add these to our `router.ml` file:

```ocaml
(* lib/router.ml *)
          (* ... *)
          scope "/users" []
            [
              get "/register" @@ Controllers.User_registration.new_;
              post "/register" @@ Controllers.User_registration.create;
              get "/login" @@ Controllers.User_login.new_;
              post "/login" @@ Controllers.User_login.create;
              delete "/logout" @@ Controllers.User_login.delete;
            ];
          (* ... *)
```

We should now be able to create a user, sign in as that user, and sign out! However, if we were to try this we'd realise there isn't really anything indicating that anything happened at all. So let's create some middleware that extracts the user from the session, and then we can use the user to conditionally render a component.

### Add middleware and render conditionally

In the top right of the page we have a link to the FSOCaml repository. Let's replace that with a component that either points to the login page, or, if the user is signed in, displays the user's email and a sign out button.

Alright, let's start with the middleware:

```ocaml
(* lib/middleware/middleware.ml *)
let user_field : Models.Users.t Dream_pure.Message.field =
  Dream_pure.Message.new_field ()

let get_user req = Dream_pure.Message.field req user_field

let user_middleware inner_handler req =
  match Dream.session_field req "token" with
  | None -> inner_handler req
  | Some token -> (
      match%lwt Dream.sql req (Models.Users.get_by_session_token ~token) with
      | Ok (Some user) ->
          Dream_pure.Message.set_field req user_field user;
          inner_handler req
      | Ok None -> inner_handler req
      | Error err ->
          Dream.error (fun log -> log "%s" (Caqti_error.show err));
          inner_handler req)
```

We define a `user_field` that's used to store the user in the request, as well as a `get_user` function to extract a user from the request.

Our `user_middleware` reads the session token, fetches the user using that session token, and then adds the user to the request, which we can then fetch when we need it.

Next we just need to add our middleware to our routes, so our final `router.ml` file:

```ocaml
(* lib/router.ml *)
open Dream
open Base

let router () =
  Dream.router
    [
      scope "/"
        [
          Dream.logger;
          Dream.flash;
          Dream.cookie_sessions;
          Middleware.mailer_middleware Mailer.dev_mailer;
          Middleware.user_middleware;
        ]
        [
          get "/" @@ Controllers.Home.index;
          scope "/users" []
            [
              get "/register" @@ Controllers.User_registration.new_;
              post "/register" @@ Controllers.User_registration.create;
              get "/login" @@ Controllers.User_login.new_;
              post "/login" @@ Controllers.User_login.create;
              delete "/logout" @@ Controllers.User_login.delete;
            ];
        ];
      get "/**" @@ static "assets";
    ]
```

All that's left is to conditionally render our component. Let's create our component in our app layout file:

```ocaml
(* lib/views/layouts/app_eml.ml *)
let user_component req =
  let user = Middleware.get_user req in
  match user with
  | None ->
      {%eml|
    <div class="flex items-center gap-4 font-semibold leading-6 text-zinc-900">
      <a href="/users/login" hx-target="body">Sign in</a>
    </div>|}
  | Some user ->
      {%eml|
    <div class="flex items-center gap-4 font-semibold leading-6 text-zinc-900">
      <%- user.email %>
      <a hx-delete="/users/logout" hx-target="body" hx-push-url="true">Sign out</a>
    </div>|}
```

So we use our `get_user` function from our middleware to extract the user from the request, which returns an `Option`. Then, depending if a user was actually returned or not, we can render different things. If we get `None`, we render a link to the login page. If we get `Some user`, we display the user's email, as well as a link to sign out with. We use HTMX to perform a `DELETE` request to the `/users/logout` route, since that's what our router expects, and since our route will cause a redirect, we use `hx-target` to replace the HTML body with the response.

Now we just update our app layout to render this component instead of the link to the GitHub page:

```ocaml
(* lib/views/layouts/app_eml.ml *)
let render req content =
  {%eml|
    <header class="px-4 sm:px-6 lg:px-8">
      <div class="flex items-center justify-between border-b border-zinc-100 py-3 text-sm">
        <div class="flex items-center gap-4">
          <a href="/">
            <img alt="logo" src="/images/logo.png" width="36" />
          </a>
        </div>
        <%- user_component req %>
      </div>
    </header>
    <main class="px-4 py-20 sm:px-6 lg:px-8 bg-cover bg-center h-full" style="background-image: url('/images/background.png')">
      <div class="mx-auto max-w-2xl">
        <%s! content %>
      </div>
    </main>
  |}
```

`<%- user_component req %>` renders our user component. The `-` tells the embedded ML preprocessor to render the string as HTML, instead of escaping it.

And that's it! Now we should have a working web app with user registration and sign-in!
