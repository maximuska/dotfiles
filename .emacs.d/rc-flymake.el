;; Author: Maxim Kalaev
;;

;; Flymake: auto Syntax Checking and Error Hightlight
(when (load "flymake" t)
  ;; Generic python syntax checking based on 'pyflakes'
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
	       (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))

  ;; XIV-specific compilation.
  ;; Find build root direcotry by looking for xtool.py, or tries compiling the file from its folder
  (defun flymake-xiv-c-init ()
    ;; This requires a patched version of flymake.el to work (the original
    ;;  version has a bug in flymake-start-syntax-check-process
    ;;  function failing setting 'default-directory' variable.
    (let* ((buildfile-dir (or (flymake-find-buildfile "xtool.py" (file-name-directory buffer-file-name))
                              (file-name-directory buffer-file-name)))
           (temp-file (file-relative-name
                       (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace)
                       buildfile-dir))
           (build-command "gcc")
           (build-args-list (list "-g" "-O2" "-Wall" "-Werror"
                                  "-Wno-pointer-sign"
                                  "-Wno-unused-result"
                                  "-Wno-unused-but-set-variable"
                                  "-Wno-enum-compare"
                                  "-I."
                                  "-D__MY_FILE__=xxx"
                                  "-D_GNU_SOURCE=xx"
                                  "-o" "/dev/null"
                                  "-c" temp-file)))
      (if buildfile-dir
          (setq flymake-base-dir buildfile-dir)
        (flymake-log 1 "no buildfile (%s) for %s" "xtool.py" buffer-file-name) nil)
      (flymake-log 3 "flymake-init: %s %s in %s" build-command build-args-list buildfile-dir)
      (list build-command build-args-list buildfile-dir)))

  (add-to-list 'flymake-allowed-file-name-masks '("\\.py\\'" flymake-pyflakes-init))
  (add-to-list 'flymake-allowed-file-name-masks '("\\.c\\'" flymake-xiv-c-init))
  (require 'flymake-cursor)
  (add-hook 'find-file-hook 'flymake-find-file-hook))

(provide 'rc-flymake)
