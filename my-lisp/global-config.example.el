;; platform-specific variables
(when (eq system-type 'darwin)
  (setq ycw:julia-dir
	"/Applications/Julia-1.0.app/Contents/Resources/julia/bin")
  (setq ycw:frame-width 90)
  (setq ycw:frame-height 50)
  )
(when (eq system-type 'windows-nt)
  (setq ycw:git-dir "d:/usr/Git/cmd")
  (setq ycw:julia-dir "d:/usr/JuliaPro-0.6.2.2/julia-0.6.2/bin")
  )

;; apply some global settings
(when (eq system-type 'darwin)
  (setq mac-right-option-modifier 'control)
  (global-set-key [kp-delete] 'delete-char)
  )
(when (eq system-type 'windows-nt)
  (ycw:add-to-sys-path ycw:git-dir ycw:julia-dir)
  )

;; common packages
(require 'company)
(make-variable-buffer-local 'company-backends)
(require 'cdlatex)
(make-variable-buffer-local 'cdlatex-paired-parens)
(make-variable-buffer-local 'cdlatex-simplify-sub-super-scripts)
