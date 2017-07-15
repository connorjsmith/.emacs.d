(req-package evil
            :require ibuffer evil-numbers
            :ensure ibuffer
            :config
                (evil-mode 1)
                ;; Fix some evil mode state issues
                (add-to-list 'evil-emacs-state-modes 'package-menu-mode)
                (evil-set-initial-state 'package-menu-mode 'motion)
                (evil-set-initial-state 'ibuffer-mode 'normal)

                ;; Remove the C-u binding provided by emacs and use the vim scroll page up command instead
                (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

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

                ;; Exit insert mode by pressing j and then j quickly
                ;; Note that this must come last in this require block
                (setq key-chord-two-keys-delay 0.1)
                (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
                (key-chord-mode 1)
)
;; Enable powerline (spaceline)
(req-package spaceline
            :config
            (spaceline-emacs-theme)
            ;; Use colour highlighting to represent the current mode
            (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
)

;; enable line numbers
(req-package linum-relative
            :require linum
            :config
                (global-linum-mode 1)
                (linum-relative-on)
                (setq linum-relative-current-symbol "")
)

(provide 'init-evil)
