#lang scheme/base
;; Added #:result option to defform.
;; This file is mostly based on scribble-lib/scribble/private/manual-form.rkt
;; With pieces from scribble-lib/scribble/private/manual-proc.rkt
;; And pieces from scribble-lib/scribble/private/manual-scheme.rkt

(require scribble/decode
         scribble/struct
         scribble/scheme
         scribble/basic
         scribble/manual-struct
         scribble/private/qsloc
         scribble/private/manual-utils
         scribble/private/manual-vars
         "manual-scheme.rkt"
         scribble/private/manual-bind
         scheme/list
         syntax/parse/define
         (only-in scribble/core
                  make-style
                  make-table-columns
                  make-nested-flow
                  [make-paragraph make-paragraph2]
                  nested-flow)
         (for-syntax scheme/base
                     syntax/parse
                     syntax/srcloc
                     racket/syntax)
         (for-label scheme/base))

(provide defform defform* defform/subs defform*/subs defform/none
         defidform defidform/inline
         specform specform/subs
         specsubform specsubform/subs specspecsubform specspecsubform/subs
         specsubform/inline
         defsubform defsubform*
         racketgrammar racketgrammar*
         (rename-out [racketgrammar schemegrammar]
                     [racketgrammar* schemegrammar*])
         var svar
         (for-syntax kind-kw id-kw link-target?-kw
                     literals-kw subs-kw contracts-kw))

(begin-for-syntax
  (define-splicing-syntax-class kind-kw
    #:description "#:kind keyword"
    (pattern (~seq #:kind kind))
    (pattern (~seq)
             #:with kind #'#f))
  
  (define-splicing-syntax-class id-kw
    #:description "#:id keyword"
    (pattern (~seq #:id [defined-id:id defined-id-expr]))
    (pattern (~seq #:id defined-id:id)
             #:with defined-id-expr #'(quote-syntax defined-id))
    (pattern (~seq #:id [#f #f])
             #:with defined-id #'#f
             #:with defined-id-expr #'#f)
    (pattern (~seq)
             #:with defined-id #'#f
             #:with defined-id-expr #'#f))
  
  (define-splicing-syntax-class link-target?-kw
    #:description "#:link-target? keyword"
    (pattern (~seq #:link-target? expr))
    (pattern (~seq)
             #:with expr #'#t))
  
  (define-splicing-syntax-class literals-kw
    #:description "#:literals keyword"
    (pattern (~seq #:literals (lit:id ...)))
    (pattern (~seq)
             #:with (lit ...) #'()))
  
  (define-splicing-syntax-class result-kw
    #:description "#:literals keyword"
    (pattern (~seq #:result r)
             #:with maybe-result #'(r))
    (pattern (~seq)
             #:with maybe-result #'()))
  (define-splicing-syntax-class results-kw
    #:description "#:literals keyword"
    (pattern (~seq #:results (result ...))))
  
  (define-splicing-syntax-class contracts-kw
    #:description "#:contracts keyword"
    (pattern (~seq #:contracts (~and cs ([contract-nonterm:id contract-expr] ...))))
    (pattern (~seq)
             #:with (~and cs ((contract-nonterm contract-expr) ...)) #'()))
  
  (define-syntax-class grammar
    #:description "grammar"
    (pattern ([non-term-id:id non-term-form ...+] ...)))
  
  (define-splicing-syntax-class subs-kw
    #:description "#:grammar keyword"
    #:attributes (g (g.non-term-id 1) (g.non-term-form 2))
    (pattern (~seq #:grammar g:grammar))
    (pattern (~seq) #:with g:grammar #'()))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Adjusted from manual-scheme.rkt
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-syntax-rule (define-/form* id base)
  (define-syntax (id stx)
    (syntax-case stx ()
      [(_ . a)
       ;; Remove the context from any ellipsis in `a`:
       (with-syntax ([a (strip-ellipsis-context #'a)])
         #'(base . a))])))

(define-for-syntax (strip-ellipsis-context a)
  (define a-ellipsis (datum->syntax a '...))
  (let loop ([a a])
    (cond
      [(identifier? a)
       (if (free-identifier=? a a-ellipsis #f)
           (datum->syntax #f '... a a)
           a)]
      [(syntax? a)
       (datum->syntax a (loop (syntax-e a)) a a)]
      [(pair? a)
       (cons (loop (car a))
             (loop (cdr a)))]
      [(vector? a)
       (list->vector
        (map loop (vector->list a)))]
      [(box? a)
       (box (loop (unbox a)))]
      [(prefab-struct-key a)
       => (lambda (k)
            (apply make-prefab-struct
                   k
                   (loop (cdr (vector->list (struct->vector a))))))]
      [else a])))

(define-/form* racketblock0/form* racketblock0)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; From manual-proc.rkt
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-syntax (result-contract stx)
  (syntax-case stx (values)
    [(_ (values c ...))
     #'(list (racketblock0 c) ...)]
    [(_ c)
     (if (string? (syntax-e #'c))
         (raise-syntax-error 'defproc
                             "expected a result contract, found a string" #'c)
         #'(racketblock0 c))]
    [(_)
     #'#f]))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Adjusted from manual-proc.rkt
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (end result-contract)
  (define res
    (let ([res (result-contract)])
      (and res
           (if (list? res)
               ;; multiple results
               (if (null? res)
                   'nbsp
                   (let ([w (apply + (map block-width res))])
                     (if (or (ormap table? res) (w . > . 40))
                         (make-table
                          #f (map (lambda (fe) (list (make-flow (list fe)))) res))
                         (make-table
                          #f
                          (list (let loop ([res res])
                                  (if (null? (cdr res))
                                      (list (make-flow (list (car res))))
                                      (list* (make-flow (list (car res)))
                                             flow-spacer
                                             (loop (cdr res))))))))))
               res))))
  (if res
      (list flow-spacer (to-flow 'rarr)
            flow-spacer (make-flow (list res)))
      (list)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-syntax (defform*/subs stx)
  (syntax-parse stx
    [(_ k:kind-kw lt:link-target?-kw d:id-kw l:literals-kw [spec spec1 ...]
        (~optional results:results-kw)
        g:grammar
        c:contracts-kw
        desc ...)
     (with-syntax* ([defined-id (if (syntax-e #'d.defined-id)
                                    #'d.defined-id
                                    (syntax-case #'spec ()
                                      [(spec-id . _) #'spec-id]))]
                    [defined-id-expr (if (syntax-e #'d.defined-id-expr)
                                         #'d.defined-id-expr
                                         #'(quote-syntax defined-id))]
                    [(new-spec ...)
                     (for/list ([spec (in-list (syntax->list #'(spec spec1 ...)))])
                       (let loop ([spec spec])
                         (if (and (identifier? spec)
                                  (free-identifier=? spec #'defined-id))
                             (datum->syntax #'here '(unsyntax x) spec spec)
                             (syntax-case spec ()
                               [(a . b)
                                (datum->syntax spec
                                               (cons (loop #'a) (loop #'b))
                                               spec
                                               spec)]
                               [id
                                (and (identifier? #'id)
                                     (or (free-identifier=? #'id #'quote)
                                         (free-identifier=? #'id #'unquote)
                                         (free-identifier=? #'id #'quasiquote)))
                                (if (= (source-location-span #'id) 1)
                                    (datum->syntax #'here
                                                   `(unsyntax ',(syntax-e #'id))
                                                   spec
                                                   spec)
                                    (datum->syntax #'here
                                                   `(unsyntax (RACKET ,(syntax-e #'id)))
                                                   spec
                                                   spec))]
                               [id
                                (and (identifier? #'id)
                                     (or (free-identifier=? #'id #'syntax)
                                         (free-identifier=? #'id #'unsyntax)
                                         (free-identifier=? #'id #'quasisyntax)))
                                (if (= (source-location-span #'id) 2)
                                    (datum->syntax #'here
                                                   `(unsyntax ',(syntax-e #'id))
                                                   spec
                                                   spec)
                                    (datum->syntax #'here
                                                   `(unsyntax (RACKET ,(syntax-e #'id)))
                                                   spec
                                                   spec))]
                               [_ spec]))))]
                    [(maybe-result ...) (if (attribute results)
                                            #'(results.result ...)
                                            (map (λ _ #'())
                                                 (syntax->list #'(spec spec1 ...))))])
       #'(with-togetherable-racket-variables
          (l.lit ...)
          ([form [defined-id spec]] [form [defined-id spec1]] ...
                                    [non-term (g.non-term-id g.non-term-form ...)] ...)
          (*defforms k.kind lt.expr defined-id-expr
                     '(spec spec1 ...)
                     (list
                      (lambda (x)
                        (top-align
                         make-table
                         "prototype"
                         (list
                          (list (list (racketblock0/form* new-spec)))
                          (list (list (make-flow (top-align
                                                  make-table
                                                  "prototype"
                                                  (list (end (λ () (result-contract . maybe-result)))))))))))
                      ...)
                     '((g.non-term-id g.non-term-form ...) ...)
                     (list (list (lambda () (racket g.non-term-id))
                                 (lambda () (racketblock0/form g.non-term-form))
                                 ...)
                           ...)
                     (list (list (lambda () (racket c.contract-nonterm))
                                 (lambda () (racketblock0 c.contract-expr)))
                           ...)
                     (lambda () (list desc ...)))))]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; From manual-proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define top-align-styles (make-hash))
(define (top-align make-table style-name cols)
  (if (null? cols)
      (make-table style-name null)
      (let* ([n (length (car cols))]
             [k (cons style-name n)])
        (make-table
         (hash-ref top-align-styles
                   k
                   (lambda ()
                     (define s
                       (make-style style-name
                                   (list (make-table-columns (for/list ([i n])
                                                               (make-style #f '(top)))))))
                     (hash-set! top-align-styles k s)
                     s))
         cols))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-syntax (defform* stx)
  (syntax-parse stx
    [(_ k:kind-kw lt:link-target?-kw d:id-kw l:literals-kw [spec ...]
        (~optional r:results-kw)
        subs:subs-kw c:contracts-kw desc ...)
     (quasisyntax/loc stx
       (defform*/subs #:kind k.kind 
         #:link-target? lt.expr
         #:id [d.defined-id d.defined-id-expr] 
         #:literals (l.lit ...)
         [spec ...]
         #,@(if (attribute r) #'(#:results [r.result ...]) #'())
         subs.g #:contracts c.cs desc ...))]))

(define-syntax (defform stx)
  (syntax-parse stx
    [(_ k:kind-kw lt:link-target?-kw d:id-kw l:literals-kw spec
        r:result-kw
        subs:subs-kw c:contracts-kw desc ...)
     (syntax/loc stx
       (defform*/subs #:kind k.kind
         #:link-target? lt.expr
         #:id [d.defined-id d.defined-id-expr] 
         #:literals (l.lit ...)
         [spec] #:results [r.maybe-result] subs.g #:contracts c.cs desc ...))]))

(define-syntax (defform/subs stx)
  (syntax-parse stx
    [(_ k:kind-kw lt:link-target?-kw d:id-kw l:literals-kw spec r:result-kw subs desc ...)
     (syntax/loc stx
       (defform*/subs #:kind k.kind 
         #:link-target? lt.expr
         #:id [d.defined-id d.defined-id-expr] 
         #:literals (l.lit ...)
         [spec] #:results [r.maybe-result] subs desc ...))]))

(define-syntax (defform/none stx)
  (syntax-parse stx
    [(_ k:kind-kw lt:link-target?-kw l:literals-kw spec subs:subs-kw c:contracts-kw desc ...)
     (syntax/loc stx
       (with-togetherable-racket-variables
        (l.lit ...)
        ([form/none spec]
         [non-term (subs.g.non-term-id subs.g.non-term-form ...)] ...)
        (*defforms k.kind lt.expr #f
                   '(spec)
                   (list (lambda (ignored) (racketblock0/form spec)))
                   '((subs.g.non-term-id subs.g.non-term-form ...) ...)
                   (list (list (lambda () (racket subs.g.non-term-id))
                               (lambda () (racketblock0/form subs.g.non-term-form))
                               ...)
                         ...)
                   (list (list (lambda () (racket c.contract-nonterm))
                               (lambda () (racketblock0 c.contract-expr)))
                         ...)
                   (lambda () (list desc ...)))))]))

(define-syntax (defidform/inline stx)
  (syntax-case stx (unsyntax)
    [(_ id)
     (identifier? #'id)
     #'(defform-site (quote-syntax id))]
    [(_ (unsyntax id-expr))
     #'(defform-site id-expr)]))

(define-syntax (defidform stx)
  (syntax-parse stx
    [(_ k:kind-kw lt:link-target?-kw spec-id desc ...)
     #'(with-togetherable-racket-variables
        ()
        ()
        (*defforms k.kind lt.expr (quote-syntax/loc spec-id)
                   '(spec-id)
                   (list (lambda (x) (make-omitable-paragraph (list x))))
                   null
                   null
                   null
                   (lambda () (list desc ...))))]))

(define (into-blockquote s)
  (make-blockquote "leftindent"
                   (if (splice? s)
                       (flow-paragraphs (decode-flow (splice-run s)))
                       (list s))))

(define-syntax (defsubform stx)
  (syntax-case stx ()
    [(_ . rest) #'(into-blockquote (defform . rest))]))

(define-syntax (defsubform* stx)
  (syntax-case stx ()
    [(_ . rest) #'(into-blockquote (defform* . rest))]))

(define-syntax (spec?form/subs stx)
  (syntax-parse stx
    [(_ has-kw? l:literals-kw (~or (~seq #:unwrap (spec ...))
                                   (~and (~seq spec0) (~seq spec ...)))
        g:grammar
        c:contracts-kw
        desc ...)
     #:with spec* (or (attribute spec0) #'(spec ...))
     (syntax/loc stx
       (with-racket-variables
        (l.lit ...)
        ([form/maybe (has-kw? spec*)]
         [non-term (g.non-term-id g.non-term-form ...)] ...)
        (*specsubform 'spec* '(l.lit ...) (lambda () (racketblock0/form* spec ...))
                      '((g.non-term-id g.non-term-form ...) ...)
                      (list (list (lambda () (racket g.non-term-id))
                                  (lambda () (racketblock0/form g.non-term-form))
                                  ...)
                            ...)
                      (list (list (lambda () (racket c.contract-nonterm))
                                  (lambda () (racketblock0 c.contract-expr)))
                            ...)
                      (lambda () (list desc ...)))))]))

(begin-for-syntax
  (define-splicing-syntax-class unwrappable-spec
    (pattern (~seq #:unwrap s) #:with (m-u-spec ...) #'(#:unwrap s))
    (pattern (~seq spec)       #:with (m-u-spec ...) #'(spec))))

(define-syntax (specsubform stx)
  (syntax-parse stx
    [(_ l:literals-kw :unwrappable-spec subs:subs-kw c:contracts-kw desc ...)
     (syntax/loc stx
       (spec?form/subs #f #:literals (l.lit ...) m-u-spec ... subs.g #:contracts c.cs desc ...))]))

(define-syntax (specsubform/subs stx)
  (syntax-parse stx
    [(_ l:literals-kw :unwrappable-spec g:grammar desc ...)
     (syntax/loc stx
       (spec?form/subs #f #:literals (l.lit ...) m-u-spec ... 
                       ([g.non-term-id g.non-term-form ...] ...) 
                       desc ...))]))

(define-simple-macro (specspecsubform :unwrappable-spec desc ...)
  (make-blockquote "leftindent" (list (specsubform m-u-spec ... desc ...))))

(define-simple-macro (specspecsubform/subs :unwrappable-spec subs desc ...)
  (make-blockquote "leftindent" (list (specsubform/subs m-u-spec ... subs desc ...))))

(define-syntax (specform stx)
  (syntax-parse stx
    [(_ l:literals-kw spec subs:subs-kw c:contracts-kw desc ...)
     (syntax/loc stx
       (spec?form/subs #t #:literals (l.lit ...) spec subs.g #:contracts c.cs desc ...))]))

(define-syntax (specform/subs stx)
  (syntax-parse stx
    [(_ l:literals-kw spec g:grammar
        desc ...)
     (syntax/loc stx
       (spec?form/subs #t #:literals (l.lit ...) spec ([g.non-term-id g.non-term-form ...] ...)
                       desc ...))]))

(define-syntax-rule (specsubform/inline spec desc ...)
  (with-racket-variables
   ()
   ([form/maybe (#f spec)])
   (*specsubform 'spec null #f null null null (lambda () (list desc ...)))))

(define-syntax racketgrammar
  (syntax-rules ()
    [(_ #:literals (lit ...) id clause ...)
     (racketgrammar* #:literals (lit ...) [id clause ...])]
    [(_ id clause ...) (racketgrammar #:literals () id clause ...)]))

(define-syntax racketgrammar*
  (syntax-rules ()
    [(_ #:literals (lit ...) [id clause ...] ...)
     (with-racket-variables
      (lit ...)
      ([non-term (id clause ...)] ...)
      (*racketgrammar '(lit ...)
                      '(id ... clause ... ...)
                      (lambda ()
                        (list (list (racket id)
                                    (racketblock0/form clause) ...)
                              ...))))]
    [(_ [id clause ...] ...)
     (racketgrammar* #:literals () [id clause ...] ...)]))

(define-syntax-rule (var id)
  (*var 'id))

(define-syntax-rule (svar id)
  (*var 'id))


(define (meta-symbol? s) (memq s '(... ...+ ?)))

(define (defform-site kw-id)
  (let ([target-maker (id-to-form-target-maker kw-id #t)])
    (define-values (content ref-content) (definition-site (syntax-e kw-id) kw-id #t))
    (if target-maker
        (target-maker
         content
         (lambda (tag)
           (make-toc-target2-element
            #f
            (if kw-id
                (make-index-element
                 #f content tag
                 (list (datum-intern-literal (symbol->string (syntax-e kw-id))))
                 (list ref-content)
                 (with-exporting-libraries
                  (lambda (libs)
                    (make-form-index-desc (syntax-e kw-id)
                                          libs))))
                content)
            tag
            ref-content)))
        content)))

(define (*defforms kind link? kw-id forms form-procs subs sub-procs contract-procs content-thunk)
  (parameterize ([current-meta-list '(... ...+)])
    (make-box-splice
     (cons
      (make-blockquote
       vertical-inset-style
       (list
        (make-table
         boxed-style
         (append
          (for/list ([form (in-list forms)]
                     [form-proc (in-list form-procs)]
                     [i (in-naturals)])
            (list
             ((if (zero? i) (add-background-label (or kind "syntax")) values)
              ;(list
              ;(make-nested-flow (make-style #f '())
              (list
               ((or form-proc
                    (lambda (x)
                      (make-omitable-paragraph
                       (list (to-element `(,x . ,(cdr form)))))))
                (and kw-id
                     (if (eq? form (car forms))
                         (if link?
                             (defform-site kw-id)
                             (to-element #:defn? #t kw-id))
                         (to-element #:defn? #t kw-id))))))))
          (if (null? sub-procs)
              null
              (list (list flow-empty-line)
                    (list (make-flow
                           (list (let ([l (map (lambda (sub)
                                                 (map (lambda (f) (f)) sub))
                                               sub-procs)])
                                   (*racketrawgrammars "specgrammar"
                                                       (map car l)
                                                       (map cdr l))))))))
          (make-contracts-table contract-procs)))))
      (content-thunk)))))

(define (*specsubform form lits form-thunk subs sub-procs contract-procs content-thunk)
  (parameterize ([current-meta-list '(... ...+)])
    (make-blockquote
     "leftindent"
     (cons
      (make-blockquote
       vertical-inset-style
       (list
        (make-table
         boxed-style
         (cons
          (list
           (make-flow
            (list
             (if form-thunk
                 (form-thunk)
                 (make-omitable-paragraph (list (to-element form)))))))
          (append
           (if (null? sub-procs)
               null
               (list (list flow-empty-line)
                     (list (make-flow
                            (list (let ([l (map (lambda (sub)
                                                  (map (lambda (f) (f)) sub))
                                                sub-procs)])
                                    (*racketrawgrammars "specgrammar"
                                                        (map car l)
                                                        (map cdr l))))))))
           (make-contracts-table contract-procs))))))
      (flow-paragraphs (decode-flow (content-thunk)))))))

(define (*racketrawgrammars style nonterms clauseses)
  (make-table
   `((valignment baseline baseline baseline baseline baseline)
     (alignment right left center left left)
     (style ,style))
   (cdr
    (append-map
     (lambda (nonterm clauses)
       (list*
        (list flow-empty-line flow-empty-line flow-empty-line
              flow-empty-line flow-empty-line)
        (list (to-flow nonterm) flow-empty-line (to-flow "=") flow-empty-line
              (make-flow (list (car clauses))))
        (map (lambda (clause)
               (list flow-empty-line flow-empty-line
                     (to-flow "|") flow-empty-line
                     (make-flow (list clause))))
             (cdr clauses))))
     nonterms clauseses))))

(define (*racketrawgrammar style nonterm clause1 . clauses)
  (*racketrawgrammars style (list nonterm) (list (cons clause1 clauses))))

(define (*racketgrammar lits s-expr clauseses-thunk)
  (let ([l (clauseses-thunk)])
    (*racketrawgrammars #f
                        (map (lambda (x)
                               (make-element #f
                                             (list (hspace 2)
                                                   (car x))))
                             l)
                        (map cdr l))))

(define (*var id)
  (to-element (*var-sym id)))

(define (*var-sym id)
  (string->symbol (format "_~a" id)))

(define (make-contracts-table contract-procs)
  (if (null? contract-procs)
      null
      (append
       (list (list flow-empty-line))
       (list (list (make-flow
                    (map (lambda (c)
                           (make-table
                            "argcontract"
                            (list
                             (list (to-flow (hspace 2))
                                   (to-flow ((car c)))
                                   flow-spacer
                                   (to-flow ":")
                                   flow-spacer
                                   (make-flow (list ((cadr c))))))))
                         contract-procs)))))))
