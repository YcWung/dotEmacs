;; UI settings

;; Enables menubar, disable toolbar, scroolbar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode)
;; Show path of file in titlebar
(setq-default frame-title-format "%b (%f)")
;; Turn off sound alarms completely
(setq ring-bell-function 'ignore)
;; disable welcome page
(setq inhibit-startup-message t)
;; Current line highlighting
(require 'hl-line)
(global-hl-line-mode)
;(setq ns-pop-up-frames nil)

;(column-number-mode)
