Test (preprocess) field on melange.emit stanza

  $ cat > dune-project <<EOF
  > (lang dune 3.7)
  > (using melange 0.1)
  > EOF

  $ cat > dune <<EOF
  > (melange.emit
  >  (target output)
  >  (alias app))
  > EOF

  $ cat > main.ml <<EOF
  > let () =
  >   print_endline "hello"
  > EOF

  $ dune build @app
  $ node _build/default/output/main.js
  hello
