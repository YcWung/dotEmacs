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
;; (eval-after-load "jl" '(ycw:julia-init))
;; (eval-after-load "jl"
;;   (lambda()
;;     (require 'julia-mode)
;;     (add-hook 'julia-mode-hook 'ycw:julia-mode-setup)))
(add-hook 'julia-mode-hook 'ycw:julia-mode-setup)
(defun ycw:julia-mode-setup()
  (cond ((eq system-type 'windows-nt)
  	 (progn
	   (setq ycw:julia-home
		 "d:/Portable/Calculate/JuliaPro-0.6.2.2/Julia-0.6.2/bin")
	   (setenv "PATH"
		   (concat ycw:julia-home ";" (getenv "PATH")))
	   (add-to-list 'exec-path ycw:julia-home)
	   ;; (setq explicit-shell-file-name
	   ;; 	 "D:/Portable/Misc/babun/cygwin/bin/bash.exe")
	   ;; (setq shell-file-name explicit-shell-file-name)
	   (add-to-list 'exec-path "D:/Portable/Misc/babun/cygwin/bin")
	   )))
  ;; (require 'julia-repl)
  ;; (julia-repl-mode)
  ;; (julia-repl-set-executable (concat ycw:julia-home "/julia.exe"))
  (require 'julia-shell)
  (define-key julia-mode-map (kbd "C-c C-c") 'julia-shell-run-region-or-line)
  (define-key julia-mode-map (kbd "C-c C-s") 'julia-shell-save-and-go)
  ;; (setq julia-shell-program
  ;; 	"D:\\Portable\\Calculate\\Julia-0.6.0\\bin\\julia.exe")
  (ycw:company-yas-init)
  (ycw:append-backward-to-company-initial-backend
   'company-keywords 'company-dabbrev 'company-files))

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
		(member major-mode
			'(emacs-lisp-mode lisp-mode
					  clojure-mode    scheme-mode
					  haskell-mode    ruby-mode
					  rspec-mode      python-mode
					  c-mode          c++-mode
					  cmake-mode       latex-mode
					  plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))

;; key bindings
(define-key global-map (kbd "M-<left>") 'pop-global-mark)
