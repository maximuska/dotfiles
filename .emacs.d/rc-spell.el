(setq ispell-program-name "aspell")
(setq ispell-list-command "list")
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)
;TODO: map M-x ispell-comments-and-strings
