(setq charm-keywords
  '(("\\([^\n ]+\\) +:=" (1 font-lock-function-name-face))
    ("-?[0-9]*\\.?[0-9]+" (0 font-lock-constant-face))
    ("\".+\"[[:blank:]]+pop" (0 font-lock-comment-face))
    ("[\^\\|[:space:]]\".+\"[\$\\|[:space:]]" (0 font-lock-string-face))))

(define-derived-mode charm-mode fundamental-mode "Charm"
  "Major mode for writing Charm code."
  (setq font-lock-defaults '(charm-keywords))
  (setq font-lock-keywords-only t))

(defun eval-charm-line ()
  "Interpret a line of Charm"
  (interactive)
  (let ((charm-line (thing-at-point 'line t)))
    (message charm-line)))

(defun charm-repl ()
  "Open a Charm REPL in a new buffer"
  (interactive)
  (start-process "charm-repl-process" "Charm REPL" "charm"))

(add-to-list 'auto-mode-alist '("\\.charm\\'" . charm-mode))
(provide 'charm-mode)
