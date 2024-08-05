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
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

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

