(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Set environment variables
;(setenv "LC_CTYPE" "C")

;; Set up load path
(add-to-list 'load-path "~/.emacs.d/my-lisp")
(add-to-list 'load-path "~/.emacs.d/lisp")

(load "ycw-utils")
(load "global-config")
;; Loads and set up auctex settings
(load "auctex-config")
;; Loads and set up C++ settings
(load "cxx-config")
;; Proof General
(load "PG/generic/proof-site")
;; Loads and set up UI settings
(load "ui-config")
;; Loads miscellaneous settings
(load "misc-config")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck google-c-style company-rtags rtags cmake-ide cmake-mode company-irony company-irony-c-headers term+ ess company-coq company company-auctex yasnippet auctex)))
 '(safe-local-variable-values (quote ((TeX-source-correlate-method-active . synctex))))
 '(tool-bar-mode nil))

