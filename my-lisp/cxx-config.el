;; Use cmake-ide package
;; (hack-dir-local-variables)
;; (require 'rtags)
;; (cmake-ide-setup)

(defun ycw:cmake-ide-init()
  (setq enable-local-variables :all)
  (hack-dir-local-variables)
  (cmake-ide-setup))

;; (add-hook 'c-mode-common-hook 'ycw:cxx-init-with-clangd)
;; (add-hook 'c-mode-common-hook 'ycw:cmake-ide-init)
(add-hook 'c-mode-common-hook 'ycw:basic-c-init)
(defun ycw:basic-c-init ()
  (ycw:company-yas-init)
  (require 'google-c-style)
  (google-set-c-style)
  (google-make-newline-indent)
  (clang-format+-mode)
  )
(defun ycw:cxx-init-with-clangd ()
  (ycw:basic-c-init)
  (ycw:append-backward-to-company-initial-backend
   'company-keywords 'company-dabbrev 'company-files 'company-lsp)
  (setq lsp-enable-file-watchers t)
  (lsp-deferred)
  )
  
(defun ycw:cxx-init ()
  (ycw:company-yas-init)
  (ycw:rtags-init)
  (irony-mode)
  (eval-after-load 'company
    '(add-to-list 'company-backends
		  '(company-irony-c-headers company-irony)))
  (require 'google-c-style)
  (google-set-c-style)
  (google-make-newline-indent)
  )
(defun ycw:rtags-init()
  (require 'rtags)
  (setq rtags-autostart-diagnostics t)
  (setq rtags-completions-enabled t)
  (rtags-enable-standard-keybindings)
  (require 'company)
  (push 'company-rtags company-backends)
  )

(defun lsp-clangd (compile-commands-dir)
  (interactive
   (list
    (read-directory-name "compile commands directory: " default-directory nil nil "build")))
  (let ((args (concat "--compile-commands-dir="
		      (expand-file-name compile-commands-dir)
		      "")))
    (require 'lsp-clients)
    (setq lsp-clients-clangd-args (list args))
    (message "server launch command: %s" (lsp-clients--clangd-command))
    (lsp)
    (ycw:append-backward-to-company-initial-backend
     'company-keywords 'company-dabbrev 'company-files 'company-lsp)
    (add-hook 'c-mode-common-hook (lambda ()
				    (ycw:append-backward-to-company-initial-backend
				     'company-keywords
				     'company-dabbrev
				     'company-files)
				    (lsp-deferred)))))
