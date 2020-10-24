(require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.org/packages/") t)
(setq package-archives
      '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
	("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (py-autopep8 company-anaconda matlab-mode company-lsp lsp-julia quelpa lsp-mode anaconda-mode "anaconda-mode" persistent-overlays term+ origami julia-repl julia-mode google-c-style dracula-theme company-auctex cdlatex)))
 '(safe-local-variable-values (quote ((TeX-source-correlate-method-active . synctex)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
