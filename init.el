(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
package-archives)
(package-initialize)

;; enable rainbow-delimiters-mode
(require 'rainbow-mode)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; enable coloured backgrounds in html and css files
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'html-mode-hook 'rainbow-mode)

;; set indentation level to 4 spaces
(require 'dtrt-indent)
(dtrt-indent-mode 1)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4 c-default-style "k&r")
(setq indent-line-function 'insert-tab)

;; Use evil and start in insert mode / emacs for some modes
(require 'evil)
(evil-mode 1)

(add-to-list 'evil-emacs-state-modes 'package-menu-mode)
(evil-set-initial-state 'package-menu-mode 'motio
(evil-set-initial-state 'ibuffer-mode 'normal)

;;Exit insert mode by pressing j and then j quickly
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)

;; remap ; to : in normal mode
(define-key evil-normal-state-map (kbd ";") 'evil-ex)

;; Increment numbers by pressing = (+) and - in normal mode
(define-key evil-normal-state-map (kbd "=") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "-") 'evil-numbers/dec-at-pt)

;; Start autocompletion in all buffers
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-c-headers)
(setq company-idle-delay 0)
;; tab to cycle through company items
(define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
(define-key company-active-map [tab] 'company-complete-common-or-cycle)

;; Add CEDET & semantic mode
(require 'cedet)
(require 'semantic)
(require 'semantic/ia)
(require 'semantic/bovine/gcc)
(semantic-mode 1)

;; enable tramp mode over ssh
(require 'tramp)
(setq tramp-default-method "ssh")

;; enable line numbers
(require 'linum)
(require 'linum-relative)
(global-linum-mode 1)
(linum-relative-on)
(setq linum-relative-current-symbol "")

;; Color scheme
(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(custom-safe-themes
(quote
("94ba29363bfb7e06105f68d72b268f85981f7fba2ddef89331660033101eb5e5" default))))
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
)
(load-theme 'seti)

