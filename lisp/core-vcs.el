;;; core-vcs.el -*- lexical-binding: t; -*-

(use-package gitconfig-mode
  :ensure t
  :mode ("/\\.?git/?config$" "/\\.gitmodules$")
  :init (add-hook 'gitconfig-mode-hook 'flyspell-mode))

(use-package gitignore-mode
  :ensure t
  :mode ("/\\.gitignore$"
         "/\\.git/info/exclude$"
         "/git/ignore$"))

(use-package git-gutter
  :ensure t
  :commands (git-gutter-mode git-gutter:next-hunk git-gutter:previous-hunk
             git-gutter:popup-hunk git-gutter:stage-hunk git-gutter:revert-hunk)
  :hook ((text-mode-hook . git-gutter-mode)
         (prog-mode-hook . git-gutter-mode)
         (conf-mode-hook . git-gutter-mode))

  :config
  (use-package git-gutter-fringe :ensure t)

  ;; colored fringe "bars"
  (define-fringe-bitmap 'git-gutter-fr:added
    [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224]
    nil nil 'center)
  (define-fringe-bitmap 'git-gutter-fr:modified
    [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224]
    nil nil 'center)
  (define-fringe-bitmap 'git-gutter-fr:deleted
    [0 0 0 0 0 0 0 0 0 0 0 0 0 128 192 224 240 248]
    nil nil 'center)

  ;; Refreshing git-gutter
  (add-hook 'focus-in-hook 'git-gutter:update-all-windows))

(use-package git-messenger
  :ensure t
  :commands git-messenger:popup-message
  :init (defvar git-messenger-map (make-sparse-keymap))
  :config
  ;;(def-popup! "*git-messenger*" :align left :size 55 :select t)
  (setq git-messenger:show-detail t))

(use-package magit
  :ensure t
  :bind ("C-c g" . magit-status)
  :commands (magit-status))

(use-package git-timemachine
  :ensure t)

(provide 'core-vcs)

;;; core-vcs.el ends here
