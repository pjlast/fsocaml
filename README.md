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

First things first: this project uses a [fork](https://github.com/pjlast/petrol) of a [fork](https://github.com/tjdevries/petrol) of [Petrol](https://github.com/Gopiandcode/petrol). This might get consolidated at some point, but I wanted to iterate fast, so I found it easier to just fork the repo. So you'll first need to pin your petrol version to this repo:

```bash
opam pin petrol 'https://github.com/pjlast/petrol.git#master'
```

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

I'll add a script that automates this eventually.

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
