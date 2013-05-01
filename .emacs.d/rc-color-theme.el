;; Setting my emacs colors
;; Author: Maxim Kalaev

;;FIXME: not the 'rc-color-theme', rather the TTY <-> X settings selector.

;(require 'color-theme)
(defun my-theme-select (frame)
  "Set theme for the specifed frame or for all existing frames if not specified,"
  " selecting depending on running mode: X/console"
  (with-selected-frame frame
    (if (display-graphic-p)
        (message "Running for frame in x-mode : %s" frame)
  ;;       ;; X mode theme
  ;;       (progn
  ;;         (message "Running for frame in x-mode: %s" frame)
  ;;         ;; (set-face-foreground 'default "black")
  ;;         ;; (set-face-background 'default "wheat")
  ;;         )
      ;; TTY theme
      ;(message "Running for frame in TTY mode: %s")
      ;(menu-bar-mode 0)
      ;(set-face-foreground 'default "white")
      ;(set-face-background 'default "black")
  
    )))

(add-hook 'after-make-frame-functions 'my-theme-select)
(my-theme-select (selected-frame))
(provide 'rc-color-theme)
