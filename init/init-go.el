(require-package 'lsp-mode)
(require-package 'go-mode)
(require-package 'yasnippet)
(require-package 'project)

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

  (local-set-key (kbd "C-c C-b") 'pop-tag-mark)
  (local-set-key (kbd "C-c t") 'go-test-current-file)
  (setq tab-width 4))

(add-hook 'project-find-functions #'project-find-go-module)
(add-hook 'go-mode-hook #'lsp-deferred)
(add-hook 'go-mode-hook 'go-mode-defaults)
(add-hook 'go-mode-hook #'yas-minor-mode)

(require-package 'protobuf-mode)
(defconst protobuf-style
  '((c-basic-offset . 2)
    (indent-tabs-mode . nil)))

(add-hook 'protobuf-mode-hook
          (lambda () (c-add-style "my-style" protobuf-style t)))

(provide 'init-go)
