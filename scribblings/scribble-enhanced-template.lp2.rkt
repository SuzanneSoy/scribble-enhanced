#lang scribble/lp2
@; TODO: use hyper-literate language instead.
@(require scribble-enhanced/doc)
@doc-lib-setup

@title[#:style manual-doc-style]{Life, the Universe and Everything.}

@(table-of-contents)

@section{Introduction}

@chunk[<lue>
       (define lue 42)]

Here is a macro:

@CHUNK[<scribble-macro-expansion>
       (define-for-syntax mymacro-tmp
         (syntax-rules () [(_ a b) (let ((b 1)) a)]))
       (define-syntax (mymacro-stx stx) #`'#,(mymacro-tmp stx))
       (define-syntax mymacro mymacro-tmp)]

We can use it like this:

@chunk[<scribble-macro-expansion-example>
       (mymacro (+ x 3) x)]

@(begin
   (require (for-syntax racket/base))
   (define-syntax (if<6.4 stx)
     (syntax-case stx ()
       [(_ lt ge)
        (if (or (regexp-match #px"^6(\\.[0123](\\..*|)|)$" (version))
                (regexp-match #px"^[123245]\\..*$" (version)))
            #'lt
            #'ge)]))
   (define-syntax-rule (skip<6.4 . rest) (if<6.4 (begin) (begin . rest))))

@skip<6.4{
 Which expands to (requires Racket ≥ 6.4 and a bit of set-up boilerplate to have
 the output in scribble, see
 @url{http://lists.racket-lang.org/users/archive/2014-December/065175.html}):
 @(begin
    (require syntax/location scribble/example)
    (define res-mod-name
      (resolved-module-path-name
       (module-path-index-resolve
        (module-path-index-join '(submod ".." main)
                                (variable-reference->module-path-index
                                 (#%variable-reference))))))
    (define evaluator (make-base-eval #:lang 'typed/racket))
    (evaluator
     #`(begin
         (require/typed racket/enter
                        [dynamic-enter! (->* (Module-Path)
                                             (#:re-require-enter? Any)
                                             Void)])
         (dynamic-require (cast '#,(cons 'submod res-mod-name) Module-Path) #f)
         (dynamic-enter! (cast '#,(cons 'submod res-mod-name) Module-Path)
                         #:re-require-enter? #f))))

 @examples[#:eval evaluator #:result-only
           (mymacro-stx (+ x 3) x)
           #;(begin
               (require (for-syntax racket/pretty))
               (begin-for-syntax
                 (pretty-write
                  (syntax->datum
                   #'(mymacro-tmp (+ x 3) x)))))]

 The code above should show the expanded code, i.e:}

@if<6.4[
 @list{With Racket ≥ 6.4, it is possible to automatically compute the expanded
  code, and show it. The result would be:}
 @list{}]

@chunk[<expanded-code>
       (let ((x 1)) (+ x 3))]

@chunk[<test-foo>
       (check-equal? lue 42)]

@section{Conclusion}

@chunk[<main-module>
       (module main typed/racket
         (require (for-syntax syntax/parse
                              racket/syntax
                              #;phc-toolkit/untyped)
                  #;phc-toolkit/untyped)
         (provide lue)
         
         <lue>
         <scribble-macro-expansion>)]

@chunk[<module-test>
       (module* test typed/racket
         (require (submod "..")
                  typed/rackunit)
         
         <test-foo>)]

@chunk[<*>
       (begin
         <main-module>
         
         (require 'main)
         (provide (all-from-out 'main))
         
         <module-test>)]