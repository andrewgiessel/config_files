;;; mac --- Summary
;;; Commentary:
;;; Code:

;; Treat command as super and option as meta
(setq mac-command-key-is-meta nil
      mac-command-modifier 'super
      mac-option-key-is-meta t
      mac-option-modifier 'meta)

;; make fonts look better
(setq mac-allow-anti-aliasing t)
;;(mac-auto-operator-composition-mode)

;; delete files by moving them to the trash
(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash")

;; Keybindings
(global-set-key (kbd "<H-backspace>") 'delete-forward-char) ;; Make forward delete work
(global-set-key (kbd "s-=") 'text-scale-adjust)
(global-set-key (kbd "s--") 'text-scale-adjust)
(global-set-key (kbd "s-0") 'text-scale-adjust)
(global-set-key (kbd "s-q") 'save-buffers-kill-terminal)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-k") 'kill-this-buffer)
(global-set-key (kbd "s-W") 'delete-window)
(global-set-key (kbd "s-w") 'delete-frame)
(global-set-key (kbd "s-n") 'make-frame)
(global-set-key (kbd "s-z") 'undo-tree-undo)
(global-set-key (kbd "s-Z") 'undo-tree-redo)
(global-set-key (kbd "s-m") 'suspend-frame)
(global-set-key (kbd "s-g") 'magit-status)
(global-set-key (kbd "s-l") 'goto-line)
(global-set-key (kbd "s-s")
		(lambda ()
		  (interactive)
		  (call-interactively (key-binding "\C-x\C-s"))))
(global-set-key (kbd "s-F") 'toggle-frame-fullscreen)

(provide 'mac)
;;; mac.el ends here
