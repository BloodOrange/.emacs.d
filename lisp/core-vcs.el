;;; core-vcs.el -*- lexical-binding: t; -*-

(use-package gitconfig-mode
  :mode ("/\\.?git/?config$" "/\\.gitmodules$")
  :init (add-hook 'gitconfig-mode-hook 'flyspell-mode))

(use-package gitignore-mode
  :mode ("/\\.gitignore$"
         "/\\.git/info/exclude$"
         "/git/ignore$"))

(use-package git-gutter
  :ensure git-gutter-fringe
  :commands (git-gutter-mode git-gutter:next-hunk git-gutter:previous-hunk
             git-gutter:popup-hunk git-gutter:stage-hunk git-gutter:revert-hunk)
  :hook ((text-mode . git-gutter-mode)
         (prog-mode . git-gutter-mode)
         (conf-mode . git-gutter-mode))

  :config
  (require 'git-gutter-fringe)
  ;; colored fringe "bars"
  (fringe-helper-define 'git-gutter-fr:added '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:modified '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:deleted 'bottom
    "X......."
    "XX......"
    "XXX....."
    "XXXX....")

  ;; Refreshing git-gutter
  (add-hook 'focus-in-hook 'git-gutter:update-all-windows))

(use-package git-messenger
  :commands git-messenger:popup-message
  :init (defvar git-messenger-map (make-sparse-keymap))
  :config
  ;;(def-popup! "*git-messenger*" :align left :size 55 :select t)
  (setq git-messenger:show-detail t))

(use-package magit
  :ensure t
  :bind ("C-c g" . magit-status)
  :commands (magit-status))

(use-package git-timemachine)

(provide 'core-vcs)

;;; core-vcs.el ends here
