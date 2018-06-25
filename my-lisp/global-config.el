(require 'company)
(make-variable-buffer-local 'company-backends)

(when (eq system-type 'darwin)
  (setq mac-right-option-modifier 'control)
  (global-set-key [kp-delete] 'delete-char)
  )
