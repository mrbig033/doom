;;; ~/.doom.d/functions.el -*- lexical-binding: t; -*-

(defun my-evil-sel-to-end ()
  (interactive)
  (evil-visual-char)
  (evil-last-non-blank))

(defun my-quiet-save-buffer ()
  (interactive)
  (let ((inhibit-message t))
    (evil-ex-nohighlight)
    (save-buffer)))

(defun my-quiet-save-some-buffers ()
  (interactive)
  (let ((inhibit-message t))
    (evil-ex-nohighlight)
    (save-some-buffers t 0)))

(defun my-save-some-buffers ()
  (interactive)
  (save-some-buffers t 0))

(defun my-indent-buffer ()
  (interactive)
  (let ((inhibit-message t))
    (evil-indent
     (point-min)
     (point-max))))

;; https://stackoverflow.com/a/30697761
(defun my-sort-lines-by-length (reverse beg end)
  "sort lines by length."
  (interactive "p\nr")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ;; to make `end-of-line' and etc. to ignore fields.
          ((inhibit-field-text-motion t))
        (sort-subr reverse 'forward-line 'end-of-line nil nil
                   (lambda (l1 l2)
                     (apply #'< (mapcar (lambda (range) (- (cdr range) (car range)))
                                        (list l1 l2)))))
        (reverse-region beg end)))))

(defun my-recenter-window ()
  (interactive)
  (recenter-top-bottom
   `(4)))

;; https://stackoverflow.com/a/998472
(defun my-dup-line (arg)
  (interactive "*p")
  (setq buffer-undo-list (cons (point) buffer-undo-list))
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion
      (end-of-line)
      (setq eol (point))
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        (while (> count 0)
          (newline)
          (insert line)
          (setq count (1- count))))
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list))))
  (evil-next-line 1))

;; https://stackoverflow.com/a/998472
(defun my-comm-dup-line (arg)
  (interactive "*p")
  (setq buffer-undo-list (cons (point) buffer-undo-list))
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion
      (end-of-line)
      (setq eol (point))
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        (while (> count 0)
          (newline)
          (insert line)
          (setq count (1- count))))
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list))))
  (save-excursion
    (comment-line 1))
  (backward-char 3)
  (evil-next-line 1))
;;;; * EVAL
(defun my-eval-buffer ()
  (interactive)
  (eval-buffer)
  (let ((inhibit-message t))
    (save-some-buffers t))
  (message " buffer evaluated"))

(defun my-eval-buffer-quit ()
  (interactive)
  (eval-buffer)
  (let ((inhibit-message t))
    (save-some-buffers t)
    (quit-window)))

(defun my-eval-buffer-and-leave ()
  (interactive)
  (eval-buffer)
  (let ((inhibit-message t))
    (save-some-buffers t)
    (my-last-buffer)))

(defun my-eval-buffer-kill ()
  (interactive)
  (eval-buffer)
  (let ((inhibit-message t))
    (save-some-buffers t)
    (kill-current-buffer)))
;;;; * REOPEN KILLED FILED

(defvar killed-file-list nil
  "List of recently killed files.")

(defun add-file-to-killed-file-list ()
  "If buffer is associated with a file name, add that file to the
`killed-file-list' when killing the buffer."
  (when buffer-file-name
    (push buffer-file-name killed-file-list)))

(add-hook 'kill-buffer-hook #'add-file-to-killed-file-list)

(defun my-reopen-killed-file ()
  "Reopen the most recently killed file, if one exists."
  (interactive)
  (when killed-file-list
    (find-file (pop killed-file-list))))

(defun my-widen-to-center ()
  (interactive)
  (save-excursion
    (widen)
    (recenter)))

(defun my-save-some-buffers ()
  (interactive)
  (save-some-buffers t 0))

(defun my-backward-paragraph-do-indentation ()
  (interactive)
  (evil-backward-paragraph 2)
  (forward-to-indentation 1))

(defun my-forward-paragraph-do-indentation ()
  (interactive)
  (evil-forward-paragraph 1)
  (forward-to-indentation 1))

(defun my-backward-kill-line (arg)
  "kill arg lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(defun my-copy-directory ()
  (interactive)
  (message (kill-new (abbreviate-file-name default-directory))))

(defun my-buffer-predicate (buffer)
  (if (string-match "\*" (buffer-name buffer)) nil t))

(set-frame-parameter nil 'buffer-predicate 'my-buffer-predicate)

(setq frame-title-format '("%n"))

(defun my-silent-winner-undo ()
  (interactive)
  (cond
   ((not winner-mode) (error "Winner mode is turned off"))
   (t (unless (and (eq last-command 'winner-undo)
                   (eq winner-undo-frame (selected-frame)))
        (winner-save-conditionally)     ; current configuration->stack
        (setq winner-undo-frame (selected-frame))
        (setq winner-point-alist (winner-make-point-alist))
        (setq winner-pending-undo-ring (winner-ring (selected-frame)))
        (setq winner-undo-counter 0)
        (setq winner-undone-data (list (winner-win-data))))
      (cl-incf winner-undo-counter)	; starting at 1
      (when (and (winner-undo-this)
                 (not (window-minibuffer-p)))))))

(defun my-doom/upgrade ()
  "Run 'doom upgrade' then prompt to restart Emacs."
  (interactive)
  (doom--if-compile (format "%s -y -f upgrade" doom-bin)
      (when (y-or-n-p "You must restart Emacs for the upgrade to take effect.\n\nRestart Emacs?")
        (doom/restart-and-restore))))

(defun my-rename-file-and-buffer ()
  "rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "buffer is not visiting a file!")
      (let ((new-name (read-file-name "new name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defun my-delete-frame ()
  (interactive)
  (delete-frame nil t))

(defun my-brain-commands ()
  (interactive)
  (counsel-M-x "^org-brain- "))

(defun my-erase-kill-ring ()
  (interactive)
  (setq kill-ring nil))

(defun my-doom-kill-all-buffers (&optional buffer-list interactive)
  (interactive
   (list (if current-prefix-arg
             (doom-project-buffer-list)
           (doom-buffer-list))
         t))
  (if (null buffer-list)
      (message "No buffers to kill")
    (my-save-some-buffers)
    (delete-other-windows)
    (when (memq (current-buffer) buffer-list)
      (switch-to-buffer (doom-fallback-buffer)))
    (mapc #'kill-buffer buffer-list)
    (doom--message-or-count
     interactive "Killed %d buffers"
     (- (length buffer-list)
        (length (cl-remove-if-not #'buffer-live-p buffer-list))))))

(defun my-bash-shebang ()
  (interactive)
  (erase-buffer)
  (insert "#!/usr/bin/env bash\n\n")
  (sh-mode)
  (sh-set-shell "bash")
  (xah-clean-empty-lines)
  (forward-to-indentation)
  (evil-insert-state))

(defun my-force-evil-mode ()
  (interactive)
  (evil-mode +1)
  (evil-force-normal-state))

(defun my-artbollocks-count-words (&optional start end)
  "Count the number of words between START and END."
  (interactive)
  (let* ((s (or start (point-min)))
         (e (or end (point-max)))
         (result
          (if (fboundp 'count-words)
              (count-words s e)
            (how-many "\\w+" s e))))
    (if (called-interactively-p 'any)
        (message "%s words" result))
    result))

(fset 'my-eval-paren-macro
      (kmacro-lambda-form [?v ?a ?\( ?g ?r] 0 "%d"))

(fset 'my-eval-paragraph-macro
      (kmacro-lambda-form [?v ?i ?p ?g ?r] 0 "%d"))

(fset 'my-dup-par
      (kmacro-lambda-form [?y ?i ?p ?\} escape ?p] 0 "%d"))
