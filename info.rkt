#lang info
(define collection "scribble-enhanced")
(define deps '("base"
               "rackunit-lib"
               "scribble-lib"
               "scheme-lib"
               "compatibility-lib"
               "slideshow-lib"
               "typed-racket-lib"))
(define build-deps '("scribble-lib"
                     "racket-doc"
                     "at-exp-lib"
                     "typed-racket-more"
                     "typed-racket-doc"
                     "reprovide-lang"
                     "mutable-match-lambda"))
(define scribblings
  '(("scribblings/scribble-enhanced.scrbl" ())
    ("scribblings/scribble-enhanced-example.lp2.rkt" () (omit-start))
    ("scribblings/scribble-enhanced-template.lp2.rkt" () (omit-start))))
(define compile-omit-paths '("resources/"))
(define test-omit-paths '("resources/"))
(define pkg-desc "Enhancements for the scribble language")
(define version "0.1")
(define pkg-authors '(|Georges Dupéron|))
