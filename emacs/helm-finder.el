;;;; helm

(use-package helm
  :ensure t
  :config
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (global-set-key (kbd "C-x b") 'helm-mini))

(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode)))
            (display-line-numbers-mode 0))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix " |")
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))


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

