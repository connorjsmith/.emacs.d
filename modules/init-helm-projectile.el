;; use projectile for large projects
(req-package projectile
    :config
        (projectile-global-mode)
        (setq projectile-enable-caching t)
)
(req-package helm-projectile
    :require projectile helm-ag
    :config
        (setq projectile-completion-system 'helm)
        (helm-projectile-on)
)

;; enable helm in all buffers
(req-package helm-config
	        :require helm evil projectile helm-projectile
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
                (setq helm-split-window-in-side-p t)
                ;; use ls to open the helm-mini window
                (defalias 'buffer-menu 'helm-mini)
                ;; Alias helm-projectile-find-file to hpff
                (defalias 'hpff 'helm-projectile-find-file)
                ;; Alias helm-ag-project-root to hagpr
                (defalias 'hagpr 'helm-ag-project-root)
                ;; use M-hjkl to navigate helm
                (define-key helm-map (kbd "M-h") 'helm-previous-page)
		   :config
            ;; Enable rainbow delimiters in programming modes
            (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
            ;; enable coloured backgrounds in html and css files
            (add-hook 'css-mode-hook 'rainbow-mode)
            (add-hook 'html-mode-hook 'rainbow-mode)
)

(provide 'init-helm-projectile)
