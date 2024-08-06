(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
;; (package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(load-file "~/configurationFiles/emacs/lsp.el")
(load-file "~/configurationFiles/emacs/helm-finder.el")

(use-package helm-swoop :ensure t)
(use-package auto-complete :ensure t)
(use-package hydra :ensure t)
(use-package magit :ensure t)
(use-package git-gutter+ :ensure t)


(setq make-backup-files nil)
(setq desktop-buffers-not-to-save "^$")

;;;; Global setup

(setq-default display-line-numbers-width 2
              display-line-numbers-widen t
              tab-width 2
              indent-tabs-mode nil)

;; (use-package color-theme-sanityinc-tomorrow
;;   :ensure t
;;   :init
;;   (load-theme 'sanityinc-tomorrow-bright t)
;;   (set-background-color '"gray13"))

(use-package doom-themes
  :ensure t
  :init
  (load-theme 'doom-tomorrow-night t))


(set-face-attribute 'default nil :height 142)

(use-package mode-line-bell
  :ensure t
  :init (mode-line-bell-mode))

;;;; window shortcuts

(defun prev-window ()
  (interactive)
  (other-window -1))

(global-set-key (kbd "C-x w") 'delete-frame)
(global-set-key (kbd "s-<return>") 'toggle-frame-fullscreen)
(global-set-key (kbd "s-]") #'other-window)
(global-set-key (kbd "s-'") #'other-window)
(global-set-key (kbd "s-[") #'prev-window)
(global-set-key (kbd "C-<return>") #'delete-other-windows)


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
  (setq dashboard-startup-banner "~/configurationFiles/emacs/fox.png")
  (setq dashboard-banner-logo-title "Hey there!")
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents   . 5)
                        (projects  . 5)
                        ;; (agenda    . 5)
                        (bookmarks . 5))))

(message "Hey there!")

