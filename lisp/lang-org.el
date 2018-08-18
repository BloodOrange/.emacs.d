;;; lang-org.el -*- lexical-binding: t; -*-

(use-package org
  :ensure nil
  :commands org-try-structure-completion
  :bind (("C-c a" . org-agenda)
         ("C-c b" . org-switchb))
  :hook ((org-mode . org-indent-mode)
         (org-indent-mode . (lambda() (diminish 'org-indent-mode))))
  :config
  (setq org-log-done 'time
        org-src-fontify-natively t))

(provide 'lang-org)

;;; lang-org.el ends here
