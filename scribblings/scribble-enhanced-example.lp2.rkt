#lang scribble/lp2
@(require scribble-enhanced/doc)
@doc-lib-setup

@title[#:style manual-doc-style]{Implementation of structures}

@;Racket is distributed with implementations of many SRFIs, most of
@;which can be implemented as libraries. To import the bindings of SRFI
@;@math{n}, use
@;
@;@racketblock[
@;(require @#,elem{@racketidfont{srfi/}@math{n}})
@;]

@section{A section}

In section @secref{doc/example|foo} we present, blah blah.

@subsection[#:tag "doc/example|foo"]{My subsection}

@;Works only with HTML, as \class is not defined. TODO: define it.
@;@$${\frac{\href{//jsmaniac.github.io}{2x}}{\class{some-css-class}{x^2}}}


@(colorize (filled-ellipse 30 15) "blue")
@; Line comment

Blah @math{n}, as described by M@._ Foo@.__
@racketblock[
 (require @#,elem{@racketidfont{srfi/}@math{n}})]

@(define to-insert 42)
@chunk[<scribble-enhanced-example.lp2.rkt-main-chunk>
       ;(displayln #,to-insert) ;; Should work.
       (provide some-ident)
       <some-ident>
       
       (module* test racket
         (require (submod ".."))
         (require rackunit)
         (check-equal? (some-ident) "foo"))]

@CHUNK[<some-ident>
       (define (some-ident)
         (syntax-e #`#,"foo"))]

@itemlist[
 @item{Item 1}
 @item{Item 2}]

It would be nice to be able to alter existing chunks, by inserting stuff later,
for example:

@chunk[<c>
       (define-syntax-rule (double x)
         (+ x x))]

But we would actually want:

@chunk[<redef-c>
       (define-syntax-rule (double x) -- should be greyed out
         (let ((x-cache x))
           (+ x-cache x-cache))) -- everything except the changed bits should
       -- be greyed out]
