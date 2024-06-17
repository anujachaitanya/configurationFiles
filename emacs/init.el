(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(setq make-backup-files nil)

(load-theme 'darktooth t)
(set-background-color '"gray13")
(set-face-attribute 'default nil :height 140)

;;;; window shortcuts
(global-set-key (kbd "C-x w") 'delete-frame)
(global-set-key (kbd "s-<return>") 'toggle-frame-fullscreen)
(global-set-key (kbd "s->") #'other-window)
(global-set-key (kbd "s-'") #'other-window)
(global-set-key (kbd "s-<") #'prev-window)


(use-package helm-swoop :ensure t)
(use-package auto-complete :ensure t)
(use-package hydra :ensure t)


(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

;;;; line number and scroll bars
(global-display-line-numbers-mode 1)
;; (setq display-line-numbers 'relative)
(scroll-bar-mode -1)


;;;; alias for yes and no

(defalias 'yes-or-no-p 'y-or-n-p)
(setq echo-keystrokes 0.1)

;; ;; which-key
;; (use-package which-key
;;   :ensure t
;;   :config
;;   (which-key-mode))

;;;; helm
(use-package helm
  :ensure t
  :config
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (global-set-key (kbd "C-x b") 'helm-mini))

;;;; finder
(use-package helm-projectile
  :ensure t
  :config
  (global-set-key (kbd "C-x C-b") 'helm-projectile-switch-to-buffer)
  (projectile-global-mode)
  (helm-projectile-toggle 1)
  (setq projectile-project-search-path '("~/projects/" "~/my-space/"))
  (setq projectile-indexing-method 'alien)
  (setq projectile-switch-project-action 'helm-projectile)
  (setq projectile-enable-caching t))

;;;; Modes

(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("^\\*.org\\*$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(add-hook 'org-mode-hook 'org-bullets-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;;;; hydra projectile

(defhydra hydra-projectile (:color blue)
  "
^
^Projectile^        ^Buffers^           ^Find^              ^Search^
^──────────^────────^───────^───────────^────^──────────────^──────^────────────
_q_ quit            _b_ list            _d_ directory       _r_ replace
_i_ reset cache     _K_ kill all        _D_ root            _R_ regexp replace
^^                  _S_ save all        _f_ file            _s_ ag
^^                  ^^                  _p_ project         ^^
^^                  ^^                  _F_ file-window     ^^
"
  ("q" nil)
  ("b" helm-projectile-switch-to-buffer)
  ("d" helm-projectile-find-dir)
  ("D" projectile-dired)
  ("f" helm-projectile)
  ("F" projectile-find-file-other-window)
  ("i" projectile-invalidate-cache :color red)
  ("K" projectile-kill-buffers)
  ("p" helm-projectile-switch-project)
  ("r" projectile-replace)
  ("R" projectile-replace-regexp)
  ("s" helm-projectile-ag)
  ("S" projectile-save-project-buffers))

(global-set-key (kbd "C-c p") 'hydra-projectile/body)


;;;; git

(global-git-gutter+-mode t)
(setq git-gutter+-disabled-modes '(asm-mode image-mode))
(set-face-background 'git-gutter+-modified "purple") ;; background color
(set-face-foreground 'git-gutter+-added "green")
(set-face-foreground 'git-gutter+-deleted "red")


(defhydra hydra-magit (:color blue)
  "
  ^
  ^Git  ^             ^Do^
  ^─────^─────────────^──^─────────────
  _n_ Next Hunk       _p_ Previous Hunk
  _w_ Show Hunk       _s_ Stage Hunk
  _q_ Quit            _b_ Blame
  _c_ Clone           _S_ Status
  _i_ Init            _l_ Git Log for file
  "
  ("q" nil)
  ("n" git-gutter+-next-hunk)
  ("p" git-gutter+-previous-hunk)
  ("w" git-gutter+-show-hunk)
  ("s" git-gutter+-stage-hunks)
  ("b" magit-blame)
  ("c" magit-clone)
  ("i" magit-init)
  ("S" magit-status)
  ("l" magit-log-buffer-file))

(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-c m") 'hydra-magit/body)

;;;; lsp-mode
(use-package lsp-mode
  :ensure t
  :bind (:map lsp-mode-map
	      ("C-c d" . lsp-describe-thing-at-point)
	      ("C-c a" . lsp-execute-code-action))
  :bind-keymap ("C-c l" . lsp-command-map)
  ;; :config
  ;; (lsp-enable-which-key-integration t)
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
  (define-key company-active-map (kbd "RET") 'nil)
  (define-key company-active-map (kbd "<return>") nil)
  (company-tng-configure-default)
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1))

;;; Go
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
