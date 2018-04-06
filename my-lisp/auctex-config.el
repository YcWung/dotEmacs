(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq-default TeX-master nil)
(setq-default TeX-default-mode 'LaTeX-mode)

;; OS-dependent
(cond ((eq system-type 'windows-nt)
       (eval-after-load "tex" '(ycw:auctex-win-init)))
      ((eq system-type 'gnu/linux)
       (eval-after-load "tex" '(ycw:auctex-linux-init)))
      ((eq system-type 'darwin)
       (eval-after-load "tex" '(ycw:auctex-macos-init))))

(add-hook 'LaTeX-mode-hook 'ycw:latex-init)

(defun ycw:latex-init ()
  ;; cdlatex
  (ycw:cdlatex-config)
  (turn-on-cdlatex)
  (define-key cdlatex-mode-map  "\t"        nil)
  (define-key cdlatex-mode-map  (kbd "C-<tab>") 'cdlatex-tab)
  ;; (define-key global-map (kbd "C-<tab>") 'indent-for-tab-command)
  ;; company and yasnippet
  (require 'company-auctex)
  (company-auctex-init)
  (setq case-replace nil)
  (ycw:append-backward-to-company-initial-backend
   'company-auctex-bibs 'company-auctex-labels 'company-dabbrev 'company-files)
  (ycw:company-yas-init)
  ;; (define-key yas-minor-mode-map [(tab)]        nil)
  ;; (define-key yas-minor-mode-map (kbd "TAB")    nil)
  ;; (define-key yas-minor-mode-map (kbd "<tab>")  nil)
  ;; (define-key yas-minor-mode-map (kbd "C-<tab>") 'yas-expand)
  ;; (setq outline-minor-mode-prefix "\C-c\C-o")
  ;; (outline-minor-mode 1)
  (setq reftex-plug-into-AUCTeX t)
  (turn-on-reftex)
  ;; (LaTeX-math-mode)
  (define-key global-map
    (kbd "C-c p e") 'ycw:latex-goto-preamble-end)
  (LaTeX-add-environments
   '("Thm" LaTeX-env-label)
   '("Rfm" LaTeX-env-label)
   '("Lem" LaTeX-env-label)
   '("Prop" LaTeX-env-label)
   '("Def" LaTeX-env-label)
   '("Cor" LaTeX-env-label)
   '("Rmk" LaTeX-env-label)
   '("Ex" LaTeX-env-label)
   '("Exm" LaTeX-env-label))
  (add-to-list 'LaTeX-indent-environment-list '("align*"))
  (add-to-list 'LaTeX-indent-environment-list '("align"))
  )

(defun ycw:auctex-win-init()
  (setenv "PATH"
	  (concat "d:/Portable/RW/texlive-minimal/bin/win32" ";"
		  (getenv "PATH")))
  (setq TeX-source-correlate-mode t
	TeX-source-correlate-start-server t)
  (setq TeX-view-program-list 
	'(("Sumatra PDF"
	   ("\"d:/Portable/RW/SumatraPDFviewer/SumatraPDF.exe\" -reuse-instance" 
	    (mode-io-correlate " -forward-search %b %n ") " %o"))))
  (setq TeX-view-program-selection  
	'(((output-dvi style-pstricks) "dvips and start") (output-dvi "Yap") 
	  (output-pdf "Sumatra PDF") (output-html "start"))))

(defun ycw:auctex-linux-init()
  (setq TeX-source-correlate-mode t)
  (setq TeX-source-correlate-method 'synctex)
  (setq TeX-source-correlate-start-server t)
  (setcar (cdr (assoc 'output-pdf TeX-view-program-selection)) "Okular"))

(defun ycw:auctex-macos-init()
  (setenv "PATH"
	  (concat "/usr/local/texlive/2017/bin/x86_64-darwin" ":"
		  (getenv "PATH")))
  (setq TeX-source-correlate-mode t)
  (setq TeX-source-correlate-method 'synctex)
  (setq TeX-source-correlate-start-server t)
  (setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
  ;; -b -g %n %o %b
  (setq TeX-view-program-list
	'(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b"))))

(defun ycw:latex-goto-preamble-end()
  (interactive)
  (push-mark)
  (TeX-home-buffer)
  (goto-char (or (re-search-forward "^[%[:blank:]]+Text[%[:blank:]]+$" nil t)
		 (re-search-backward "^[%[:blank:]]+Text[%[:blank:]]+$" nil t)
		 (re-search-forward "^\\\\begin{document}" nil t)
		 (re-search-backward "^\\\\begin{document}" nil nil)))
  (goto-char (line-beginning-position))
  (backward-char))

(defun ycw:cdlatex-config()
  ;; (add-hook 'cdlatex-tab-hook 'indent-for-tab-command)
  ;; (setq cdlatex-simplify-sub-super-scripts nil)
  (setq cdlatex-env-alist
	'(("Def"
	   "\\begin{Def}\nAUTOLABEL\n?\n\\end{Def}\n" nil)
	  ("Thm"
	   "\\begin{Thm}\nAUTOLABEL\n?\n\\end{Thm}\n" nil)
	  ("equation*"
	   "\\begin{equation*}\n?\n\\end{equation*}\n" nil)
	  ("ycwpf"
	   "\\begin{proof}[\\tactic?]\n\n\\end{proof}\n" nil)
	  ("mat("
	   "\\begin{pmatrix}?\\end{pmatrix}" nil)
	  ("mat"
	   "\\begin{matrix}?\\end{matrix}" nil)))
  (setq cdlatex-command-alist
	'(("Def" "Insert definition env"   ""
	   cdlatex-environment("Def") t nil)
	  ("Thm" "Insert theorem env" ""
	   cdlatex-environment("Thm") t nil)
	  ("eq*" "Insert equation* env" ""
	   cdlatex-environment("equation*") t nil)
	  ("pf" "Insert proof env" ""
	   cdlatex-environment("ycwpf") t nil)
	  ("unj" "Insert u^n_j"
	   "u^{n?}_{j}"
	   cdlatex-position-cursor nil nil t)
	  ("enj" "Insert e^n_j"
	   "e^{n?}_{j}"
	   cdlatex-position-cursor nil nil t)
	  ("mat" "Insert matrix env"
	   "\\begin{matrix}?\\end{matrix}"
	   cdlatex-position-cursor nil nil t)
	  ("mat(" "Insert matrix env"
	   "\\begin{pmatrix}?\\end{pmatrix}"
	   cdlatex-position-cursor nil nil t)))
  (setq cdlatex-math-symbol-alist
	'((?< ("\\leftarrow" "\\longleftarrow" "\\preccurlyeq"))
	  (?> ("\\leftarrow" "\\longleftarrow" "\\succcurlyeq"))
	  (?+ ("\\oplus" "^{\\dagger}"))
	  (?2 ("^{?}_{}"))))
  (setq cdlatex-math-modify-alist
	'(( ?s    "\\mathsf"            "\\textsf" t   nil nil )
	  ( ?f    "\\mathfrak"            "\\textfrak" t   nil nil ))))
;; not work. use C-c C-n
(defun ycw:refresh-labels()
  (interactive)
  (LaTeX-add-labels))
