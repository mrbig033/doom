(defvar only-insert-cmds
  '(self-insert-command newline org-return org-self-insert-command))

(defun only-insert-maybe ()
  (when (and only-insert-mode
             (memq this-command only-insert-cmds))
    (setq buffer-read-only nil)))

(defun only-insert-reset ()
  (when only-insert-mode
    (setq buffer-read-only t)))

(define-minor-mode only-insert-mode
  "Allow only char insertion to edit buffer."
  :keymap nil
  (cond (only-insert-mode
         (setq buffer-read-only t)
         (add-hook 'pre-command-hook 'only-insert-maybe nil t)
         (add-hook 'post-command-hook 'only-insert-reset nil t))
        (t
         (setq buffer-read-only nil)
         (remove-hook 'pre-command-hook 'only-insert-maybe t)
         (remove-hook 'post-command-hook 'only-insert-reset t))))
