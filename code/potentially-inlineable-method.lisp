(in-package #:sealable-metaobjects)

(defclass potentially-inlineable-method (potentially-sealable-method)
  ((%inline-lambda
    :initarg .inline-lambda.
    :reader method-inline-lambda
    :initform nil)))

(defmethod make-method-lambda :around
    ((gf generic-function)
     (pim potentially-inlineable-method)
     lambda
     environment)
  (multiple-value-bind (method-lambda initargs)
      (call-next-method)
    (if (not (method-sealable-p pim))
        (values method-lambda initargs)
        (values
         method-lambda
         (list* '.inline-lambda.
                (compute-method-inline-lambda pim lambda environment)
                initargs)))))
