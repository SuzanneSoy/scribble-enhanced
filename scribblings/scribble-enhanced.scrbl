#lang scribble/manual
@require[@for-label[scribble-enhanced
                    racket/base]
         scribble-enhanced]

@title{Scribble Enhanced}
@author{Georges Dupéron}

@defmodule[scribble-enhanced]

@section{@racket[defform] enhancements}

@subsection{Easy rendering of quotes and syntax reader abbreviations}

The six common reader abbreviations are rendered as
expected, using a heuristic on source locations (so that 
@tt{#`} renders as @tt{#`} and not @tt{quasisyntax} when the
source location span is exactly two characters, for
example).

@racketblock[
 @defform[#:kind "example"
          (example-1 a
                     #'(b arg …)
                     #`(c arg …)
                     ((unsyntax 'unsyntax) (d arg …))
                     'd
                     `e
                     ,f
                     (@#,RACKET[syntax] (e arg …))
                     (@#,RACKET[quasisyntax] (f arg …))
                     (@#,RACKET[unsyntax] (g arg …))
                     (@#,RACKET[quote] d)
                     (@#,RACKET[quasiquote] e)
                     (@#,RACKET[unquote] f))]]

The above example renders as (with reader abbreviations for
the first six, but not for the last six):

@nested[#:style 'code-inset]{
 @defform[#:kind "example"
          (example-1 a
                     #'(b arg …)
                     #`(c arg …)
                     #,(d arg …)
                     'd
                     `e
                     ,f
                     (syntax (a arg …))
                     (quasisyntax (b arg …))
                     (unsyntax (c arg …))
                     (quote d)
                     (quasiquote e)
                     (unquote f))]
}

@subsubsection{Escaping from @racket[defform]}

Escaping from defform using @racket[UNSYNTAX] is not
implemented yet.

@subsection{@racket[#:result] for @racket[defform]}

@racketblock[
 @defform[#:kind "example"
          (example-2 a #'([b c] ...))
          #:result void?
          #:contracts ([a port?]
                       [b number?]
                       [c string?])]{
  Example description
  }]

The code above renders as follows:

@nested[#:style 'code-inset]{
 @defform[#:kind "example"
          (example-2 a #'([b c] ...))
          #:result void?
          #:contracts ([a port?]
                       [b number?]
                       [c string?])]{
  Example description
 }
}

@subsection{Arbitrary rewriting of code in @racket[racketblock] and similar}

@defthing[#:kind "mutable-match-lambda"
          mutable-match-element-id-transformer]{As an example, it would be
 possible to create a rewrite handler which turns the ⁰¹²³⁴⁵⁶⁷⁸⁹ unicode
 superscripts at the end of identifiers into superscripts alongside the
 base identifier.

 This could be useful to typeset code using the @elem[#:style 'tt "xlist"]
 package, which rewrites identifiers ending with a superscript to mean
 repetition, so that @racket[(define-type three-ints (xList Integer³))] is
 equivalent to @racket[(define-type three-ints (List Integer Integer Integer))].

 @racketblock[
 @(code:comment "Correctly display xyz⃰, xyzⁿ, xyz⁰, xyz¹, … xyz⁹")
 (begin-for-syntax
   (mutable-match-lambda-add-overriding-clause!
    mutable-match-element-id-transformer
    #:match-lambda
    [(? identifier?
        whole-id
        (app (compose symbol->string syntax-e)
             (pregexp #px"^(.*?)(⃰|ⁿ|[⁰¹²³⁴⁵⁶⁷⁸⁹]+)$"
                      (list whole base power))))
     (define/with-syntax base-id (format-id whole-id "~a" base))
     (define/with-syntax power-characters
       (string-join
        (map (match-lambda ["⃰" "*"]
                           ["ⁿ" "n"]
                           ["⁰" "0"] ["¹" "1"] ["²" "2"] ["³" "3"] ["⁴" "4"]
                           ["⁵" "5"] ["⁶" "6"] ["⁷" "7"] ["⁸" "8"] ["⁹" "9"])
             (map string (string->list power)))))
     #'(elem (list (racket base-id)
                   (superscript power-characters)))]))]

 Another use case would be a hack to correctly colour syntax classes from
 syntax-parse, when used as @racket[attr:stxclass]. Here is how it would be
 defined:

 @racketblock[
 (begin-for-syntax
   (mutable-match-lambda-add-overriding-clause!
    mutable-match-element-id-transformer
    #:match-lambda
    [(? identifier?
        whole-id
        (app (compose symbol->string syntax-e)
             (pregexp #px"^([^:]*):([^:]*)$"
                      (list whole attr cls))))
     (define/with-syntax attr-id (format-id whole-id "~a" attr))
     (define/with-syntax cls-id (format-id whole-id "~a" cls))
     #'(elem (list (racket attr-id)
                   (elem #:style 'tt ":")
                   (racket cls-id)))]))]

 The code for these two examles would be inserted directly inside the document,
 before any @racket[racketblock], @racket[chunk] or similar.}

@defthing[#:kind "syntax property"
          scribble-render]{
 The @racket['scribble-render] syntax property can contain a function. It will
 be called with the whole syntax object, and must return the syntax for
 scribble code which will be used in place of that s-expression.

 This feature is experimental, and may be changed in future versions

 @history[#:added "0.2"]}