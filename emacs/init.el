(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(use-package helm-swoop :ensure t)
(use-package auto-complete :ensure t)
(use-package hydra :ensure t)
;; (use-package mode-line-bell
;;   :ensure t
;;   :init (mode-line-bell-mode))

(setq make-backup-files nil)
(setq desktop-buffers-not-to-save "^$")

;;;; Global setup

(setq-default display-line-numbers-width 2
              display-line-numbers-widen t
              tab-width 2
              indent-tabs-mode nil)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (load-theme 'sanityinc-tomorrow-bright t)
  (set-background-color '"gray13"))

(set-face-attribute 'default nil :height 140)

;;;; window shortcuts

(defun prev-window ()
  (interactive)
  (other-window -1))

(global-set-key (kbd "C-x w") 'delete-frame)
(global-set-key (kbd "s-<return>") 'toggle-frame-fullscreen)
(global-set-key (kbd "s->") #'other-window)
(global-set-key (kbd "s-'") #'other-window)
(global-set-key (kbd "s-<") #'prev-window)

(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

;;;; custom setup

(defun my/launch-process (name buffer-name process &rest args) 
(apply #'start-process name buffer-name process args)
(with-current-buffer buffer-name
        (local-set-key (kbd "C-c C-c") (lambda () (interactive) (kill-process))))
)

;;;; line number and scroll bars

(defun display-line-numbers-disable-hook ()
 "Disable display-line-numbers locally."
 (display-line-numbers-mode 0))

(add-hook 'maggit-mode-hook 'display-line-numbers-disable-hook)
(add-hook 'dashboard-mode-hook 'display-line-numbers-disable-hook)

(global-set-key (kbd "C-;") 'goto-line)

(global-display-line-numbers-mode 1)
;; (setq display-line-numbers 'relative)
(scroll-bar-mode -1)

;;;; Basic text editing

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  (pop kill-ring)
  (move-beginning-of-line 1))

(defun my/move-line (dir)
  (interactive)
  (next-line)
  (transpose-lines dir)
  (previous-line))

(global-set-key (kbd "M-<up>") (lambda () (interactive) (my/move-line -1)))
(global-set-key (kbd "M-<down>") (lambda () (interactive) (my/move-line 1))) 
(global-set-key (kbd "C-c d") 'duplicate-line)

;;;; alias for yes and no

(defalias 'yes-or-no-p 'y-or-n-p)
(setq echo-keystrokes 0.1)

;;;; which-key

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

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
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

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

;;;; eshell

(global-set-key (kbd "C-`") (lambda () (interactive) (eshell 'N)))

;;;; lsp-mode
(use-package lsp-mode
  :ensure t
  :bind (:map lsp-mode-map
	      ("C-c d" . lsp-describe-thing-at-point)
	      ("C-c a" . lsp-execute-code-action)
        ("C-c r" . 'lsp-find-references)
        ("C-<return>" . 'lsp-find-definition))
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
  (define-key company-active-map (kbd "RET") 'nil)
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
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (setq js-indent-level 2))

(use-package yaml-mode
  :ensure t
  :hook(
        (yaml-mode . lsp-deferred)
        (yaml-mode . company-mode)))

;; (use-package typescript-mode
;;   :ensure t
;;   :mode ("\\.ts\\'" "\\.js\\'") 
;;   :hook
;;   (typescript-mode . lsp-deferred)
;;   (typescript-mode . company-mode)
;;   :config
;;   (setq typescript-indent-level 2))


;;;; ORG-Agenda

(add-hook 'org-mode-hook 'org-bullets-mode)
(setq org-agenda-files
      (list "~/my-space/Notes/Todo.org"))
(global-set-key (kbd "C-c a") 'org-agenda)

;;;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner "~/.emacs.d/fox.png")
  (setq dashboard-banner-logo-title "Hey there!")
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents   . 5)
                        (projects  . 5)
                        (agenda    . 5))))

(message "Hey there!")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("c71fd8fbda070ff5462e052d8be87423e50d0f437fbc359a5c732f4a4c535c43" default))
 '(package-selected-packages
   '(mode-line-bell mode-line-bell-mode js2-mode dap-chrome yaml-mode which-key simple-httpd shrink-path org-bullets nerd-icons monokai-theme magit lsp-java helm-swoop helm-projectile helm-ag goto-chg go-complete git-gutter+ dashboard darktooth-theme company color-theme-sanityinc-tomorrow auto-complete)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
