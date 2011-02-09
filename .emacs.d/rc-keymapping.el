;; General key binding, unrelated to the specific packages
;;  or packages configured to be loaded automatically

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

;; Shortcutting register jumping: C-xrj-.. to C-xj-..
(global-set-key "\C-xj" 'jump-to-register)

(global-set-key [(M-down-mouse-3)] 'mouse-buffer-menu) ;;

(global-set-key [(control backspace)] 'backward-kill-word) ;; 

; Minimize on F1
(global-set-key [f1] 'suspend-frame)

; Change Tab size quickly
(global-set-key [(control @)] (lambda () (interactive) (setq tab-width 2)))
(global-set-key [(control $)] (lambda () (interactive) (setq tab-width 4)))
