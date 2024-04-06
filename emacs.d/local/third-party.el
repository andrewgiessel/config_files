;;; third-party --- Summary
;;; Commentary:

;;; Code:

;; (eval-when-compile
;;   (require 'use-package)
;;   (require 'use-package-ensure))
;; (setq use-package-always-ensure t)

(use-package dired-sidebar
  :bind (([f8] . dired-sidebar-toggle-sidebar)
	 ("s-8" . dired-sidebar-toggle-sidebar))
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
  (setq dired-sidebar-theme 'icons)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

(use-package julia-mode)

(use-package diminish)

(use-package dockerfile-mode)

(use-package docker)

(use-package awesome-tab
  :load-path "~/.emacs.d/plugins/awesome-tab/"
  :config
  (require 'awesome-tab)
  (awesome-tab-mode t))

(use-package unkillable-scratch
  :config (unkillable-scratch t))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package sane-term
  :bind (("C-x t" . sane-term)
	 ("C-x T" . sane-term-create)))

(use-package undo-tree)

(use-package dired-rainbow)
(use-package dired-hacks-utils)

(use-package rainbow-blocks)

(use-package peep-dired
  :config
  (setq peep-dired-cleanup-eagerly t)
  :defer t ;don't access `dired-mode-map' until `peep-dired' is loaded
  :bind (:map dired-mode-map
              ("P" . peep-dired)))

(use-package latex-pretty-symbols)

(use-package dashboard
    :diminish dashboard-mode
    :config
    (setq dashboard-banner-logo-title "."
	  dashboard-startup-banner "~/Dropbox/dots_and_swirls.png"
          dashboard-center-content t
	  dashboard-items '((recents  . 10)
			    (bookmarks . 10)
			    (projects . 10))
	  initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
	  dashboard-set-heading-icons t
	  dashboard-set-file-icons t)
    (dashboard-setup-startup-hook))

(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode))


(use-package paredit)
(use-package all-the-icons)

(use-package tdd
  :load-path "~/.emacs.d/plugins"
  :config
  (require 'tdd))

(use-package magit
  :defer 5
  :bind (("C-x g" . 'magit-status)
	 ("C-x C-g" . 'magit-status)))

(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/_repos/")))

;; Helm
(use-package helm-swoop)
(use-package helm-projectile
  :config
  (helm-projectile-on))

(use-package helm
  :defer 3
  :diminish ""
  :init
  (require 'projectile)
  (require 'helm-config)
  (require 'helm-projectile)
  (helm-mode 1)
  :bind   (("C-x C-f"  . helm-find-files)
	   ("C-x f"  .   helm-recentf)
	   ("C-x C-b"  . helm-buffers-list)
	   ("C-x b"    . helm-multi-files)
	   ("M-x"      . helm-M-x)
	   ("M-y"      . helm-show-kill-ring)
	   ("C-s"      . helm-swoop)
	   ("M-t"      . helm-projectile)
	   ("M-r"      . helm-projectile-grep)
	   ("C-x r b"  . helm-bookmarks)
	   ([remap find-file]      . helm-find-files)
	   ([remap occur]          . helm-occur)
	   ([remap list-buffers]   . helm-buffers-list)
	   ([remap dabbrev-expand] . helm-dabbrev)
	   :map helm-map
	   ("<tab>" . helm-execute-persistent-action)
	   ("C-i"   . helm-execute-persistent-action)
	   ("C-z"   . helm-select-action))
  :config
  (setq helm-M-x-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match t
	helm-split-window-inside-p t
	helm-scroll-amount 8
	helm-ff-file-name-history-use-recentf t
	helm-echo-input-in-header-line t
	helm-autoresize-max-height 0
	helm-autoresize-min-height 30
	helm-swoop-pre-input-function (lambda () ""))
  (helm-adaptive-mode t)
  (helm-autoresize-mode 1))

(use-package helm-tramp
  :config
  (setq tramp-default-method "ssh"
	tramp-verbose 1
	remote-file-name-inhibit-cache nil)
  (eval-after-load 'tramp '(setenv "SHELL" "/bin/bash")))

(use-package helm-flycheck
  :bind-keymap
  ("C-c ! h" . flycheck-mode-map))


;;; Org mode
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-ref
  :defer 25
  :config
  (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f")))

(use-package org
  :init
  (require 'org-bullets)
  :config
  (setq org-agenda-files '("~/Dropbox/org/"))
  (setq org-hide-emphasis-markers t
	org-support-shift-select t
	org-refile-targets '((org-agenda-files :maxlevel . 1))
	org-use-speed-commands t)
  (defvar org-capture-templates
    '(("p" "Papers"        entry (file "~/Dropbox/org/papers.org") "* %? :REF:\n%U")
      ("n" "General Notes" entry (file "~/Dropbox/org/notes.org") "* %? :NOTE: %U")
      ("m" "Meeting Notes" entry (file "~/Dropbox/org/notes.org") "* %? :MEETING: %U")
      ("s" "Seminar"       entry (file "~/Dropbox/org/notes.org") "* %? :SEMINAR: %U")
      ("t" "Todo"          entry (file+headline "~/org/tasks.org" "Tasks") "* TODO %?\n  %i\n  %a")
      ("j" "Journal"       entry (file+datetree "~/org/journal.org") "* %?\nEntered on %U\n  %i\n  %a")))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (emacs-lisp . t)))
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region
					   (match-beginning 1)
					   (match-end 1)
					   "•"))))))

  (add-hook 'org-mode-hook 'org-bullets-mode)
  :bind (("C-c l" . org-store-link)
	 ("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
	 (:map org-mode-map
               ("C-c ," . org-time-stamp-inactive)
	       ("C-<tab>" . nil)
	       ("C-S-<tab>" . nil))))

(use-package better-shell
    :ensure t
    :bind (("C-'" . better-shell-shell)
           ("C-;" . better-shell-remote-open)))

;; (use-package elpy
;;   :defer 2
;;   :init

;;   :config
;;   (elpy-enable)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))

;;   (setq python-shell-interpreter "jupyter"
;; 	python-shell-interpreter-args "console --simple-prompt"
;; 	python-shell-prompt-detect-failure-warning nil)
;;   (add-to-list 'python-shell-completion-native-disabled-interpreters "jupyter"))

(add-hook 'python-mode-hook 'hideshowvis-minor-mode)
(add-hook 'python-mode-hook 'projectile-mode)


(use-package company)
(use-package company-lsp)

(use-package git-gutter
  :config
  (diminish git-gutter-mode))

(use-package spaceline
  :config
  (spaceline-helm-mode))

(use-package spaceline-all-the-icons
  :after spaceline
  :config
  (spaceline-all-the-icons-theme)
  (spaceline-toggle-all-the-icons-git-status-on))


(use-package lsp-mode
  :hook (python-mode . lsp)
  :commands lsp
  :init
  (setq lsp-prefer-flymake nil
	lsp-auto-guess-root t
	lsp-enable-snippet nil))

;; lsp addons
(use-package lsp-ui)
(use-package company-lsp :commands company-lsp)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(add-hook 'python-mode-hook 'flycheck-mode)



(add-hook 'emacs-lisp-mode-hook 'hideshowvis-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'projectile-mode)

(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\>")
      (company-complete)
    (indent-for-tab-command)))

(add-hook 'after-init-hook 'global-company-mode)

;; Flycheck not flymake
(use-package flycheck
  :config
  (global-flycheck-mode))

(provide 'third-party)
;;; third-party.el ends here
