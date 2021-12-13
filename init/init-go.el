(require-package 'lsp-mode)
(require-package 'go-mode)
(require-package 'company-go)
(require-package 'project)

(add-hook 'go-mode-hook #'lsp-deferred)

(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(lsp-register-custom-settings
 '(("gopls.completeUnimported" t t)
   ("gopls.staticcheck" t t)))

(defun go-mode-defaults ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t)
  (add-hook 'before-save-hook 'gofmt-before-save nil t)
  (whitespace-toggle-options '(tabs))
  (set (make-local-variable 'company-backends) '(company-go))

  (local-set-key (kbd "C-c C-b") 'pop-tag-mark)
  (local-set-key (kbd "C-c t") 'go-test-current-file)
  (setq tab-width 4))

(add-hook 'project-find-functions #'project-find-go-module)
(add-hook 'go-mode-hook 'go-mode-defaults)


(provide 'init-go)
