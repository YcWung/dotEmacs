;; Text mode settings
(add-to-list 'auto-mode-alist '("\\.gitignore\\'" . text-mode))
(add-hook 'text-mode-hook 'ycw:text-mode-init)
(defun ycw:text-mode-init()
  (setq require-final-newline nil)
  (push '(company-dabbrev) company-backends)
  (ycw:company-yas-init)
  )

;; Elisp mode settings
(add-hook 'emacs-lisp-mode-hook 'ycw:elisp-init)
(defun ycw:elisp-init()
  (push '(company-capf) company-backends)
  (ycw:company-yas-init)
  )

;; Julia
(eval-after-load "jl" '(ycw:julia-init))
(defun ycw:julia-init()
  ;; ESS
  (require 'ess-site)
  (ess-julia-mode)
  (ycw:company-yas-init)
  (push 'company-keywords company-backends))

;; CMake
(setq auto-mode-alist
      (append
       '(("CMakeList\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))
(autoload 'cmake-mode "cmake-mode.el" t)
(add-hook 'cmake-mode-hook 'ycw:cmake-init)
(defun ycw:cmake-init ()
  "Initialize the cmake mode."
  (require 'yasnippet)
  (yas-reload-all)
  (yas-minor-mode-on)
  (company-mode)
  )

;; Auto-indent yanked code
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		(member major-mode '(emacs-lisp-mode lisp-mode
						     clojure-mode    scheme-mode
						     haskell-mode    ruby-mode
						     rspec-mode      python-mode
						     c-mode          c++-mode
						     cmake-mode       latex-mode
						     plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))
