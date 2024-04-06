;;; more-math --- Summary
;;; Commentary:


;;; Code:
(defun square (n)
 "This function squares N."
    (* n n))

(defun mean (&rest ns)
  "This function calculates the mean its arguments, NS."
    (/ (float (apply '+ ns))
       (length ns)))

(defun std (&rest ns)
  "This function calculates the standard deviation of its arguments, NS."
  (let* ((mean-val (apply 'mean ns)))
    (apply '+ (mapcar (lambda (x) (square (- mean-val x)))
		      ns))))

(defun variance (&rest ns)
  "This function calculates the variance of its arguments, NS."
  (square (apply 'std ns)))


(provide 'more-math)
;;; more-math.el ends here
