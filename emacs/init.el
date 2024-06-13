(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(setq make-backup-files nil)

(load-theme 'darktooth t)
(set-background-color '"gray13")
(global-set-key (kbd "C-x w") 'delete-frame)
(global-set-key (kbd "s-<return>") 'toggle-frame-fullscreen)

(require 'helm) ;; finder
(require 'helm-projectile)
(require 'helm-swoop)
(require 'auto-complete)
(require 'hydra)

;; helm key bindings
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-display-line-numbers-mode 1)
(global-set-key (kbd "C-x C-b") 'helm-projectile-switch-to-buffer)

(global-set-key (kbd "s->") #'other-window)
(global-set-key (kbd "s-'") #'other-window)
(global-set-key (kbd "s-<") #'prev-window)

(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

(setq display-line-numbers 'relative)
(scroll-bar-mode -1)
;; alias for yes and no
(defalias 'yes-or-no-p 'y-or-n-p)
(setq echo-keystrokes 0.1)

;; projectile

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

(projectile-global-mode)
(helm-projectile-toggle 1)

(setq projectile-project-search-path '("~/projects/" "~/my-space/"))
(setq projectile-indexing-method 'alien)
(setq projectile-switch-project-action 'helm-projectile)

(setq projectile-enable-caching t)

(global-set-key (kbd "C-c p") 'hydra-projectile/body)

(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown$" . markdown-mode))

(add-to-list 'auto-mode-alist '("^\\*.org\\*$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(add-hook 'org-mode-hook 'org-bullets-mode)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
;; git 
;; (global-git-gutter+-mode t)
;; (setq git-gutter+-disabled-modes '(asm-mode image-mode))
;; (set-face-background 'git-gutter+-modified "purple") ;; background color
;; (set-face-foreground 'git-gutter+-added "green")
;; (set-face-foreground 'git-gutter+-deleted "red")


;; (defhydra hydra-magit (:color blue)
;;   "
;;   ^
;;   ^Git  ^             ^Do^
;;   ^─────^─────────────^──^─────────────
;;   _n_ Next Hunk       _p_ Previous Hunk
;;   _w_ Show Hunk       _s_ Stage Hunk
;;   _q_ Quit            _b_ Blame
;;   _c_ Clone           _S_ Status
;;   _i_ Init            _l_ Git Log for file
;;   "
;;   ("q" nil)
;;   ("n" git-gutter+-next-hunk)
;;   ("p" git-gutter+-previous-hunk)
;;   ("w" git-gutter+-show-hunk)
;;   ("s" git-gutter+-stage-hunks)
;;   ("b" magit-blame)
;;   ("c" magit-clone)
;;   ("i" magit-init)
;;   ("S" magit-status)
;;   ("l" magit-log-buffer-file))

;; (global-set-key (kbd "C-c g") 'magit-status)
;; (global-set-key (kbd "C-c m") 'hydra-magit/body)

(message "Hey there!")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yaml-mode with-editor transient simple-httpd org-bullets markdown-mode hydra helm-swoop helm-projectile go-complete darktooth-theme company auto-complete)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
