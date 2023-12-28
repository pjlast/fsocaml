(lang dune 3.11)

(name fsocaml)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name")

(maintainers "Maintainer Name")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name fsocaml)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dune dream dream-livereload (petrol (= 1.2.4)) core_unix clap caqti-driver-postgresql safepass ppx_deriving letters embedded_ocaml_templates)
 (tags
  (topics "to describe" your project)))

(package
 (name ppx_combust)
 (authors "TJ DeVries" "Petri-Johan Last")
 (maintainers "TJ DeVries" "Petri-Johan Last")
 (synopsis "Generate boilerplate stuff for petrol to go zoom zoom")
 (depends ocaml ppxlib ppx_deriving))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
