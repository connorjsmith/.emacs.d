(server-start)
(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
          package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
          package-archives)
(package-initialize)

(unless (package-installed-p 'req-package)
    (package-refresh-contents)
    (package-install 'req-package)
)

;; Install all packages if they are not already present
(setq req-package-always-ensure t)
(eval-when-compile (require 'req-package))

(req-package exec-path-from-shell
    :config
        (when (memq window-system '(mac ns))
        (exec-path-from-shell-initialize))
)

(add-to-list 'load-path "~/.emacs.d/modules")
(require 'colour-scheme)
(require 'init-autocomplete)
(require 'init-basic)
(require 'init-evil)
(require 'init-helm-projectile)
(require 'init-web)

;; Load all packages in the correct order
;; Must be the last line of the file
(req-package-finish)
