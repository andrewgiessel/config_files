;;; giessel_ext --- My Explorations in Emacs Extensions
;;; Commentary:
;;;

;;; Code:

(defalias 'scroll-ahead 'scroll-up)
(defalias 'scroll-behind 'scroll-down)

(defun scroll-one-line-ahead ()
  "Scroll ahead one line."
  (interactive)
  (scroll-ahead 1))

(defun scroll-one-line-behind ()
  "Scroll behind one line."
  (interactive)
  (scroll-behind 1))

(defun scroll-n-lines-ahead (&optional n)
  "Scroll N lines ahead."
  (interactive "P")
  (scroll-ahead (prefix-numeric-value n)))

(defun scroll-n-lines-behind (&optional n)
  "Scroll N lines behind."
  (interactive "P")
  (scroll-behind (prefix-numeric-value n)))

(global-set-key (kbd "C-q") 'scroll-n-lines-behind)
;(global-set-key (kbd "C-q") 'quoted-insert)
(global-set-key (kbd "C-z") 'scroll-n-lines-ahead)
;(global-set-key (kbd "C-z") 'vc-toggle-read-only)

(defun read-only-if-symlink ()
  "Set file to read-only mode upon opening if it is a symlink."
  (if (file-symlink-p buffer-file-name)
      (progn
	(setq buffer-read-only t)
	(message "File is a symlink"))))
(add-hook 'find-file-hook 'read-only-if-symlink)
(remove-hook 'find-file-hook 'read-only-if-symlink)

;; MISC

(require 'url)
(defun insert-image-from-url (&optional url)
  (interactive)
  (unless url (setq url (url-get-url-at-point)))
  (unless url
    (error "Couldn't find URL"))
  (let ((buffer (url-retrieve-synchronously url)))
    (unwind-protect
         (let ((data (with-current-buffer buffer
                       (goto-char (point-min))
                       (search-forward "\n\n")
                       (buffer-substring (point) (point-max)))))
           (insert-image (create-image data nil t)))
      (kill-buffer buffer))))

(defvar weather-plot "https://forecast.weather.gov/meteograms/Plotter.php?lat=42.3903&lon=-71.1018&wfo=BOX&zcode=MAZ014&gset=20&gdiff=10&unit=0&tinfo=EY5&ahour=0&pcmd=11101111100000000000000000000000000000000000000000000000000&lg=en&indu=1!1!1!&dd=&bw=&hrspan=48&pqpfhr=6&psnwhr=6")


;;; idea:  add W to browse-the-item to neotree!
;;; idea:  shortcut key to open _repos
;;; idea:  shortcut key to open BB of repo
;;; org-mode my .emacs file (http://pages.sachachua.com/.emacs.d/Sacha.html)
;;; org-mode capture refinement - just one but with some tags
;;; add interface for JIRA jobs in org mode, using restclient


(provide 'giessel_ext)
;;; giessel_ext ends here
