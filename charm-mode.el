(setq charm-keywords
  '(("\\([^\n ]+\\) +:=" (1 font-lock-function-name-face))
    ("-?[0-9]*\\.?[0-9]+" (0 font-lock-constant-face))
    ("\".+\"[[:blank:]]+pop" (0 font-lock-comment-face))
    ("[\^\\|[:space:]]\".+\"[\$\\|[:space:]]" (0 font-lock-string-face))))
(defconst charm-buffer "Charm REPL")
(defconst charm-path "/usr/bin/charm")


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

(defun charm-eval-line ()
  "Interpret a line of Charm in the Charm REPL."
  (interactive)
  (let ((charm-line (thing-at-point 'line t)))
                                        ; make sure that we make the buffer in a new frame if it's not already there -- to avoid replacing our code with the repl
    (when (null (get-buffer charm-buffer))
      (switch-to-buffer-other-window charm-buffer))
    (charm-repl)
    (insert charm-line)
    (comint-send-input)
    (message charm-line)))

(defun charm-repl-here ()
  "Open a Charm REPL in the Charm REPL buffer."
  (make-comint-in-buffer "charm-repl-process" charm-buffer charm-path))

(defun charm-repl ()
  "Open a Charm REPL in a new or existing buffer."
  (interactive)
  (setq comint-prompt-read-only t)
  (if (get-buffer charm-buffer)
      (pop-to-buffer charm-buffer)
    (switch-to-buffer charm-buffer))
  (charm-repl-here)
  (charm-syntax-minor-mode))

(add-to-list 'auto-mode-alist '("\\.charm\\'" . charm-mode))
(provide 'charm-mode)
