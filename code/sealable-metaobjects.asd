(defsystem "sealable-metaobjects"
  :author "Marco Heisig <marco.heisig@fau.de>"
  :description "A CLOSsy way to trade genericity for performance."
  :license "MIT"
  :depends-on ("closer-mop" "trivial-macroexpand-all")

  :in-order-to ((test-op (load-op "sealable-metaobjects-test-suite")))

  :serial t
  :components
  ((:file "packages")
   (:file "debug")
   (:file "utilities")
   (:file "lambda-lists")
   (:file "generic-functions")
   (:file "null-lexical-environment-p")
   (:file "specializer-prototype")

   ;; Sealable Metaobjects.
   (:file "built-in-class")
   (:file "sealable-metaobject-mixin")
   (:file "sealable-class")
   (:file "potentially-sealable-method")
   (:file "sealable-generic-function")
   (:file "compute-static-call-signatures")
   (:file "sealable-standard-class")
   (:file "potentially-sealable-standard-method")
   (:file "sealable-standard-generic-function")

   ;; Inlineable Metaobjects.
   (:file "inlineable-generic-function")
   (:file "inlineable-standard-generic-function")
   (:file "potentially-inlineable-method")
   (:file "inline-lambda")

   ;; The Magic.
   (:module "implementation-specific"
    :components
    ((:file "sbcl" :if-feature :sbcl)
     (:file "default" :if-feature (:not (:or :sbcl)))))))
