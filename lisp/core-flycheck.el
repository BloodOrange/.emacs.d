;;; core-flycheck.el -*- lexical-binding: t; -*-

(use-package flycheck
  :diminish flycheck-mode
  :commands (flycheck-mode flycheck-list-errors flycheck-buffer)
  :hook (after-init . global-flycheck-mode)
  :config
  (setq flycheck-indication-mode 'right-fringe
        ;; Vérification à la sauvegarde
        flycheck-check-syntax-automatically '(save mode-enabled)
        flycheck-display-errors-delay 0.5)

  (use-package flycheck-pos-tip
    :hook (global-flycheck-mode . flycheck-pos-tip-mode)
    :config (setq flycheck-pos-tip-timeout 30))

  (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
    [0 0 0 0 0 4 12 28 60 124 252 124 60 28 12 4 0 0 0 0]))

(provide 'core-flycheck)

;;; core-flycheck.el ends here
