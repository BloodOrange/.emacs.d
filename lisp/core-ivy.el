;;; core-ivy.el -*- lexical-binding: t; -*-

(provide 'core-ivy)

(use-package counsel
  :diminish ivy-mode counsel-mode
  :defines (projectile-completion-system magit-completing-read-function)
  :bind (("C-c h s" . swiper)
	     ("C-c C-r" . ivy-resume)
         ("C-c h i" . 'counsel-imenu))
  :hook ((after-init . ivy-mode)
	     (ivy-mode . counsel-mode))
  :config
  (setq enable-recursive-minibuffers t
	    ivy-use-selectable-prompt t
        ivy-use-virtual-buffers t
	    ivy-height 12
	    ivy-count-format "(%d/%d) "
        ivy-on-del-error-function nil
	    ivy-format-function 'ivy-format-function-arrow)

  ;; Integration avec projectile
  (with-eval-after-load 'projectile
    (setq projectile-completion-system 'ivy))

  (use-package counsel-projectile
    :init (counsel-projectile-mode))

  ;; Integration avec magit
  (with-eval-after-load 'magit
    (setq magit-completing-read-function 'ivy-completing-read))

  ;; M-x amélioré
  (use-package smex
	:config
	(setq smex-save-file (concat cactus-temp-dir "/smex-items")))

  ;; Affichage plus sympa
  (use-package ivy-rich
    :init (ivy-rich-mode 1))

  ;; xref avec ivy
  (use-package ivy-xref
    :init (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))
  )
;;; core-ivy.el ends here
