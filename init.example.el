(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Set environment variables
; (setenv "LC_CTYPE" "C")

;; Set up load path
(add-to-list 'load-path "~/.emacs.d/my-lisp")

(load "ycw-utils")
(load "global-config")
(load "ui-config")
(load "auctex-config")
(load "cxx-config")
(load "python-config")
(load "julia-config")
(load "misc-config")
