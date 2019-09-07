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

;; term-mode
(add-hook 'term-mode-hook 'ycw:setup-term)
(defun ycw:setup-term ()
  (read-only-mode -1)
  (define-key term-mode-map (kbd "M-w") 'kill-ring-save)
  (require 'term+)
  (define-key term-mode-map (kbd "C-y") 'term+yank))

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

;; auto folding / unfolding
(global-origami-mode)
(define-key origami-mode-map (kbd "C-c - -") 'origami-toggle-node)
(define-key origami-mode-map (kbd "C-c - a") 'origami-toggle-all-nodes)
(define-key origami-mode-map (kbd "C-c - o") 'origami-open-node-recursively)
(define-key origami-mode-map (kbd "C-c - r") 'origami-recursively-toggle-node)
(define-key origami-mode-map (kbd "C-c - .") 'origami-show-only-node)

;; edit configuration files
(define-key global-map (kbd "C-c e c") 'ycw:find-conf-file)
(defun ycw:find-conf-file (filepath)
  (interactive
   (list
    (read-file-name "find configuration file: " "~/.emacs.d/my-lisp/" nil nil ".el"
		    (lambda (nm)
		      (if (string-match "~$" nm) nil t)))))
  (find-file filepath))

;; kill buffer and delete window
(define-key global-map (kbd "C-c k") 'kill-buffer-and-window)

;; key bindings
(define-key global-map (kbd "M-<left>") 'pop-global-mark)
(when (eq system-type 'darwin)
  (define-key global-map (kbd "C-c SPC") 'execute-extended-command))
(define-key global-map (kbd "C-c C-r") (lambda () (interactive) (revert-buffer t t)))

;; backup
(setq make-backup-files nil)
