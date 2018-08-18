;;; lang-go.el -*- lexical-binding: t; -*-

;; go get github.com/sourcegraph/go-langserver
(use-package lsp-go
  :commands lsp-go-enable
  :hook (go-mode . lsp-go-enable))

(use-package go-mode
  :mode "\\.go$"
  :interpreter "go"
  :config
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)

  (use-package go-projectile
    :after projectile
    :commands (go-projectile-mode-go go-projectile-switch-project)
    :hook ((go-mode . go-projectile-mode)
           (projectile-after-switch-project . go-projectile-switch-project))))

(provide 'lang-go)

;;; lang-go.el ends here
