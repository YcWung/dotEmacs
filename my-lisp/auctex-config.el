(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq-default TeX-master nil)

;; (setq TeX-source-correlate-mode t
;;       TeX-source-correlate-start-server t)

(setq-default TeX-default-mode 'LaTeX-mode)

;; OS-dependent
(cond ((eq system-type 'windows-nt)
       (eval-after-load "tex" '(ycw:auctex-win-init)))
      ((eq system-type 'gnu/linux)
       (eval-after-load "tex" '(ycw:auctex-linux-init))))

(add-hook 'LaTeX-mode-hook 'ycw:latex-init)

(defun ycw:latex-init ()
  ;; (setenv "PATH"
  ;; 	  (concat "/home/ycw/.local/texlive/bin/x86_64-linux" ":"
  ;; 		  (getenv "PATH")))
  (require 'yasnippet)
  (yas-reload-all)
  (yas-minor-mode-on)
  (eval-after-load 'company
    '(add-to-list 'company-backends 'company-yasnippet))
  (company-mode)
  (require 'company-auctex)
  (company-auctex-init)
  ;; (setq outline-minor-mode-prefix "\C-c\C-o")
  ;; (outline-minor-mode 1)
  (setq reftex-plug-into-AUCTeX t)
  (turn-on-reftex)
  ;; (LaTeX-math-mode)
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
  ;; ##### Enable synctex correlation. From Okular just press
  ;; ##### Shift + Left click to go to the good line.
  ;; ### Set Okular as the default PDF viewer.
  (setcar (cdr (assoc 'output-pdf TeX-view-program-selection)) "Okular"))
