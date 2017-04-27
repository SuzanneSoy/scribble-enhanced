[![Build Status,](https://img.shields.io/travis/jsmaniac/scribble-enhanced/master.svg)](https://travis-ci.org/jsmaniac/scribble-enhanced)
[![Coverage Status,](https://img.shields.io/coveralls/jsmaniac/scribble-enhanced/master.svg)](https://coveralls.io/github/jsmaniac/scribble-enhanced)
[![Build Stats,](https://img.shields.io/badge/build-stats-blue.svg)](http://jsmaniac.github.io/travis-stats/#jsmaniac/scribble-enhanced)
[![Online Documentation.](https://img.shields.io/badge/docs-online-blue.svg)](http://docs.racket-lang.org/scribble-enhanced/)

scribble-enhanced
=================

This `racket` package provides enhancements for the scribble library.

Installation
------------

Install with:

```
raco pkg install --deps search-auto scribble-enhanced
```

This library is unstable
------------------------

For now, this package's API should be considered unstable.
Append `#COMMIT_NUMBER` at the end of `…scribble-enhanced.git`
in the command-line above to specify a version to install
(it will not be automatically updated by `raco pkg update` that way).

Files
-----

* `doc.rkt`
  Enhancements and utilities for documentation and literate programming files
  using scribble and scribble/lp2.

* `math.rkt`

  Allows typesetting mathematical formulas in documentation and literate
  programming files using scribble and scribble/lp2.

* `scribblings/scribble-enhanced-template.lp2.rkt`

  Example document using the features in `doc.rkt` and `math.rkt`.

* `scribblings/scribble-enhanced-example.lp2.rkt`

  Other simpler example document using the features in `doc.rkt` and
  `math.rkt`.
