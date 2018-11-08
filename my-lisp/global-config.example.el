;; platform-specific variables
(when (eq system-type 'darwin)
  (setq ycw:julia-dir "")
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
