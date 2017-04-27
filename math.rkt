#lang at-exp racket

(provide setup-math)

(require scribble/html-properties
         scribble/latex-properties
         scribble/base
         scribble/core)

(require scriblib/render-cond)

(require "unicode-chars.sty.rkt")

(define setup-math
  (cond-element
   [(and (or html))
    (elem #:style (style #f (list)) '())]
   [latex
    (elem #:style (style
                   #f (list (tex-addition (string->bytes/utf-8 @string-append{
%\overfullrule=2cm
\usepackage[scaled=0.7]{beramono}
\usepackage{newunicodechar}
%\newunicodechar{ᵢ}{\ensuremath{_1}}

\usepackage{xcolor}
\hypersetup{
 unicode=true,
 colorlinks=true,
 linkcolor={red!50!white!50!black},
 citecolor={blue!50!black},
 urlcolor={blue!80!black},
}

@unicode-chars
}))))
          "")]
   [else (elem)]))
