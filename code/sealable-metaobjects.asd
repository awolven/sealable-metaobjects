(defsystem "sealable-metaobjects"
  :depends-on ("closer-mop" "trivial-macroexpand-all")

  :serial t
  :components
  ((:file "packages")
   (:file "debug")
   (:file "null-lexical-environment-p")
   (:file "inlineable-method-lambda-p")
   (:file "generic-functions")
   (:file "sealable-metaobject-mixin")
   (:file "sealable-class")
   (:file "potentially-sealable-method")
   (:file "sealable-generic-function")
   (:file "sealable-standard-class")
   (:file "potentially-sealable-standard-method")
   (:file "sealable-standard-generic-function")
   (:file "compute-static-call-signatures")
   (:module "implementation-specific"
    :components
    ((:file "sbcl" :if-feature :sbcl)
     (:file "default" :if-feature (:not (:or :sbcl)))))))