;;; core-lsp.el -*- lexical-binding: t; -*-

(use-package lsp-mode
  :diminish lsp-mode
  :config
  (setq lsp-inhibit-message t
        lsp-message-project-root-warning t)

  (use-package lsp-imenu
    :ensure nil
    :hook (lsp-after-open-hook . lsp-enable-imenu))

  (use-package lsp-ui
    :bind (:map lsp-ui-mode-map
                ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
                ([remap xref-find-references] . lsp-ui-peek-find-references))
    :hook (lsp-mode . lsp-ui-mode))

  (use-package company-lsp
    :after company
    :defines company-backends))

(provide 'core-lsp)

;;; core-lsp.el ends here
