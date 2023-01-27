#lang info
(define collection "scribble-enhanced")
(define deps '("base"
               "rackunit-lib"
               "scribble-lib"
               "scheme-lib"
               "compatibility-lib"
               "slideshow-lib"
               "typed-racket-lib"
               "reprovide-lang-lib"
               "mutable-match-lambda"))
(define build-deps '("scribble-lib"
                     "racket-doc"
                     "at-exp-lib"
                     "typed-racket-more"
                     "typed-racket-doc"
                     "scribble-doc"))
(define scribblings
  '(("scribblings/scribble-enhanced.scrbl" () ("Scribble Libraries"))
    ("scribblings/scribble-enhanced-example.lp2.rkt" () (omit-start))
    ("scribblings/scribble-enhanced-template.lp2.rkt" () (omit-start))))
(define compile-omit-paths '("resources/"))
(define test-omit-paths '("resources/"))
(define pkg-desc "Enhancements for the scribble language")
(define version "0.3")
(define license 'LGPL-3.0-or-later)
(define pkg-authors '(|Suzanne Soy|))
