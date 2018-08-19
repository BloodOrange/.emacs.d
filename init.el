;; init.el -*- lexical-binding: t; -*-

;; Tweak for windows
(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0))

(setq sql-mysql-options '("-C" "-f" "-t" "-n"))

;; Désactive la vérification automatique des xml
(setq rng-nxml-auto-validate-flag nil)

;; Optimise le déplacement du cursor
(setq auto-window-vscroll nil)

(require 'core (concat user-emacs-directory "lisp/core"))
(require 'core-ui)
(require 'core-ivy)
(require 'core-company)
(require 'core-snippet)
(require 'core-project)
(require 'core-vcs)
(require 'core-flycheck)
(require 'core-lsp)

(require 'lang-org)
(require 'lang-web)
(require 'lang-go)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet-snippets go-projectile projectile-ripgrep deadgrep doom-modeline company-lsp lsp-ui flycheck-pos-tip neotree company-statistics company-quickhelp company ivy-xref ivy-rich smex counsel-projectile use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
