(defun ycw:append-backward-to-company-initial-backend(&rest backends)
  (setq company-backends
	(let ((first (car company-backends)))
	  (push (append first backends)
		(cdr company-backends)))))

(defun ycw:append-foreward-to-company-initial-backend(&rest backends)
  (setq company-backends
	(let ((first (car company-backends)))
	  (push (append backends first)
		(cdr company-backends)))))

(defun ycw:company-yas-init(&rest backends)
  (define-key global-map
    (kbd "<C-tab>") 'company-complete)
  (require 'yasnippet)
  (yas-reload-all)
  (yas-minor-mode-on)
  (setq company-backends
  	(let ((first (car company-backends)))
  	  (if (listp first)
  	      (push (append first '(company-yasnippet))
  		    (cdr company-backends))
  	      (push 'company-yasnippet company-backends))))
  (company-mode))
