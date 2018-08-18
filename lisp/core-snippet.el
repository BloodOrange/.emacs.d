;;; core-snippet.el -*- lexical-binding: t; -*-

(use-package yasnippet
  :diminish yas-minor-mode
  :commands (yas-minor-mode
             yas-minor-mode-on
             yas-expand
             yas-insert-snippet
             yas-new-snippet
             yas-visit-snippet-file)
  :hook (prog-mode . yas-global-mode)
  :config

  ;; Fix un problème avec smartparens
  (advice-add 'yas-expand :before 'sp-remove-active-pair-overlay)
  (use-package yasnippet-snippets))

(provide 'core-snippet)

;;; core-snippet.el ends here
