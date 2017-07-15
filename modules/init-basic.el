;;
;;  This makes Emacs ignore the "-e (make-frame-visible)" 
;;  that it gets passed when started by emacsclientw.
;;
(add-to-list 'command-switch-alist '("(make-frame-visible)" .
                 (lambda (s))))(require 'req-package)

;; Automatically reload buffers if they've changed elsewhere
(global-auto-revert-mode t)

;; Don't show scrollbars
(scroll-bar-mode -1)

;; Truncate long lines
(setq-default truncate-lines t)
(setq truncate-partial-width-windows nil)

;; enable tramp mode over ssh
(req-package tramp
	        :config
		        (setq tramp-default-method "ssh")
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

(provide 'init-basic)
