(server-start)
(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
    package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
    package-archives)
(package-initialize)

;; Install all packages if they are not already present
(require 'req-package)
(setq req-package-always-ensure t)

;; Automatically reload buffers if they've changed elsewhere
(global-auto-revert-mode t)

;; Truncate long lines
(setq-default truncate-lines t)
(setq truncate-partial-width-windows nil)

;; enable helm in all buffers
(req-package helm-config
    :require helm evil
    :ensure evil
    :config
        (helm-mode 1)
        (helm-autoresize-mode t)
        ;; Use helm for M-x functionality
        (global-set-key (kbd "M-x") 'helm-M-x)
        (setq helm-M-x-fuzzy-match t)
        ;; Use helm to show the kill ring
        (global-set-key (kbd "M-p") 'helm-show-kill-ring)
        ;; Use helm to open files with Alt-O
        (global-set-key (kbd "M-o") 'helm-find-files)
        ;; Use helm mini instead of the classic "ls" function
        (setq helm-buffers-fuzzy-matching t)
        (setq helm-recentf-fuzzy-match t)
        ;; use ls to open the helm-mini window
        (defalias 'buffer-menu 'helm-mini)
        ;; use M-hjkl to navigate helm
        (define-key helm-map (kbd "M-h") 'helm-previous-page)
        (define-key helm-map (kbd "M-j") 'helm-next-line)
        (define-key helm-map (kbd "M-k") 'helm-previous-line)
        (define-key helm-map (kbd "M-l") 'helm-next-page)
        (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
        (define-key helm-map (kbd "M-/") 'helm-select-action)
        ;; use M-hl to navigate directories in helm-find-files
        (define-key helm-find-files-map (kbd "M-h") 'helm-find-files-up-one-level)
        (define-key helm-find-files-map (kbd "M-l") 'helm-execute-persistent-action)
)
;; enable rainbow-delimiters-mode
;; (use-package 'rainbow-mode)
(req-package rainbow-delimiters
    :require rainbow-mode
    :config
        ;; Enable rainbow delimiters in programming modes
        (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
        ;; enable coloured backgrounds in html and css files
        (add-hook 'css-mode-hook 'rainbow-mode)
        (add-hook 'html-mode-hook 'rainbow-mode)
)


;; set indentation level to 4 spaces or detect them from the existing code
(req-package dtrt-indent
    :config
        (dtrt-indent-mode 1)
        (setq-default indent-tabs-mode nil)
        (setq-default tab-width 4)
        (setq-default c-basic-offset 4 c-default-style "k&r")
        (setq indent-line-function 'insert-tab)
)

(req-package evil
    :require ibuffer evil-numbers
    :ensure ibuffer
    :config
        (evil-mode 1)
        ;; Fix some evil mode state issues
        (add-to-list 'evil-emacs-state-modes 'package-menu-mode)
        (evil-set-initial-state 'package-menu-mode 'motion)
        (evil-set-initial-state 'ibuffer-mode 'normal)

        ;; remap ; to : in normal mode
        (define-key evil-normal-state-map (kbd ";") 'evil-ex)

        ;; Increment numbers by pressing = (+) and - in normal mode
        (define-key evil-normal-state-map (kbd "=") 'evil-numbers/inc-at-pt)
        (define-key evil-normal-state-map (kbd "-") 'evil-numbers/dec-at-pt)

        ;; fix <C-r> behavior in the minibuffer and Ctrl+r = expression buffer
        (define-key minibuffer-local-map "\C-r" 'evil-paste-from-register)
        (evil-ex-define-cmd "\C-r" 'evil-paste-from-register)

        (global-unset-key (kbd "M-h"))
        (global-set-key (kbd "M-h") 'previous-buffer)
        (global-unset-key (kbd "M-l"))
        (global-set-key (kbd "M-l") 'next-buffer)

        ;;Exit insert mode by pressing j and then j quickly
        ;; Note that this must come last in this require block
        (setq key-chord-two-keys-delay 0.1)
        (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
        (key-chord-mode 1)
)

;; use web-mode for js, html, jsx, handlebars etc.
(req-package web-mode
    (add-to-list 'auto-mode-alist '("\\.js[x]?\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
    (setq web-mode-content-types-alist '(("jsx"  . "\\.js[x]?\\'")))
    (setq web-mode-enable-auto-pairing t)
    (setq web-mode-enable-css-colorization t)
)
;; Start company autocompletion in all buffers
(req-package company
    :require company-c-headers company-jedi company-web
    :config
        (add-hook 'after-init-hook 'global-company-mode)
        (add-to-list 'company-backends 'company-c-headers)
        (add-to-list 'company-backends 'company-jedi)
        (add-to-list 'company-backends 'company-web-html)
        (setq company-idle-delay 0)
        ;; tab to cycle through company items
        (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
        (define-key company-active-map [tab] 'company-complete-common-or-cycle)
)

;; Add CEDET & semantic mode
(req-package semantic
    :require cedet semantic/ia semantic/bovine/gcc
    :config
        (semantic-mode 1)
)
;; enable tramp mode over ssh
(req-package tramp
    :config
        (setq tramp-default-method "ssh")
)

;; enable line numbers
(req-package linum-relative
    :require linum
    :config
        (global-linum-mode 1)
        (linum-relative-on)
        (setq linum-relative-current-symbol "")
)

;; Enable powerline (spaceline)
(req-package spaceline
    :config
        (spaceline-emacs-theme)
        ;; Use colour highlighting to represent the current mode
        (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
)

;; Color scheme
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a2e7b508533d46b701ad3b055e7c708323fb110b6676a8be458a758dd8f24e27" "1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" "ba9be9caf9aa91eb34cf11ad9e8c61e54db68d2d474f99a52ba7e87097fa27f5" "4f5bb895d88b6fe6a983e63429f154b8d939b4a8c581956493783b2515e22d6d" "94ba29363bfb7e06105f68d72b268f85981f7fba2ddef89331660033101eb5e5" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(req-package ample-zen-theme
  :config
        (load-theme 'ample-zen)
)
;; (load-theme 'seti)

;; Load all packages in the correct order
;; Must be the last line of the file
(req-package-finish)
