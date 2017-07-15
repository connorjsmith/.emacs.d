;; Start company autocompletion in all buffers
(req-package company-quickhelp)
(req-package company
	        :require company-c-headers company-web company-jedi company-quickhelp
		    :config
                (add-hook 'after-init-hook 'global-company-mode)
                (add-to-list 'company-backends 'company-c-headers)
                (add-to-list 'company-backends 'company-c-headers)
                (add-to-list 'company-backends 'company-web-html)
                (add-to-list 'company-backends 'company-jedi)
                (setq company-idle-delay 0)
                ;; tab to cycle through company items
                (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
                (define-key company-active-map [tab] 'company-complete-common-or-cycle)
                (company-quickhelp-mode 1)
)

;; Add CEDET & semantic mode
(req-package semantic
	        :require cedet semantic/ia semantic/bovine/gcc
		    :config
                (semantic-mode 1)
)

(provide 'init-autocomplete)
