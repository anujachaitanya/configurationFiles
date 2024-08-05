
;;;; lsp-mode
(use-package lsp-mode
  :ensure t
  :bind (:map lsp-mode-map
	      ("C-c d" . lsp-describe-thing-at-point)
	      ("C-c a" . lsp-execute-code-action)
        ("C-c r" . 'lsp-find-references)
        ("C-<return>" . 'lsp-find-definition)
        ("C-c i" . lsp-format-region)
        ("C-c f" . lsp-format-buffer))
  :bind-keymap ("C-c l" . lsp-command-map)
  :config
  (lsp-enable-which-key-integration t)
  )

;;;; company

(use-package company
  :ensure t
  :hook ((emacs-lisp-mode . (lambda ()
			      (setq-local company-backends '(company-elisp))))
	 (emacs-lisp-mode . company-mode))
  :config
  (company-keymap--unbind-quick-access company-active-map)
  (define-key company-active-map (kbd "<tab>") 'company-complete-selection)
  (define-key company-active-map (kbd "<return>") nil)
  (company-tng-configure-default)
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1))

;;;; Go

(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
	 (go-mode . company-mode))
  :bind (:map go-mode-map
	      ("<f6>"  . gofmt)
	      ("C-c 6" . gofmt))
  :config
  (require 'lsp-go)
  ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
  (setq lsp-go-analyses
	'((fieldalignment . t)
	  (nilness        . t)
	  (unusedwrite    . t)
	  (unusedparams   . t)))
  ;; GOPATH/bin
  (add-to-list 'exec-path "~/go/bin")
  (setq gofmt-command "goimports"))


;;;; Java

(use-package lsp-java
  :ensure t
  :init
  (setq lsp-java-inhibit-message nil)
  (setq lsp-java-java-path "/usr/local/opt/openjdk@17/bin/java")
  :hook ((java-mode . lsp-deferred)
	       (java-mode . company-mode))
  :config (add-hook 'java-mode-hook 'lsp))

;;;; javascript

(use-package js2-mode
  :ensure t
  :hook(
        (js2-mode . lsp-deferred)
        (js2-mode . company-mode))
  :config
  ;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (setq js-indent-level 2))

;; (use-package yaml-mode
;;   :ensure t
;;   :hook(
;;         (yaml-mode . lsp-deferred)
;;         (yaml-mode . company-mode)))

(use-package typescript-mode
  :ensure t
  :mode ("\\.ts\\'") 
  :hook
  (typescript-mode . lsp-deferred)
  (typescript-mode . company-mode)
  :config
  (setq typescript-indent-level 2))
