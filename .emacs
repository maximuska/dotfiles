;; -*- Mode: Emacs-Lisp -*-

;; .emacs  

;; Custom load load path
(setq load-path
      (cons "~/programs/share/emacs/site-lisp/"
            (cons "~/.emacs.d/site-lisp" load-path)))

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b | %f | %I | @" (system-name)))

;; Another frame title bar formatting
;; (setq-default
;;  frame-title-format
;;  (list '((buffer-file-name " %f" (dired-directory 
;; 	 			  dired-directory
;; 				  (revert-buffer-function " %b"
;; 				  ("%b - Dir:  " default-directory)))))))


;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(fringe-mode (quote (nil . 0)) nil (fringe))
; '(global-semantic-tag-folding-mode t nil (semantic-util-modes))
 '(save-place t nil (saveplace))
 '(scroll-bar-mode (quote right))
; '(semantic-idle-scheduler-idle-time 3)
; '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(toolbar-visible-p nil)
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "wheat" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :family "misc-dejavu sans mono"))))
 '(trailing-whitespace ((((class color) (background light)) (:background "wheat3")))))

; Enable upcase/downcase-region commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; ________________________________________________________________
;;                 General settings
;; ________________________________________________________________

;; If we read a compressed file, uncompress it on the fly:
;; (this works with .tar.gz and .tgz file as well)
(auto-compression-mode 1)

;; Colour files (C++ files and others) by syntax to make them more readable:
(global-font-lock-mode t)

;; Highlight all syntax categories:
(setq font-lock-maximum-decoration t)

;; Highlight the marked region.
(setq-default transient-mark-mode t)

;; 'woman' mode is an improvement on 'man' mode for manual pages
(setq-default woman-use-own-frame nil)
;; Man-notify-method controls the behaviour of (wo)man mode.
;; do 'C-h v' and enter that variable to see options.
;; Uncomment the following line or modify it if you want
;; (setq-default Man-notify-method 'pushy)

;; Permanent display of line and column numbers is useful for programmers
(setq-default line-number-mode 't)
(setq-default column-number-mode 't)

;; Even if the file extension is just .c or .h, assume it is a C++ file:
;(setq auto-mode-alist (cons '("\\.c\\'" . c-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.h\\'" . c-mode) auto-mode-alist))

;; ________________________________________________________
;;                        More custom stuff
;; ________________________________________________________

; Allow connections from emacs clients
(server-start)

;; Dont show the GNU splash screen
(setq inhibit-startup-message t)

;; get rid of the toolbar on top of the window
(tool-bar-mode 0)

;; IDO buffers select package
(require 'ido)
(ido-mode t)

;; id utils package (tags search)
;(load-library "idutils")
(autoload 'gid "idutils" nil t)
(global-set-key [f11] 'gid)

;; Preserver minibuffer history over consequent invocations
(require 'savehist)
(setq savehist-file "~/.emacs.d/history")
(setq savehist-autosave-interval 1)
(setq savehist-length 100)
(savehist-load)

;; Saving all backup into a special single directory
(setq backup-files-directory "~/.emacs.d/backup-files")
(setq backup-directory-alist
	  `((".*" . ,backup-files-directory)))
(setq auto-save-file-name-transforms
	  `((".*" ,backup-files-directory t)))

; Enable Shift+keys selections
(pc-selection-mode t)

; Don't beep
(setq visible-bell t)

; Saves the position the cursor was in a file before the file was closed.
(load-library "saveplace")
(setq save-place-file "~/.emacs.d/.emacs-places")
;(setq shadow-todo-file "~/.emacs/.shadow-todo")

;; Get rid of modeline information taking up too much space -- in
;; particular, minor modes that are always enabled.
(setq pending-delete-modeline-string "")
(setq filladapt-mode-line-string "")
;; lazy-lock doesn't have a variable for its modeline name, so we have
;; to do a bit of surgery.
(and (assoc 'lazy-lock-mode minor-mode-alist)
     (setcdr (cdr (cadr (assoc 'lazy-lock-mode minor-mode-alist))) ""))

;;; ********************
;;; Load a partial-completion mechanism, which makes minibuffer completion
;;; search multiple words instead of just prefixes; for example, the command
;;; `M-x byte-compile-and-load-file RET' can be abbreviated as `M-x b-c-a RET'
;;; because there are no other commands whose first three words begin with
;;; the letters `b', `c', and `a' respectively.
;;;
;(require 'completer)

;;; ********************
;;; Filladapt is an adaptive text-filling package.  When it is enabled it
;;; makes filling (e.g. using M-q) much much smarter about paragraphs
;;; that are indented and/or are set off with semicolons, dashes, etc.

;; (require 'filladapt)
;; (setq-default filladapt-mode t)
;; (when (fboundp 'turn-off-filladapt-mode)
;;   (add-hook 'c-mode-hook 'turn-off-filladapt-mode)
;;   (add-hook 'outline-mode-hook 'turn-off-filladapt-mode))

;; (require 'backup-dir) 
;; (setq bkup-backup-directory-info 
;;       '((t "~/.backups" ok-create full-path)))

(load-library "font-lock")
(font-lock-mode 4)

(setq default-tab-width 4)
(setq-default tab-width 4)

;; 
(setq-default c-basic-offset 4)
(setq-default c-tab-width 4)
(setq-default c++-basic-offset 4)
(setq-default c++-tab-width 4)
(setq-default indent-tabs-mode nil) ; Don't use tabs for indentation

; Tell cc-mode not to check for old-style (K&R) function declarations.
;; This speeds up indenting a lot.
(setq c-recognize-knr-p nil)

;; Whitespace mode.
(require 'whitespace)
(setq whitespace-style
      '(face trailing empty tabs tab-mark indentation::space));lines-tail

;cedit
;(require 'rc-cedet)

;; GTAGS
(require 'gtags)
(global-unset-key [C-down-mouse-1])
(global-unset-key [C-down-mouse-3])

(global-set-key [C-mouse-1] 'gtags-find-tag-by-event)
(global-set-key [(mouse-3)] 'gtags-pop-stack)
;(global-set-key [(C-mouse-3)] 'gtags-pop-stack)
;; (define-key gtags-mode-map [C-mouse-1] 'gtags-find-tag-by-event)
;; (define-key gtags-mode-map [(mouse-3)] 'gtags-pop-stack)

(define-key gtags-select-mode-map [C-mouse-1] 'gtags-select-tag-by-event)
(define-key gtags-select-mode-map [(mouse-1)] 'gtags-select-tag-by-event)
(define-key gtags-select-mode-map [(mouse-3)] 'gtags-pop-stack)

;; Customizing programming modes using hooks...
(defun my-cmode-hook()
  "Set of identation-related fixes applied to all programming modes"
  (c-set-style "gnu")
  (setq c-basic-offset 4)
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (gtags-mode t)
  (whitespace-mode t))

(add-hook 'c-mode-hook 'my-cmode-hook)
(add-hook 'c++-mode-hook 'my-cmode-hook)
;(add-hook 'perl-mode-hook 'my-cmode-hook)

;; Python mode hook
(add-hook 'python-mode-hook
          '(lambda ()
              ;; bind C-c C-c to comment-region
              (local-set-key [(control c) (control c)] 'comment-region)
              (whitespace-mode t)))
  
;; Use python-mode
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))

;; Auto-break lines in C, C++ mode
(add-hook 'c-mode-hook 'turn-on-auto-fill)
(add-hook 'c++-mode-hook 'turn-on-auto-fill)

;; Don't in XML mode
(add-hook 'xml-mode-hook 'turn-off-auto-fill)

; Switch buffers on Ctrl-Tab
;(require 'wcy-swbuff)
;(global-set-key (kbd "<C-tab>") 'wcy-switch-buffer-forward)
;(global-set-key (kbd "<C-S-kp-tab>") 'wcy-switch-buffer-backward)

(global-set-key [(M-down-mouse-3)] 'mouse-buffer-menu) ;;
(global-set-key [(control backspace)] 'backward-kill-word) ;; 

(if (fboundp 'pending-delete-mode)
    (pending-delete-mode 1))

; Minimize on F1
(global-set-key [f1] 'suspend-frame)

; Change Tab size quickly
(global-set-key [(control @)] (lambda () (interactive) (setq tab-width 2)))
(global-set-key [(control $)] (lambda () (interactive) (setq tab-width 4)))

;(require 'tabbar)
;(tabbar-mode t)

;; (defun my-tabbar-buffer-groups ()
;;    "Return the list of group names the current buffer belongs to.
;;  Returns one group for all buffers."
;;    (list
;;     (cond
;; 	 ((string-match "^\\*.+\\*$" (buffer-name))
;; 	  "Misc")
;; ;	 ((member (buffer-name) '("*scratch*" "*Messages*"))
;; ;	  "Misc")
;; 	 ((eq major-mode 'dired-mode)
;; 	  "Dired")
;; 	 ((memq major-mode '(help-mode apropos-mode Info-mode Man-mode))
;; 	  "Help")
;; 	 (t
;; 	  "Common"))))
;; (setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)

;; (set-face-attribute
;;    'tabbar-default-face nil
;;    :background "gray60")
;; (set-face-attribute
;;  'tabbar-unselected-face nil
;;  :background "gray85"
;;  :foreground "gray30"
;;  :box nil)
;; (set-face-attribute
;;  'tabbar-selected-face nil
;;  :background "#f2f2f6"
;;  :foreground "black"
;;  :box nil)
;; (set-face-attribute
;;  'tabbar-button-face nil
;;  :box '(:line-width 1 :color "gray72" :style released-button))
;; (set-face-attribute
;;  'tabbar-separator-face nil
;;  :height 0.7)

;; (global-set-key [(meta left)] 'tabbar-backward)
;; (global-set-key [(meta right)] 'tabbar-forward)

; Find tag on F1
(global-set-key [f1] 'find-tag)

; Goto line on Alt-g
(global-set-key [(meta g)] 'goto-line)

; 
(global-set-key [(control z)] 'undo)


;; (defun my-switch-other-buffer()
;;   (interactive)
;;   (ido-switch-buffer))
(global-set-key [(control tab)] "\C-xb")

;;
;;Color themes
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-xemacs)
;color-theme-bharadwaj-slate

; See: http://www.emacswiki.org/cgi-bin/wiki/FillAdapt
(setq filladapt-token-table
   (quote (("^" beginning-of-line)
           (">+" citation->)
           ("\\(\\w\\|[0-9]\\)[^'`\"< \t\n]*>[ \t]*" supercite-citation)
           (";+" lisp-comment)
           ("#+" sh-comment)
           ("%+" postscript-comment)
           ("^[ \t]*\\(//\\|\\*\\)[^ \t]*" c++-comment)
           ("@c[ \\t]" texinfo-comment)
           ("@comment[ \t]" texinfo-comment)
           ("\\\\item[ \t]" bullet)
           ("[0-9]+\\.[ \t]" bullet)
           ("[0-9]+\\(\\.[0-9]+\\)+[ \t]" bullet)
           ("[A-Za-z]\\.[ \t]" bullet)
           ("(?[0-9]+)[ \t]" bullet)
           ("(?[A-Za-z])[ \t]" bullet)
           ("[0-9]+[A-Za-z]\\.[ \t]" bullet)
           ("(?[0-9]+[A-Za-z])[ \t]" bullet)
           ("[-~*+]+[ \t]" bullet)
           ("o[ \t]" bullet)
           ("[\\@]\\(param\\|throw\\|exception\\|addtogroup\\|defgroup\\)[ \t]*[A-Za-z_][A-Za-z_0-9]*[ \t]+" bullet)
           ("[\\@][A-Za-z_]+[ \t]*" bullet)
           ("[ \t]+" space)
           ("$" end-of-line))))

;(require 'doxymacs)
;(add-hook 'c-mode-common-hook 'doxymacs-mode)
;(add-hook 'c++-mode-hook 'doxymacs-mode)

;(message "1")
;(when (boundp 'filladapt-token-table)
;  ;; add tokens to filladapt to match doxygen markup
;  (message "2")
;  (let ((bullet-regexp
;	 "[@\\]\\(param\\(?:\\s-*\\[\\(?:in\\|out\\|in,out\\)\\]\\)?\\s-+\\sw+\\|return\\)"))
;    (unless (assoc bullet-regexp filladapt-token-table)
;	  (message "3")
;      (setq filladapt-token-table
;       (append filladapt-token-table
;		    (list (list bullet-regexp 'bullet)))))))


;; (add-to-list 'load-path "~/.emacs.d/site-lisp")
;; (setq ipython-command "/usr/local/bin/ipython")

;; (require 'comint)
;; (define-key comint-mode-map [(meta p)]
;;    'comint-previous-matching-input-from-input)
;; (define-key comint-mode-map [(meta n)]
;;    'comint-next-matching-input-from-input)
;; (define-key comint-mode-map [(control meta n)]
;;     'comint-next-input)
;; (define-key comint-mode-map [(control meta p)]
;;     'comint-previous-input)

;; (setq comint-completion-autolist t	;list possibilities on partial completion
;;        comint-completion-recexact nil	;use shortest compl. if characters cannot be added
;;        ;; how many history items are stored in comint-buffers (e.g. py- shell)
;;        ;; use the HISTSIZE environment variable that shells use (if  avail.)
;;        ;; (default is 32)
;;        comint-input-ring-size (string-to-number (or (getenv "HISTSIZE") "100")))


;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; (require 'ipython)
;; (setq py-python-command-args '("-pylab" "-colors" "LightBG"))
