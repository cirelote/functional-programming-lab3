;Функція сортування з використанням конструктивного підходу

(defun ex3-iteration (lst last-ex)
  (if (or (null lst) (null (cdr lst)))
      (values lst last-ex)
      (if (> (car lst) (cadr lst))
          (let* ((swapped (cons (cadr lst) (cons (car lst) (cddr lst)))))
            (multiple-value-bind (sorted-lst new-last-ex)
                (ex3-iteration (cdr swapped) t)
              (values (cons (car swapped) sorted-lst)
                      (or new-last-ex t))))
          (multiple-value-bind (sorted-lst new-last-ex)
              (ex3-iteration (cdr lst) nil)
            (values (cons (car lst) sorted-lst)
                    (or new-last-ex last-ex))))))

(defun exchange3-rec (lst)
  (multiple-value-bind (new-lst last-ex)
      (ex3-iteration lst nil)
    (if last-ex
        (exchange3-rec new-lst)
        new-lst)))

(defun exchange3-func (lst)
  (exchange3-rec lst))


(defun check-exchange3-func (name input expected)
  (format t "~:[FAILED~;passed~]... ~a~%"
          (equal (exchange3-func input) expected)
          name))

(defun test-exchange3-func ()
  (check-exchange3-func "Test 1" '(1 2 3 4 5) '(1 2 3 4 5))
  (check-exchange3-func "Test 2" '(5 4 3 2 1) '(1 2 3 4 5))
  (check-exchange3-func "Test 3" '(5 1 4 2 3 3) '(1 2 3 3 4 5))
  (check-exchange3-func "Test 4" '(5 5 4 4 3) '(3 4 4 5 5))
  (check-exchange3-func "Test 5" '(5 -1 2 -3 4 -5) '(-5 -3 -1 2 4 5)))

;(format t "Testing exchange3-func:~%")
;(test-exchange3-func)

;Функція сортування з використанням деструктивного підходу
(defun exchange3-imp (lst)
  (let ((copy (copy-list lst)) R k)
    (setf R (- (length copy) 1))
    (loop while (> R 0) do
          (setf k 0)
          (loop for i from 0 below R do
                (if (> (nth i copy) (nth (+ i 1) copy))
                    (let ((tmp (nth i copy)))
                      (setf (nth i copy) (nth (+ i 1) copy))
                      (setf (nth (+ i 1) copy) tmp)
                      (setf k i)))) 
          (setf R k))  
    copy))

(defun check-exchange3-imp (name input expected)
  (format t "~:[FAILED~;passed~]... ~a~%"
          (equal (exchange3-imp input) expected)
          name))

(defun test-exchange3-imp ()
  (check-exchange3-imp "Test 1" '(1 2 3 4 5) '(1 2 3 4 5))
  (check-exchange3-imp "Test 2" '(5 4 3 2 1) '(1 2 3 4 5))
  (check-exchange3-imp "Test 3" '(5 1 4 2 3 3) '(1 2 3 3 4 5))
  (check-exchange3-imp "Test 4" '(5 5 4 4 3) '(3 4 4 5 5))
  (check-exchange3-imp "Test 5" '(5 -1 2 -3 4 -5) '(-5 -3 -1 2 4 5)))

;(format t "Testing exchange3-imp:~%")
;(test-exchange3-imp)


