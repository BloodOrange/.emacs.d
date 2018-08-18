;;; lang-web.el -*- lexical-binding: t; -*-

;; Javascript
(use-package js2-mode
  :defines flycheck-javascript-eslint-executable
  :mode (("\\.js\\'" . js2-mode)
         ("\\.jsx\\'" . js2-jsx-mode))
  :interpreter (("node" . js2-mode)
                ("node" . js2-jsx-mode))
  :hook ((js2-mode . js2-imenu-extras-mode)
         (js2-mode . js2-highlight-unused-variables-mode)))

;; npm i -g javascript-typescript-langserver
(use-package lsp-javascript-typescript
  :commands lsp-javascript-typescript-enable
  :hook ((typescript-mode js2-mode) . lsp-javascript-typescript-enable))

;; CSS
;; npm i -g vscode-css-languageserver-bin
(use-package css-mode
  :ensure nil
  :init (setq css-indent-offset 2))

(use-package css-eldoc
  :commands turn-on-css-eldoc
  :hook (css-mode . turn-on-css-eldoc))

;; Json
(use-package json-mode)

(use-package lsp-css
  :commands (lsp-css-enable)
  :hook (css-mode . lsp-css-enable))

;; Web
(use-package web-mode
  :defines company-backends
  :mode "\\.html$"
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2))

;; npm i -g vscode-html-languageserver-bin
(use-package lsp-html
  :commands lsp-html-enable
  :hook (html-mode . lsp-html-enable))

(provide 'lang-web)

;;; lang-web.el ends here
