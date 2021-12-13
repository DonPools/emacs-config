;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(let ((minver 23))
  (unless (>= emacs-major-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher"
           minver)))

(add-to-list 'load-path (expand-file-name "init" user-emacs-directory))

;; disable because of elpa bug in emacs 27.1
(setq package-gnupghome-dir nil) ;; this line not effect anyting?
(setq package-check-signature nil)

(defconst *is-a-mac* (eq system-type 'darwin))

(require 'init-package)
(require 'init-exec-path)
(require 'init-font)
(require 'init-gui)
(require 'init-image)
(require 'init-whitespace)
(require 'init-edit)

(require 'init-spacetheme)
(require 'init-helm)
(require 'init-swiper)
(require 'init-ace)
(require 'init-undo-tree)
(require 'init-multi-cursors)
(require 'init-window)

(require 'init-company)
(require 'init-projectile)

(require 'init-markdown-mode)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
(put 'set-goal-column 'disabled nil)
