(setq charm-keywords
  '(("\\([^\n ]+\\) +:=" (1 font-lock-function-name-face))
    ("-?[0-9]*\\.?[0-9]+" (0 font-lock-constant-face))
    ("\".+\"[[:blank:]]+pop" (0 font-lock-comment-face))
    ("[\^\\|[:space:]]\".+\"[\$\\|[:space:]]" (0 font-lock-string-face))))

(define-derived-mode charm-mode fundamental-mode "Charm"
  "Major mode for writing Charm code."
  (setq font-lock-defaults '(charm-keywords))
  (setq font-lock-keywords-only t))


(add-to-list 'auto-mode-alist '("\\.charm\\'" . charm-mode))
(provide 'charm-mode)
