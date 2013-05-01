;; -*- Mode: Emacs-Lisp -*-

;; .emacs  
(message "** Started loading ~/.emacs **")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs auto-configured variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :family "misc-dejavu sans mono"))))
 '(trailing-whitespace ((((class color) (background light)) (:background "wheat3"))))
 '(whitespace-line ((t (:background "burlywood"))))
 '(whitespace-trailing ((t (:background "burlywood" :weight bold)))))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
; '(flymake-allowed-file-name-masks (quote (("\\.xml\\'" flymake-xml-init) ("\\.html?\\'" flymake-xml-init))))
 '(flymake-allowed-file-name-masks (quote ()))
 '(flymake-log-level 0)
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(save-place t nil (saveplace))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(toolbar-visible-p nil)
 '(transient-mark-mode t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Custom load load path
(add-to-list 'load-path "~/programs/share/emacs/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
;(add-to-list 'load-path "~/.emacs.d/site-lisp/python-mode")
;(add-to-list 'load-path "~/.emacs.d/site-lisp/icicles")
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-color-theme-solarized")

;; Loading general global key-mappings
(load-file "~/.emacs.d/rc-keymapping.el")

;; Set color theme
(load-file "~/.emacs.d/rc-color-theme.el")

;; Pymacs package autoload
(setq pymacs-python-command "python2.7") ; path to the python interpreter
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

;; IDO buffers select package
(require 'ido)
(ido-mode t)

;; Loading tags definitions
(load "~/.emacs.d/rc-tags")

;; Loading languages formatting definitions and modifiers
(load "~/.emacs.d/rc-formatting")

;; Loading flymake syntax checking package
(load "~/.emacs.d/rc-flymake")

;; Loading 'linux-kernel' c formatting style definitions
(load "~/.emacs.d/rc-linux-kernel-style")

;; Spelling settings
(load-file "~/.emacs.d/rc-spell.el")

;; Try fixing focus issues on windows system
;; (setq focus-follows-mouse nil)

;;
(put 'scroll-left 'disabled nil)

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

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

; Enable upcase/downcase-region commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

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

;; Permanent display of line and column numbers is useful for programmers
(setq-default line-number-mode 't)
(setq-default column-number-mode 't)

; Allow connections from emacs clients
(server-start)

;; Dont show the GNU splash screen
(setq inhibit-startup-message t)

;; get rid of the toolbar on top of the window
(tool-bar-mode 0)

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

; Enable Shift+keys selections and selection deletion
(pc-selection-mode t)
(if (fboundp 'pending-delete-mode)
    (pending-delete-mode 1))

; Don't beep
(setq visible-bell t)

; Saves the position the cursor was in a file before the file was closed.
(load-library "saveplace")
(setq save-place-file "~/.emacs.d/.emacs-places")

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
;; (require 'backup-dir) 
;; (setq bkup-backup-directory-info 
;;       '((t "~/.backups" ok-create full-path)))

(load-library "font-lock")
(font-lock-mode 4)

(setq default-tab-width 4)

;cedit
;(require 'rc-cedet)

;; Don't in XML mode
(add-hook 'xml-mode-hook (lambda ()
                           "Turn off autofill mode."
                           (auto-fill-mode nil)))


	
;; Autorevert buffers when modified by an external program (unless were locally changed)
(global-auto-revert-mode t)

;; M-x goto-last-change to jump to the last edit location
(autoload 'goto-last-change "goto-last-change" "Set point to the position of the last change." t)

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

;;
;;Color themes
;(color-theme-xemacs)
;color-theme-bharadwaj-slate
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-hober)))

; See: http://www.emacswiki.org/cgi-bin/wiki/FillAdapt
;;; Filladapt is an adaptive text-filling package.  When it is enabled it
;;; makes filling (e.g. using M-q) much much smarter about paragraphs
;;; that are indented and/or are set off with semicolons, dashes, etc.

;; (require 'filladapt)
;; (setq-default filladapt-mode t)
;; (when (fboundp 'turn-off-filladapt-mode)
;;    (add-hook 'xml-mode-hook 'turn-off-filladapt-mode)
;;
;; (setq filladapt-token-table
;;    (quote (("^" beginning-of-line)
;;            (">+" citation->)
;;            ("\\(\\w\\|[0-9]\\)[^'`\"< \t\n]*>[ \t]*" supercite-citation)
;;            (";+" lisp-comment)
;;            ("#+" sh-comment)
;;            ("%+" postscript-comment)
;;            ("^[ \t]*\\(//\\|\\*\\)[^ \t]*" c++-comment)
;;            ("@c[ \\t]" texinfo-comment)
;;            ("@comment[ \t]" texinfo-comment)
;;            ("\\\\item[ \t]" bullet)
;;            ("[0-9]+\\.[ \t]" bullet)
;;            ("[0-9]+\\(\\.[0-9]+\\)+[ \t]" bullet)
;;            ("[A-Za-z]\\.[ \t]" bullet)
;;            ("(?[0-9]+)[ \t]" bullet)
;;            ("(?[A-Za-z])[ \t]" bullet)
;;            ("[0-9]+[A-Za-z]\\.[ \t]" bullet)
;;            ("(?[0-9]+[A-Za-z])[ \t]" bullet)
;;            ("[-~*+]+[ \t]" bullet)
;;            ("o[ \t]" bullet)
;;            ("[\\@]\\(param\\|throw\\|exception\\|addtogroup\\|defgroup\\)[ \t]*[A-Za-z_][A-Za-z_0-9]*[ \t]+" bullet)
;;            ("[\\@][A-Za-z_]+[ \t]*" bullet)
;;            ("[ \t]+" space)
;;            ("$" end-of-line))))

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

(message "** Finished loading ~/.emacs **")
