#!/bin/bash

case "$1" in
build)
  for i in $(cd presentations; ls); do
    slidev build ./presentations/$i/slides.md -d --base /talks/$i/ --out ../../dist/$i/
  done
;;
export)
  mkdir -p pdf
  for i in $(cd presentations; ls); do
    slidev export ./presentations/$i/slides.md --output ./pdf/$i.pdf --timeout 3600
  done
;;
*)
;;
esac
