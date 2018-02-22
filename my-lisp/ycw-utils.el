(defun ycw:yas-minor-init()
  (require 'yasnippet)
  (yas-reload-all)
  (yas-minor-mode-on)
  (eval-after-load 'company
    '(push 'company-yasnippet company-backends))
  )

