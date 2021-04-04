(load "~/quicklisp/setup.lisp")
(ql:quickload "hunchentoot")
(ql:quickload "cl-who")
(ql:quickload "mito")
(ql:quickload "parenscript")

(defpackage :path-of-crimson
  (:use :cl :cl-who :hunchentoot :parenscript))

(in-package :path-of-crimson)

(defclass book ()
  ((title
    :initarg :title
    :accessor title)
   (author
    :initarg :author
    :accessor author))
  (:metaclass mito:dao-table-class))
(mito:ensure-table-exists 'book)

(defmacro define-url-fn ((name) &body body)
  `(progn
     (defun ,name ()
       ,@body)
     (push (create-prefix-dispatcher ,(format nil "/~(~a~)" name) *dispatch-table*))))


(defvar *acceptor* (make-instance 'hunchentoot:easy-acceptor :port 8080
							     :document-root #p"~/Documents/marx3mao-lisp/www/"))
(hunchentoot:start *acceptor*)

