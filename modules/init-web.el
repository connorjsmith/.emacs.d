;; use web-mode for js, html, jsx, handlebars etc.
(req-package web-mode
    (add-to-list 'auto-mode-alist '("\\.js[x]?\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
    (setq web-mode-content-types-alist '(("jsx"  . "\\.js[x]?\\'")))
    (setq web-mode-enable-auto-pairing t)
    (setq web-mode-enable-css-colorization t)
)

(provide 'init-web)
