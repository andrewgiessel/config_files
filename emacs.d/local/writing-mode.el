;;; writing-mode --- Summary

;;; Commentary:
;;; Get serious about writing, Giessel.

;;; Code:

(require 'use-package)
(require 'wc-mode)
(use-package olivetti
  :config
  (require 'olivetti))

(defvar writing-mode nil
  "A simple mode, for focused writing.")
(make-variable-buffer-local 'writing-mode)

(defun writing-mode (&optional arg)
  "Toggle writing-mode."
  (interactive "P")
  (setq writing-mode
	(if (null arg)
	    (not writing-mode)
	  (> (prefix-numeric-value arg) 0)))

  (if writing-mode
            (progn ;;; turn it on
	      (setq line-spacing 0.1)
	      (text-scale-set 2)
	      (olivetti-mode 1)
	      (variable-pitch-mode 1)
	      (display-line-numbers-mode 0)
	      (setq cursor-type 'bar)
	      (flyspell-mode 1)
	      (wc-mode 1))
      (progn ;; turn it off
	(setq line-spacing 0)
	(text-scale-set 0)
	;; currently don't know how to save/restore mode line
	;; will do that soon, but whatever
	(olivetti-mode 0)
	(variable-pitch-mode nil)
	(display-line-numbers-mode 1)
	(setq cursor-type 'box)
	(flyspell-mode 1)
	(wc-mode 0))))

(provide 'writing-mode)
;;; writing-mode.el ends here
