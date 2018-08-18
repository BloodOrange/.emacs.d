;;; core.el -*- lexical-binding: t; -*-

(defconst emacs-start-time (current-time))
(add-hook 'emacs-startup-hook
          (lambda ()
            "Affiche le temps de chargement"
            (message (format "Loaded in %.3fs"
                             (float-time (time-subtract after-init-time emacs-start-time))))))

(setq cactus-temp-dir (expand-file-name "cache" user-emacs-directory))
;; Doit être setter au plus tôt
(setq projectile-known-projects-file (concat cactus-temp-dir "/projectile-bookmarks.eld"))

;; Utf-8
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system			'utf-8)
(set-terminal-coding-system		'utf-8)
(set-keyboard-coding-system		'utf-8)
(set-selection-coding-system		'utf-8)
(setq locale-coding-system		'utf-8)
(setq-default buffer-file-coding-system 'utf-8)

;; Hack démarrage rapide
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq gc-cons-threshold 40000000
      gc-cons-percentage 0.6
      file-name-handler-alist nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            "Restore default values after init."
            (setq file-name-handler-alist default-file-name-handler-alist
                  gc-cons-threshold 800000
                  gc-cons-percentage 0.1)
            ))

(setq byte-compile-warnings nil
      compilation-always-kill t
      compilation-ask-about-save nil
      compilation-scroll-output t
      ediff-window-setup-function 'ediff-setup-windows-plain
      bookmark-save-flag t
      bookmark-default-file (concat cactus-temp-dir "/bookmarks")
      ;; Désactive les backups
      history-length 1000
      vc-make-backup-files nil
      auto-save-default nil
      auto-save-list-file-prefix nil
      auto-save-list-file-name (concat cactus-temp-dir "/autosave")
      make-backup-files nil
      create-lockfiles nil
      backup-directory-alist `((".*" . ,(concat cactus-temp-dir "/backup/")))
      ;; Sauvegarde de l'historique undo
      undo-tree-auto-save-history nil
      undo-tree-history-directory-alist `(("." . ,(concat cactus-temp-dir "/undo/"))))

;; Chargement du répertoire de conf
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Initialisation des paquets
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))
(package-initialize)

(defvar use-package-always-ensure t)
(defvar use-package-always-defer t)
(defvar use-package-expand-minimally t)
(defvar use-package-enable-imenu-support t)

(unless (require 'use-package nil t)
  (package-refresh-contents)
  (package-install 'use-package)
  (require 'use-package))



;; Historique
;; Sauvegarde la position du cursors
(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode)
  :init
  (setq-default
   save-place-file (concat cactus-temp-dir "/saveplace")))

;; Sauvegarde de l'historique
(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :init
  (setq savehist-file (concat cactus-temp-dir "/savehist")
        savehist-save-minibuffer-history t
        savehist-additional-variables
        '(kill-ring search-ring regexp-search-ring)))

;; Liste des fichiers récemments ouverts
(require 'recentf)
(setq recentf-save-file (concat cactus-temp-dir "/recentf")
      recentf-exclude '("/tmp/" "/ssh:" ".cache")
      recentf-max-menu-items 0
      recentf-max-saved-items 250
      recentf-auto-cleanup 600)
(recentf-mode t)

(use-package recentf
  :disabled t
  :ensure nil
  :init (recentf-mode t)
  (setq recentf-save-file (concat cactus-temp-dir "/recentf")
        recentf-exclude '("/tmp/" "/ssh:" ".cache")
        recentf-max-menu-items 0
        recentf-max-saved-items 250
        recentf-auto-cleanup 600))

;; eshell
(setq eshell-directory-name (concat cactus-temp-dir "/eshell")
      eshell-aliases-file (concat cactus-temp-dir "/eshell-aliases"))

;; Start emacs-server
(use-package server
  :ensure nil
  :hook (after-init . server-mode))

(provide 'core)

;;; core.el ends here
