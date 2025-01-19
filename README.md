<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>

<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Конструктивний і деструктивний підходи до роботи зі списками"<br/>
з дисципліни "Вступ до функціонального програмування"
</p>

<p align="right"><b>Студент</b>: Луценко Б. А.<p>
<p align="right"><b>Група</b>: КВ-13<p>
<p align="center"><b>Рік</b>: 2024</p>

<div style="page-break-after: always;"></div>

## Загальне завдання
Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і
імперативно.
1. Функціональний варіант реалізації має базуватись на використанні рекурсії і
конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного списку.
Не допускається використання: псевдо-функцій, деструктивних операцій, циклів,
функцій вищого порядку або функцій для роботи зі списками/послідовностями, що
використовуються як функції вищого порядку. Також реалізована функція не має
бути функціоналом (тобто приймати на вхід функції в якості аргументів).
2. Імперативний варіант реалізації має базуватись на використанні циклів і
деструктивних функцій (псевдофункцій). Не допускається використання функцій
вищого порядку або функцій для роботи зі списками/послідовностями, що
використовуються як функції вищого порядку. Тим не менш, оригінальний список
цей варіант реалізації також не має змінювати, тому перед виконанням
деструктивних змін варто застосувати функцію copy-list (в разі необхідності).
Також реалізована функція не має бути функціоналом (тобто приймати на вхід
функції в якості аргументів).

Алгоритм, який необхідно реалізувати, задається варіантом (п. 3.1.1). Зміст і шаблон звіту
наведені в п. 3.2.

Кожна реалізована функція має бути протестована для різних тестових наборів. Тести
мають бути оформленні у вигляді модульних тестів (наприклад, як наведено у п. 2.3).

## Варіант 3
  Алгоритм сортування обміном №3 (із запам'ятовуванням місця останньої перестановки)
за незменшенням.

## Лістинг функції з використанням конструктивного підходу
```lisp
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
```
### Тестові набори та утиліти
```lisp
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
```
### Тестування
```lisp
CL-USER> (test-exchange3-func)
passed... Test 1
passed... Test 2
passed... Test 3
passed... Test 4
passed... Test 5
NIL
```
## Лістинг функції з використанням деструктивного підходу
```lisp
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
```
### Тестові набори та утиліти
```lisp
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
```
### Тестування
```lisp
CL-USER> (test-exchange3-imp)
passed... Test 1
passed... Test 2
passed... Test 3
passed... Test 4
passed... Test 5
NIL
```


