;; Author: Maxim Kalaev
;;
;; Taken from:
;; http://lxr.linux.no/#linux+v2.6.34/Documentation/CodingStyle#L465

;; Adding linux-kernel code style, and appropriate hooks to enable it
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-initialization-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-kernel"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "kernel/tree") filename))
                (setq indent-tabs-mode t)
                (c-set-style "linux-kernel")))))

(provide 'rc-linux-kernel-style)
