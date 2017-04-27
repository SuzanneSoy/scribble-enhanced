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