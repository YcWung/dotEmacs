(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq-default TeX-master nil)
(setq-default TeX-default-mode 'LaTeX-mode)

;; OS-dependent
(cond ((eq system-type 'windows-nt)
       (eval-after-load "tex" '(ycw:auctex-win-init)))
      ((eq system-type 'gnu/linux)
       (eval-after-load "tex" '(ycw:auctex-linux-init))))

(add-hook 'LaTeX-mode-hook 'ycw:latex-init)

(defun ycw:latex-init ()
  (require 'company-auctex)
  (company-auctex-init)
  (ycw:append-backward-to-company-initial-backend
   'company-auctex-bibs 'company-auctex-labels 'company-dabbrev)
  (ycw:company-yas-init)
  ;; (setq outline-minor-mode-prefix "\C-c\C-o")
  ;; (outline-minor-mode 1)
  (setq reftex-plug-into-AUCTeX t)
  (turn-on-reftex)
  ;; (LaTeX-math-mode)
  (define-key global-map
    (kbd "C-c p e") 'ycw:latex-goto-preamble-end)
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
  (setcar (cdr (assoc 'output-pdf TeX-view-program-selection)) "Okular"))

(defun ycw:latex-goto-preamble-end()
  (interactive)
  (TeX-home-buffer)
  (goto-char (or (re-search-forward "^[%[:blank:]]+Text[%[:blank:]]+$" nil t)
		 (re-search-backward "^[%[:blank:]]+Text[%[:blank:]]+$" nil t)
		 (re-search-forward "^\\\\begin{document}" nil t)
		 (re-search-backward "^\\\\begin{document}" nil nil)))
  (goto-char (line-beginning-position))
  (backward-char))
