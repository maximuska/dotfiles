(setq ispell-program-name "aspell")
(setq ispell-list-command "list")

; Don't spell-check strings, please
(setq flyspell-prog-text-faces
;  '(font-lock-string-face font-lock-comment-face font-lock-doc-face)
  '(font-lock-comment-face font-lock-doc-face))
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)
;TODO: map M-x ispell-comments-and-strings
