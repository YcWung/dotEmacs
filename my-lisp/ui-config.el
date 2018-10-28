;; UI settings

;; Enables menubar, disable toolbar, scroolbar
(tool-bar-mode -1)
;; (scroll-bar-mode -1)
;; (menu-bar-mode)
;; Show path of file in titlebar
(setq-default frame-title-format "%b (%f)")
;; Turn off sound alarms completely
(setq ring-bell-function 'ignore)
;; disable welcome page
(setq inhibit-startup-message t)
;; Current line highlighting
;; (require 'hl-line)
;; (global-hl-line-mode)
;(setq ns-pop-up-frames nil)

;(column-number-mode)

; load theme
(load-theme 'dracula t)

(defun ycw:win-fonts-setup()
  ;; Setting English Font
  (set-face-attribute
   'default nil :font "Courier New-10")
  ;; Chinese Font
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
		      charset
		      (font-spec :family "Microsoft Yahei"))))

(defun ycw:linux-fonts-setup()
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (
		  :family "Noto Sans Mono"
			  :foundry "GOOG"
			  :slant normal
			  :weight normal
			  :height 98
			  :width normal))))))

;; os-specific settings
(cond ((eq system-type 'windows-nt)
       (ycw:win-fonts-setup))
      ((eq system-type 'gnu/linux)
       (ycw:linux-fonts-setup)))
