(setq charm-keywords
  '(("\\([^\n ]+\\) +:=" (1 font-lock-function-name-face))
    ("-?[0-9]*\\.?[0-9]+" (0 font-lock-constant-face))
    ("\".+\"[[:blank:]]+pop" (0 font-lock-comment-face))
    ("[\^\\|[:space:]]\".+\"[\$\\|[:space:]]" (0 font-lock-string-face))))

(defun charm-enable-smm ()
  "Enable the Charm Syntax Minor Mode"
  (setq font-lock-defaults '(charm-keywords))
  (setq font-lock-keywords-only t)
  (font-lock-add-keywords nil charm-keywords)
  (font-lock-flush))
(defun charm-disable-smm ()
  "Disable the Charm Syntax Minor Mode"
  (font-lock-remove-keywords nil charm-keywords))
(define-minor-mode charm-syntax-minor-mode
  "Syntax highlighting for Charm"
  nil " w/ Charm Syntax" nil
  (if charm-syntax-minor-mode (charm-enable-smm) (charm-disable-smm)))

(define-derived-mode charm-mode fundamental-mode "Charm"
  "Major mode for writing Charm code."
  (charm-syntax-minor-mode))

(defun eval-charm-line ()
  "Interpret a line of Charm"
  (interactive)
  (let ((charm-line (thing-at-point 'line t)))
    (message charm-line)))


(defvar charm-path "/usr/bin/charm")
(defun charm-repl ()
  "Open a Charm REPL in a new buffer"
  (interactive)
  (switch-to-buffer-other-window "Charm REPL")
  (make-comint-in-buffer "charm-repl-process" "Charm REPL" charm-path)
  (charm-syntax-minor-mode))

(add-to-list 'auto-mode-alist '("\\.charm\\'" . charm-mode))
(provide 'charm-mode)
