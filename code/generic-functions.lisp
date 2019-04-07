(in-package #:sealable-metaobjects)

;;; Checking for sealability.

(defgeneric metaobject-sealable-p (metaobject)
  (:method ((class class)) nil)
  (:method ((generic-function generic-function)) nil)
  (:method ((method method)) nil)
  (:method ((built-in-class built-in-class)) t))

(defgeneric class-sealable-p (class)
  (:method ((class class))
    (metaobject-sealable-p class)))

(defgeneric generic-function-sealable-p (generic-function)
  (:method ((generic-function generic-function))
    (metaobject-sealable-p generic-function)))

(defgeneric method-sealable-p (method)
  (:method ((method method))
    (metaobject-sealable-p method)))

;;; Checking for sealed-ness

(defgeneric metaobject-sealed-p (metaobject)
  (:method ((class class)) nil)
  (:method ((generic-function generic-function)) nil)
  (:method ((method method)) nil)
  (:method ((built-in-class built-in-class)) t))

(defgeneric class-sealed-p (class)
  (:method ((class class))
    (metaobject-sealed-p class)))

(defgeneric generic-function-sealed-p (generic-function)
  (:method ((generic-function generic-function))
    (metaobject-sealed-p generic-function)))

(defgeneric method-sealed-p (method)
  (:method ((method method))
    (metaobject-sealed-p method)))

;;; Sealing of metaobjects

(defgeneric seal-metaobject (metaobject)
  (:method ((object t))
    (declare (ignore object))
    (values)))

(defgeneric seal-class (class)
  (:method ((class class))
    (seal-metaobject class)))

(defgeneric seal-generic-function (generic-function)
  (:method ((generic-function generic-function))
    (seal-metaobject generic-function)))

(defgeneric seal-method (method)
  (:method ((method method))
    (seal-metaobject method)))

(defgeneric specializer-sealed-p (specializer)
  (:method ((class class)) nil)
  (:method ((built-in-class built-in-class)) t)
  (:method ((eql-specializer eql-specializer))
    (specializer-sealed-p
     (class-of
      (eql-specializer-object eql-specializer)))))

;;; Miscellaneous

(defgeneric generic-function-specializer-profile (generic-function))

(defgeneric method-inline-lambda (method))

(defgeneric specializer-type (specializer)
  (:method ((class class))
    (class-name class))
  (:method ((eql-specializer eql-specializer))
    `(eql ,(eql-specializer-object eql-specializer))))

(defgeneric specializer-prototype (specializer)
  (:method ((class class))
    (let ((prototype (class-prototype class)))
      ;; Surprisingly, some implementations return a CLASS-PROTOTYPE that
      ;; is not actually an instance of the given class.
      (if (typep prototype class)
          prototype
          (cond ((eq class (find-class 'list))
                 (load-time-value (cons nil nil)))
                ((subtypep class 'array)
                 (load-time-value (make-array '())))
                (t (error "Cannot compute a class prototype for ~S. ~S"
                          class prototype))))))
  (:method ((eql-specializer eql-specializer))
    (eql-specializer-object eql-specializer)))

(defgeneric specializer-load-form (specializer)
  (:method ((class class))
    `(find-class ',(class-name class)))
  (:method ((eql-specializer eql-specializer))
    `(make-instance 'eql-specializer
       :object ',(eql-specializer-object eql-specializer))))

(defgeneric specializer-direct-superspecializers (specializer)
  (:method ((class class))
    (class-direct-superclasses class))
  (:method ((eql-specializer eql-specializer))
    (class-direct-superclasses
     (class-of
      (eql-specializer-object eql-specializer)))))
