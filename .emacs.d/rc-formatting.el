;; Author: Maxim Kalaev
;;
;; Refs:
;; http://www.rwdev.eu/articles/emacspyeng

;; Autoload for modules needed in hooks
(autoload 'whitespace-mode "whitespace" "Whitespace highlighting mode." t)
(autoload 'python-mode "python-mode" "Python Mode." t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'gtags-mode "gtags" nil t)


;; Default formatting settings
(setq-default c-basic-offset 4)
(setq-default c-tab-width 4)
(setq-default c++-basic-offset 4)
(setq-default c++-tab-width 4)
(setq-default indent-tabs-mode nil) ; Don't use tabs for indentation
(setq c-recognize-knr-p nil) ; do not to check for old-style (K&R declarations to speed up indentation (cc-mode)


;; Whitespace mode common configuration
(setq whitespace-style
      '(face trailing empty tabs tab-mark indentation::space lines-tail))
(setq whitespace-line-column 120)


;; Yasnippet
(require 'yasnippet-bundle)

;; Ropemacs
;(require 'ido) ;; To cycle completions in minibuffer
;(pymacs-load "ropemacs" "rope-")
;(setq ropemacs-enable-autoimport t)
;(setq ropemacs-confirm-saving 'nil) ;; Save buffers before refactorings
;(ropemacs-mode t)

;; Auto-complete
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
;; (ac-config-default)

;; Auto - insert spaces around math operators
(require 'smart-operator)
(smart-operator-mode-on)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C specific
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 
(defun c-font-lock-if0 (limit)
  "Syntax highlighting of #if 0 blocks."
  "Source: 
   http://stackoverflow.com/questions/4549015/in-c-c-mode-in-emacs-change-face-of-code-in-if-0-endif-block-to-comment-f"
  (save-restriction
    (widen)
    (save-excursion
      (goto-char (point-min))
      (let ((depth 0) str start start-depth)
        (while (re-search-forward "^\\s-*#\\s-*\\(if\\|else\\|endif\\)" limit 'move)
          (setq str (match-string 1))
          (if (string= str "if")
              (progn
                (setq depth (1+ depth))
                (when (and (null start) (looking-at "\\s-+0"))
                  (setq start (match-end 0)
                        start-depth depth)))
            (when (and start (= depth start-depth))
              (c-put-font-lock-face start (match-beginning 0) 'font-lock-comment-face)
              (setq start nil))
            (when (string= str "endif")
              (setq depth (1- depth)))))
        (when (and start (> depth 0))
          (c-put-font-lock-face start (point) 'font-lock-comment-face)))))
  nil)

(defun my-cmode-hook()
  "My customizations for c-mode"
  (c-set-style "bsd")
  (setq c-basic-offset 4)
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (font-lock-add-keywords nil '(("\\<\\(FIXME:\\|TODO:\\)" 1 font-lock-warning-face t))) ; highlight FIXME/TODO/BUG
  (font-lock-add-keywords nil '((c-font-lock-if0 (0 font-lock-comment-face prepend))) 'add-to-end) ; highlight #if 0
  (setq fill-column 120)
  (auto-fill-mode t) ;; Intelegently auto-break lines
  (whitespace-mode t)
  (gtags-mode t))
(add-hook 'c-mode-common-hook 'my-cmode-hook)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Python specific
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist(cons '("python" . python-mode) interpreter-mode-alist))
(require 'python-mode)
;(require 'pycomplete) ;; yet another completion package..

;; Python mode hook
(defun my-python-mode-hook ()
  "My customizations for python-mode"
  (local-set-key [(control c) (control c)] 'comment-region)

  ;; python-mode
  ;(define-key py-mode-map (kbd "RET") 'newline-and-indent)

  ;; Set python mode
  ;(set-variable 'py-indent-offset 4)
  ;(set-variable 'indent-tabs-mode nil)

  (whitespace-mode t)
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)
 
;; Source: http://hide1713.wordpress.com/2009/01/30/setup-perfect-python-environment-in-emacs/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-completion
;;;  Integrates:
;;;   1) Rope
;;;   2) Yasnippet
;;;   all with AutoComplete.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun prefix-list-elements (list prefix)
;;   (let (value)
;;     (nreverse
;;      (dolist (element list value)
;;       (setq value (cons (format "%s%s" prefix element) value))))))

;; (defvar ac-source-rope
;;   '((candidates
;;      . (lambda ()
;;          (prefix-list-elements (rope-completions) ac-target))))
;;   "Source for Rope")

;; (defun ac-python-find ()
;;   "Python `ac-find-function'."
;;   (require 'thingatpt)
;;   (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
;;     (if (null symbol)
;;         (if (string= "." (buffer-substring (- (point) 1) (point)))
;;             (point)
;;           nil)
;;       symbol)))

;; (defun ac-python-candidate ()
;;   "Python `ac-candidates-function'"
;;   (let (candidates)
;;     (dolist (source ac-sources)
;;       (if (symbolp source)
;;           (setq source (symbol-value source)))
;;       (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
;;              (requires (cdr-safe (assq 'requires source)))
;;              cand)
;;         (if (or (null requires)
;;                 (>= (length ac-target) requires))
;;             (setq cand
;;                   (delq nil
;;                         (mapcar (lambda (candidate)
;;                                   (propertize candidate 'source source))
;;                                 (funcall (cdr (assq 'candidates source)))))))
;;         (if (and (> ac-limit 1)
;;                  (> (length cand) ac-limit))
;;             (setcdr (nthcdr (1- ac-limit) cand) nil))
;;         (setq candidates (append candidates cand))))
;;     (delete-dups candidates)))

;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             ;; Python auto-completion hook
;;             (auto-complete-mode 1)
;;             (set (make-local-variable 'ac-sources)
;;                  (append ac-sources '(ac-source-rope) '(ac-source-yasnippet)))
;;             (set (make-local-variable 'ac-find-function) 'ac-python-find)
;;             (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
;;             (set (make-local-variable 'ac-auto-start) nil)))

;; ;;Ryan's python specific tab completion
;; (defun ryan-python-tab ()
;;   ; Try the following:
;;   ; 1) Do a yasnippet expansion
;;   ; 2) Do a Rope code completion
;;   ; 3) Do an indent
;;   (interactive)
;;   (if (eql (ac-start) 0)
;;       (indent-for-tab-command)))
;; (defadvice ac-start (before advice-turn-on-auto-start activate)
;;   (set (make-local-variable 'ac-auto-start) t))
;; (defadvice ac-cleanup (after advice-turn-off-auto-start activate)
;;   (set (make-local-variable 'ac-auto-start) nil))
;; (define-key py-mode-map "\t" 'ryan-python-tab)
;;; End Auto Completion

(provide 'rc-formatting)
