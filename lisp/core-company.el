;;; core-company.el -*- lexical-binding: t; -*-

(use-package company
  :diminish company-mode
  :commands (company-mode global-company-mode company-complete
                          company-complete-common company-manuel-begin company-grab-line)
  :defines (company-dabbrev-ignore-case company-dabbrev-downcase)
  :bind (("C-," . company-complete)
         ("C-c /" . company-files)
         :map company-active-map
         ;; On filtre plutôt qu'une recherche
         ("C-s" . company-filter-candidates))
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2
        company-tooltip-limit 10
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case nil
        company-dabbrev-code-other-buffers t
        company-tooltip-align-annotations t
        company-require-match 'never
        company-transformers '(company-sort-by-occurrence)
        company-statistics-file (concat cactus-temp-dir "/company-statistics-cache.el"))

  (require 'company-capf)
  (require 'company-yasnippet)

  (use-package company-quickhelp
    :hook (global-company-mode . company-quickhelp-mode)
    :bind (:map company-active-map
                ("C-h" . company-quickhelp-manual-begin))
    :config
    (setq company-quickhelp-delay nil))

  (use-package company-statistics
    :hook (global-company-mode . company-statistics-mode)))

(provide 'core-company)

;;; core-company.el ends here
