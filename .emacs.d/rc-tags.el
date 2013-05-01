;; Author: Maxim Kalaev

;; GTAGS
(require 'gtags)
(global-unset-key [C-down-mouse-1])
(global-unset-key [C-down-mouse-3])

(global-set-key [C-mouse-1] 'gtags-find-tag-by-event)
(global-set-key [(mouse-3)] 'gtags-pop-stack)
;; (define-key gtags-mode-map [C-mouse-1] 'gtags-find-tag-by-event)
;; (define-key gtags-mode-map [(mouse-3)] 'gtags-pop-stack)
(define-key gtags-select-mode-map [C-mouse-1] 'gtags-select-tag-by-event)
(define-key gtags-select-mode-map [(mouse-1)] 'gtags-select-tag-by-event)
(define-key gtags-select-mode-map [(mouse-3)] 'gtags-pop-stack)


;; Finding Tags Files Source: http://www.emacswiki.org/emacs/EmacsTags
;; "Vim has a nice feature where you can indicate that you would like
;; the editor to search up the directory tree from the current working
;; directory for a file named â'tags'. These two functions provide
;; that for vtags, searching up the filesystem from the
;; buffer-file-name of the current buffer."
;; (defun jds-find-tags-file ()
;;   "recursively searches each parent directory for a file named `tags' and returns the
;; path to that file or nil if a tags file is not found. Returns nil if the buffer is
;; not visiting a file"
;;   (labels
;;       ((find-tags-file-r (path)
;;          (let* ((parent (file-name-directory path))
;;                 (possible-tags-file (concat parent "tags")))
;;            (cond
;;              ((file-exists-p possible-tags-file) (throw 'found-it possible-tags-file))
;;              ((string= "/tags" possible-tags-file) (error "no tags file found"))
;;              (t (find-tags-file-r (directory-file-name parent)))))))

;;     (if (buffer-file-name)
;;         (catch 'found-it 
;;           (find-tags-file-r (buffer-file-name)))
;;         (error "buffer is not visiting a file"))))

;; (defun jds-set-tags-file-path ()
;;   "calls `jds-find-tags-file' to recursively search up the directory tree to find
;; a file named `tags'. If found, calls `vtags-set-tags-file' with that path as an argument
;; otherwise raises an error."
;;   (interactive)
;;   (vtags-set-tagfile (jds-find-tags-file)))

(provide 'rc-tags)
;; end
