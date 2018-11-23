;; Julia
;; (eval-after-load "jl" '(ycw:julia-init))
;; (eval-after-load "jl"
;;   (lambda()
;;     (require 'julia-mode)
;;     (add-hook 'julia-mode-hook 'ycw:julia-mode-setup)))
(add-hook 'julia-mode-hook 'ycw:julia-mode-setup)
(defun ycw:julia-mode-setup()
  (setq julia-indent-offset 2)
  (cond ((eq system-type 'windows-nt)
  	 (progn
	   (add-to-list 'exec-path ycw:bash-dir)
	   )))
  (when (boundp 'ycw:julia-dir)
    (ycw:add-to-sys-path ycw:julia-dir))
  (require 'julia-repl)
  (require 'term+)
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
   'company-keywords 'company-dabbrev 'company-files)
  
  (ycw:cdlatex-config)
  (cdlatex-mode -1)
  ;; (defun cdlatex-number-of-backslashes-is-odd () t)
  ;; (defun texmathp () t)
  (setq cdlatex-paired-parens "([{")
  (setq cdlatex-simplify-sub-super-scripts nil)
  (use-local-map (copy-keymap cdlatex-mode-map))
  (local-set-key  "$"         nil)
  (local-set-key  "^"         nil)
  (local-set-key  "_"         nil)
  (local-set-key  "\C-c?"     nil)
  (local-set-key  "\C-c{"     nil)
  (local-set-key  [(control return)] nil)
  (local-set-key
    (cdlatex-get-kbd-vector cdlatex-math-modify-prefix)
    nil)
  ;; (local-set-key
  ;;   (cdlatex-get-kbd-vector cdlatex-math-symbol-prefix)
  ;;   (lambda () (interactive) (cdlatex-math-symbol) (latexsub)))
  (local-set-key
   (cdlatex-get-kbd-vector cdlatex-math-symbol-prefix)
   'ycw:julia-symbol)
  )

(defun ycw:julia-symbol ()
  (interactive)
  (let* ((cell (cdlatex-read-char-with-help
		cdlatex-math-symbol-alist-comb
		1 cdlatex-math-symbol-no-of-levels
		"Math symbol level %d of %d: "
		"AVAILABLE MATH SYMBOLS.  [%c]=next level "
		cdlatex-math-symbol-prefix
		(get 'cdlatex-math-symbol-alist-comb 'cdlatex-bindings)))
	 (char (car cell))
	 (level (cdr cell))
	 (entry (assoc char cdlatex-math-symbol-alist-comb))
	 (symbol (nth level entry)))

    (if (or (not symbol)
	    (not (stringp symbol))
	    (equal symbol ""))
	(error "No such math symbol %c on level %d" char level))

    (insert symbol)
    ;; (when (string-match "\\?" symbol)
    ;;   (cdlatex-position-cursor))
    (latexsub)
    ))

(defun ycw:julia-init()
  ;; ESS
  (require 'ess-site)
  (ess-julia-mode)
  (ycw:company-yas-init)
  (push 'company-keywords company-backends))
