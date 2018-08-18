;;; core-project.el -*- lexical-binding: t; -*-

;; dired configuration
(setq dired-recursive-copies 'always
      dired-recusive-deletes 'always
      ;; Auto refresh quietly dired
      ;; global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)

(put 'dired-find-alternate-file 'disabled nil)

(use-package neotree
  :commands (neotree-show
             neotree-hide
             neotree-toggle
             neotree-dir
             neotree-find
             neo-global--with-buffer
             neo-global--window-exists-p)
  :bind (("C-\\" . neotree-projectile-action)
         ("<f12>" . neotree-projectile-action))
  :config
  (setq neo-create-file-auto-open t
        neo-auto-indent-point nil
        neo-mode-line-type 'none
        neo-persist-show nil
        neo-window-width 25
        neo-show-updir-line nil
        neo-theme 'nerd ; fallback
        neo-banner-message nil
        ; neo-vc-integration t
        neo-hidden-regexp-list
        '(;; vcs folders
          "^\\.\\(git\\|hg\\|svn\\)$"
          ;; compiled files
          "\\.\\(pyc\\|o\\|elc\\|lock\\)$"
          ;; generated files, caches ro local pkgs
          "^\\(node_modules\\|vendor\\)$"
          "~$"
          "^#.*#$")))

(use-package projectile
  :diminish projectile-mode
  :hook (after-init . projectile-global-mode)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map))
  :init
  (setq projectile-cache-file (concat cactus-temp-dir "/projectile.cache"))
  :config
  (setq projectile-require-project-root nil
        projectile-project-root-files '(".git" ".hg" ".svn" ".project"))
  (when (eq system-type 'windows-nt)
    (setq projectile-enable-caching nil
          projectile-indexing-method 'alien
          ;; Submodule lent sous windows
          projectile-git-submodule-command "")))

(provide 'core-project)

;;; core-project.el ends here
