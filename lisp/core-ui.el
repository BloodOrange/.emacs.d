;;; core-ui.el -*- lexical-binding: t; -*-

;; Paramètres globaux
(setq-default
 ;; Désactivation de l'affichage bidirectionnel (perf.)
 bidi-display-reordering nil
 ;; Pas de son ou de clignotement
 ring-bell-function	#'ignore
 visible-bell		nil
 redisplay-dont-pause t
 inhibit-startup-screen t

 ;; Configuration des bordures
 fringes-outside-margins t
 ;; Supprime la flèche de continuation de la bordure droite
 fringe-indicator-alist (delq (assq 'continuation fringe-indicator-alist)
                              fringe-indicator-alist)

 ;; Minibuffer resizing
 resize-mini-windows 'grow-only
 max-mini-window-height 0.3

 c-default-style    "linux"
 c-basic-offset     4
 tab-width          4
 truncate-lines     t
 truncate-partial-width-windows 50
 indent-tabs-mode   nil)

(fset #'yes-or-no-p #'y-or-n-p)

;; Taille des bordures
(fringe-mode 4)
(push `(left-fringe  . ,4) default-frame-alist)
(push `(right-fringe . ,4) default-frame-alist)

;; Pas de menu, toolbar, scrollbar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Cursor en barre
(setq-default cursor-type 'bar)

;; Change la police
(setq cactus-font (font-spec :family "Iosevka" :size 16 :antialias t))
(set-frame-font cactus-font t)
(set-face-attribute 'default t :font cactus-font)

;; Subword
(global-subword-mode 1)

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

;; Affichage le nom de la fonction courante dans la modeline
;; Inutile avec doom-modeline
; (which-function-mode)

;; Chargement du thème doom et du doom-modeline
(use-package doom-modeline
  :hook (after-init . doom-modeline-init)
  :config
  (setq doom-modeline-bar-width 4))
;  :init
;  (setq doom-modeline-buffer-file-name-style 'relative-from-project))

(use-package doom-themes
  :init
  (load-theme 'doom-one-light t)
  :config
  (doom-themes-org-config)
  (doom-themes-neotree-config)

  (use-package solaire-mode
    :hook ((change-major-mode after-revert ediff-prepare-buffer) . turn-on-solaire-mode)
    :config
    (add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)
    (solaire-mode-swap-bg)))

;; Smartparen
(use-package smartparens
  :hook (after-init . smartparens-global-mode)
  :config
  (require 'smartparens-config)

  (setq sp-highlight-pair-overlay nil
        sp-cancel-autoskip-on-backward-movement nil
        sp-show-pair-delay 0
        sp-max-pair-length 3)

  (sp-local-pair '(xml-mode nxml-mode php-mode) "<!--" "-->"
                 :post-handlers '(("| " "SPC"))))

(use-package paren
  :ensure nil
  :hook (after-init . show-paren-mode)
  :config
  (setq show-paren-when-point-inside-paren t
        show-paren-when-point-in-periphery t))

(use-package rainbow-delimiters
  :commands rainbow-delimiters-mode
  :config (setq rainbow-delimiters-max-face-count 3)
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; Highlight nombres, indent, ...
(use-package highlight-numbers
  :commands (highlight-numbers-mode)
  :hook (prog-mode . highlight-numbers-mode))

;; Numérotation des lignes
(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode))

;; undo-tree
(use-package undo-tree
  :hook (after-init . global-undo-tree-mode)
  :diminish undo-tree-mode
  :config
  (setq undo-tree-auto-save-history nil))

;; avy
(use-package avy
  :commands (avy-goto-char avy-goto-line)
  :bind (("M-s M-s" . avy-goto-char)
         ("M-g M-g" . avy-goto-line))
  :config
  (setq avy-all-windows nil
        avy-background t))

;; expand-region
(use-package expand-region
  :bind ("C-=" . er/expand-region))

;; multiple-cursor
(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<". mc/mark-previous-like-this)
         ("C-c C-<". mc/mark-all-like-this)
         ("C-S-<mouse-1>" . mc/add-cursor-on-click)))

;; Meilleur remplacement
;; Visual-regexp ??
;; Anzu intégration dans doom-modeline
(use-package anzu
  :diminish anzu-mode
  :bind (([remap query-replace] . anzu-query-replace-regexp)
         ([remap query-replace-regexp] . anzu-query-replace-regexp)
         :map isearch-mode-map
         ([remap isearch-query-replace] . anzu-isearch-query-replace-regexp)
         ([remap isearch-query-replace-regexp] . anzu-isearch-query-replace-regexp))
  :hook (after-init . global-anzu-mode))

;; Ace-window
(use-package ace-window
  :commands ace-window
  :bind ("M-ù" . ace-window)
  :config (setq aw-keys '(?q ?s ?d ?f ?g ?h ?j ?k ?l ?m)
                aw-scope 'frame
                aw-background t))

;; Whichkey
(use-package which-key
  :hook (after-init . which-key-mode))

;; todo highlight
(use-package hl-todo
  :hook (after-init . global-hl-todo-mode)
  :config
  (setq hl-todo-keyword-faces
        `(("TODO"  . ,(face-foreground 'warning))
          ("FIXME" . ,(face-foreground 'error))
          ("NOTE"  . ,(face-foreground 'success)))))

;; Flash la ligne courante
(use-package nav-flash
  :defines compilation-highlight-overlay
  :functions windmove-do-window-select
  :hook ((imenu-after-jump switch-window-finish) . nav-flash-show))

(provide 'core-ui)

;;; core-ui.el ends here
