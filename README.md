<div align="center">
  <img alt="fsocaml logo" src="https://github.com/pjlast/fsocaml/blob/main/assets/images/logo.png?raw=true" width="250" />
</div>

# FSOCaml

This is an opinionated template repository to get up and running with a full-stack OCaml web application. It's basically just Dream, but with some pre-configured setup to take some of the thought out of it.

## TODO

- [x] Figure out a pattern for routing
  - Separate file for routing in `lib/router.ml`. Keeps all the application code in `lib/`. Call out to controllers to handle routs. No code in the router itself.
- [x] Figure out a pattern for HTML templating
  - Settled on simply using the Dream .eml templates. Not a big fan of the tooling around it. Currently using .html extension so that the LSP doesn't shout at me.
- [x] Figure out a pattern for database interactions
  - Will probably use Petrol with some adjustments.
- [x] Figure out a pattern for database migrations
  - Went with a custom CLI tool
- [ ] Figure out a testing strategy
- [ ] Automate project naming?

## Getting started

### Dependencies

First things first: this project uses a [fork](https://github.com/pjlast/petrol) of a [fork](https://github.com/tjdevries/petrol) of [Petrol](https://github.com/Gopiandcode/petrol). This might get consolidated at some point, but I wanted to iterate fast, so I found it easier to just fork the repo. So you'll first need to clone and install the fork:

```bash
git clone https://github.com/pjlast/petrol.git
cd petrol
dune build
opam install .
```

### Setup

Next, clone this repository and remove the `.git` folder. E.g. if you want to create a project named `myproject`, run the following command:

```bash
git clone --depth=1 --branch=main git@github.com:pjlast/fsocaml.git myproject
rm -rf ./myproject/.git

cd myproject
opam install . --deps-only
```

After that you'll need to rename all parts of the project to your new project name. Search for all occurances of `fsocaml` and `Fsocaml` and replace it with `myproject` and `Myproject`.

## Running the project

Start the project by running

```bash
dune exec myproject -w
```

This will start the server with reloading enabled. Whenever you change a source file, the project will be recompiled and executed.

## About

This project is heavily inspired by Elixir Phoenix/Ruby on Rails. It also follows the same Model View Controller (MVC) setup and the "convention over configuration" mindset. The idea is that adding features to your project should be a no-brainer. Database access functions go into `lib/models`, HTML rendering goes into `lib/views`, routing goes into `lib/router.ml`, the handling of routes goes into `lib/controllers`.

Hopefully this eliminates the decision fatigue around the trivial stuff, and lets you focus on simply building what you want to build.

## Database migrations

FSOCaml has a CLI tool to manage database migrations.


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
