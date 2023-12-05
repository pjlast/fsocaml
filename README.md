<div align="center">
  <img alt="fsocaml logo" src="https://github.com/pjlast/fsocaml/blob/main/assets/images/logo.png?raw=true" width="250" />
</div>

# FSOCaml

This is an opinionated template repository to get up and running with a full-stack OCaml web application.

## TODO

- [v] Figure out a pattern for routing
- [v] Figure out a pattern for HTML templating
- [ ] Figure out a pattern for database interactions
- [ ] Figure out a pattern for database migrations
- [ ] Figure out a testing strategy
- [ ] Automate project naming?

## Getting started

To get started, simply clone this repository and remove the `.git` folder. E.g. if you want to create a project named `myproject`, run the following command:

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
