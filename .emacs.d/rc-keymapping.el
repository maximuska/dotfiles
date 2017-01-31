;; General key binding, unrelated to the specific packages
;;  or packages configured to be loaded automatically


;(global-set-key [f1] 'find-tag) ; Find tag on F1
(global-set-key [f1] 'suspend-frame) ; Minimize on F1
(global-set-key [(meta g)] 'goto-line) ; Goto line on Alt-g
(global-set-key [(control z)] 'undo) ; Undo on Ctrl-z
(global-set-key [(control backspace)] 'backward-kill-word) ;; 
(global-set-key "\C-xj" 'jump-to-register) ;; Shortcut register jump to C-xj-

(global-set-key [(M-down-mouse-3)] 'mouse-buffer-menu) ;;

; Switch buffers on Ctrl-Tab
(global-set-key [(control tab)] "\C-xb")
;(require 'wcy-swbuff)
;(global-set-key (kbd "<C-tab>") 'wcy-switch-buffer-forward)
;(global-set-key (kbd "<C-S-kp-tab>") 'wcy-switch-buffer-backward)

; Toggle Tab size
(global-set-key [(control $)] (lambda ()
                                (interactive)
                                (setq tab-width (if (= tab-width 4) 8 (if (= tab-width 8) 2 4)))
                                (redraw-display)))

;; bind C-c C-c to comment-region
(global-set-key [(control c) (control c)] 'comment-region)

;(require 'tabbar)
;; (global-set-key [(meta left)] 'tabbar-backward)
;; (global-set-key [(meta right)] 'tabbar-forward)

(global-set-key [(control c) (\;)] (lambda ()
  "Show the full path file name in the minibuffer, and puts it into the clipboard"
  (interactive)
  (when buffer-file-name
    (message (buffer-file-name))
    (kill-new (buffer-file-name)))))
