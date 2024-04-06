;;; splitter --- Summary
;;; Summary:
;;; Commentary:
;;; Code:


;;; NOTE:  use https://github.com/magnars/s.el instead!!!

(require 'subr-x)

(defun split-on (delimiter start end)
  "Split the selected region (from START to END) on the specificed DELIMITER."
  (interactive (let ((delimiter (read-string "Delimiter: ")))
		 (list delimiter (region-beginning) (region-end))))
  (save-excursion
    (let* ((to-split (string-trim-right (buffer-substring start end))))
      (kill-region start end)
      (insert (replace-regexp-in-string (concat delimiter "\s *") "\n" to-split)))))

(defun unsplit-with (delimiter start end)
  "Un-split the selected region (from START to END) using the specificed DELIMITER."
  (interactive (let ((delimiter (read-string "Delimiter: ")))
		 (list delimiter (region-beginning) (region-end))))
  (save-excursion
    (let* ((to-unsplit (string-trim-right (buffer-substring start end))))
      (kill-region start end)
      (insert (replace-regexp-in-string "\n" (concat delimiter " ") to-unsplit)))))

(provide 'splitter)
;;; splitter ends here
