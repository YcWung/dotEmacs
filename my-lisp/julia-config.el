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
	   (add-to-list 'exec-path ycw:julia-dir)
	   (add-to-list 'exec-path ycw:bash-dir)
	   )))
  (require 'julia-repl)
  (julia-repl-mode)
  ;; (setq julia-repl-prompt-executable (concat ycw:julia-dir "/julia.exe"))
  ;; (setq julia-repl-executable-records
  ;; 	`((default ,(concat ycw:julia-dir "/julia"))))
  ;; (require 'julia-shell)
  ;; (define-key julia-mode-map (kbd "C-c C-c") 'julia-shell-run-region-or-line)
  ;; (define-key julia-mode-map (kbd "C-c C-s") 'julia-shell-save-and-go)
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
