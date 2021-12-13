(require-package 'company)
(require-package 'company-shell)

(setq company-tooltip-limit 20)
(setq company-minimum-prefix-length 0)
(setq company-idle-delay .3)
(setq company-echo-delay 0)
(setq company-begin-commands '(self-insert-command))
(setq company-tooltip-flip-when-above t)


(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas)
          (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
(add-to-list 'company-backends 'company-shell)

(global-company-mode 1)

(provide 'init-company)
