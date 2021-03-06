(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq-default TeX-master nil)
(setq-default TeX-default-mode 'LaTeX-mode)
(setq-default TeX-engine 'luatex)

;; global option of latex
(setq texpath-mac-2018 "/usr/local/texlive/2018/bin/x86_64-darwin")
(setq texpath-mac-2017 "/usr/local/texlive/2017/bin/x86_64-darwin")

;; OS-dependent
(cond ((eq system-type 'windows-nt)
       (eval-after-load "tex" '(ycw:auctex-win-init)))
      ((eq system-type 'gnu/linux)
       (eval-after-load "tex" '(ycw:auctex-linux-init)))
      ((eq system-type 'darwin)
       (eval-after-load "tex" '(ycw:auctex-macos-init))))

(add-hook 'LaTeX-mode-hook 'ycw:latex-init)
(add-hook 'bibtex-mode-hook 'ycw:company-yas-init)

(defun ycw:latex-init ()
  ;; cdlatex
  (ycw:cdlatex-config)
  (setq cdlatex-paired-parens "([{$")
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
  (add-to-list 'LaTeX-clean-intermediate-suffixes "\\..+\\.gnuplot")
  (local-set-key
    (kbd "C-c e p") 'ycw:latex-goto-preamble-end)
  (local-set-key
    (kbd "C-c e c") 'ycw:edit-auctex-config)
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
  (add-to-list 'LaTeX-indent-environment-list '("array"))

  (setq TeX-outline-extra
	'(("Chapter" 1)
	  ("Section" 2)
	  ("Subsection" 3)
	  ("Subsubsection" 4)
	  ("Paragraph" 5)))
  ;; add font locking to the headers
  (font-lock-add-keywords
   'latex-mode
   '(("^\\\\\\(Chapter\\|Section\\|Subsection\\|Subsubsection\\|Paragraph\\)"
      0 'font-lock-keyword-face t)
     ("^\\\\Chapter{\\(.*\\)}"       1 'font-latex-sectioning-1-face t)
     ("^\\\\Section{\\(.*\\)}"       1 'font-latex-sectioning-2-face t)
     ("^\\\\Subsection{\\(.*\\)}"    1 'font-latex-sectioning-3-face t)
     ("^\\\\Subsubsection{\\(.*\\)}" 1 'font-latex-sectioning-4-face t)
     ("^\\\\Paragraph{\\(.*\\)}"     1 'font-latex-sectioning-5-face t)))
  
  ;; (add-hook
  ;;  'find-file-hook
  ;;  (lambda ()
  ;;    (when (eq major-mode 'latex-mode)
  ;;      ;; Check if we are looking at a new or shared file.
  ;;      (when (or (not (file-exists-p (buffer-file-name)))
  ;; 		 (eq TeX-master 'shared))
  ;; 	 (add-file-local-variable
  ;; 	  'TeX-engine
  ;; 	  (intern (completing-read "Add TeX-engine with value: "
  ;; 				   (mapcar 'car (TeX-engine-alist))
  ;; 				   nil nil nil nil "luatex"))))
  ;;      (TeX-update-style t))))
  )

(defun ycw:auctex-win-init()
  (setenv "PATH"
	  ; (concat "d:/Portable/RW/texlive-minimal/bin/win32" ";"
	  (concat "d:/usr/texlive/bin/win32" ";"
		  (getenv "PATH")))
  (setq TeX-source-correlate-mode t
	TeX-source-correlate-start-server t)
  (setq TeX-view-program-list 
	'(("Sumatra PDF"
	   ; ("\"d:/Portable/RW/SumatraPDFviewer/SumatraPDF.exe\" -reuse-instance"
	   ("\"d:/usr/Sumatra/SumatraPDF.exe\" -reuse-instance" 
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
  (setenv "LANG" "en_US.UTF-8")
  (setenv "PATH"
	  (concat texpath-mac-2018 ":" (getenv "PATH")))
  (setq TeX-source-correlate-mode t)
  (setq TeX-source-correlate-method 'synctex)
  (setq TeX-source-correlate-start-server t)
  ;; (setq mac-right-option-modifier 'control)
  (setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
  ;; -b -g %n %o %b
  ;; %n %o %b
  (setq TeX-view-program-list
	'(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b"))))

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
  (setq cdlatex-command-alist
	'(
	  ("unj" "Insert u^n_j"
	   "u^{n?}_{j}"
	   cdlatex-position-cursor nil nil t)
	  ("enj" "Insert e^n_j"
	   "e^{n?}_{j}"
	   cdlatex-position-cursor nil nil t)
	  ("b(" "Insert big()"
	   "\\bigl(?\\bigr)"
	   cdlatex-position-cursor nil nil t)
	  ("B(" "Insert Big()"
	   "\\Bigl(?\\Bigr)"
	   cdlatex-position-cursor nil nil t)
	  ("bb(" "Insert bigg()"
	   "\\biggl(?\\biggr)"
	   cdlatex-position-cursor nil nil t)
	  ("BB(" "Insert Bigg()"
	   "\\Biggl(?\\Biggr)"
	   cdlatex-position-cursor nil nil t)
	  ("i<" "langle rangle, inner product"
	   "\\langle ?\\rangle"
	   cdlatex-position-cursor nil nil t)
	  ("lr<" "Insert left right angle"
	   "\\left\\langle ?\\right\\rangle"
	   cdlatex-position-cursor nil nil t)
	  ("m>" "monomorphism"
	   "\\hookrightarrow"
	   cdlatex-position-cursor nil nil t)
	  ("m<" "monomorphism"
	   "\\hookleftarrow"
	   cdlatex-position-cursor nil nil t)
	  ("e>" "epimorphism"
	   "\\twoheadrightarrow"
	   cdlatex-position-cursor nil nil t)
	  ("e<" "epimorphism"
	   "\\twoheadleftarrow"
	   cdlatex-position-cursor nil nil t)
	  ("x>" "xrightarrow"
	   "\\xrightarrow{?}"
	   cdlatex-position-cursor nil nil t)
	  ("x<" "xleftarrow"
	   "\\xleftarrow{?}"
	   cdlatex-position-cursor nil nil t)
	  ))
  (setq cdlatex-math-symbol-alist
	'((?< ("\\leftarrow" "\\longleftarrow" "\\preccurlyeq"))
	  (?> ("\\to" "\\longrightarrow" "\\succcurlyeq"))
	  (?[ ("\\Leftarrow" "\\impliedby"))
	  (?] ("\\Rightarrow" "\\implies"))
	  (?= ("\\Leftrightarrow" "\\iff"))
	  (?U ("\\bigcup" "\\bigsqcup"))
	  (?+ ("\\oplus" "^{\\dag}"))
	  (?g ("\\gamma" "\\lieg"))
	  (?b ("\\beta" "^{\\flat}"))
	  (?t ("\\tau" "\\tensor[]{?}{}"))
	  (?# ("^{\\sharp}"))
	  (?^ ("\\uparrow" "\\leftidx{^{?}}\\!"))
	  (?_ ("\\downarrow" "\\leftidx{_{?}}\\!"))
	  (?* ("\\times" "\\otimes"))
	  (?2 ("_{?}^{}" "^{?}_{}"))
	  (?/ ("\\parallel"))
	  ))
  (setq cdlatex-math-modify-alist
	'(( ?s    "\\mathscr"            "" t   nil nil )
	  ( ?B    "\\mathbb"             "" t   nil nil )
	  ( ?f    "\\mathfrak"           "\\textfrak" t   nil nil )))
  (turn-on-cdlatex)
  (define-key cdlatex-mode-map  "\t"        nil)
  ;; (define-key cdlatex-mode-map  "$"        nil)
  (define-key cdlatex-mode-map  (kbd "C-<tab>") 'cdlatex-tab))
;; not work. use C-c C-n
(defun ycw:refresh-labels()
  (interactive)
  (LaTeX-add-labels))

;; edit this file
(defun ycw:edit-auctex-config()
  (interactive)
  (find-file (concat (getenv "HOME") "/.emacs.d/my-lisp/auctex-config.el")))
