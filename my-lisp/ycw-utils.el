(defun to-list (x)
  (if (listp x) x (list x)))

(defun ycw:append-backward-to-company-initial-backend(&rest backends)
  (if (null backends)
      nil
    (setq company-backends
	  (let ((first (car company-backends)))
	    (push (append (to-list first) backends)
		  (cdr company-backends))))))

(defun ycw:append-foreward-to-company-initial-backend(&rest backends)
  (if (null backends)
      nil
    (setq company-backends
	  (let ((first (car company-backends)))
	    (push (append backends (to-list first))
		  (cdr company-backends))))))

(defun ycw:company-yas-init(&rest backends)
  ;; (define-key global-map
  ;;   (kbd "<C-tab>") 'company-complete)
  (require 'yasnippet)
  (yas-reload-all)
  (yas-minor-mode-on)
  ;; (setq company-backends
  ;; 	(let ((first (car company-backends)))
  ;; 	  (if (listp first)
  ;; 	      (push (append first '(company-yasnippet))
  ;; 		    (cdr company-backends))
  ;; 	    (push 'company-yasnippet company-backends))))
  ;; (apply 'ycw:append-foreward-to-company-initial-backend backends)
  (push backends company-backends)
  (company-mode))

(defun ycw:add-to-sys-path (&rest dirs)
  (let ((sep (if (eq system-type 'windows-nt) ";" ":")))
    (dolist (dir dirs)
      (setenv "PATH"
	      (concat dir sep (getenv "PATH"))))
    (getenv "PATH")))
