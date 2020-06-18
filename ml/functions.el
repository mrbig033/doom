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
  (evil-set-marker 65)
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
  (evil-goto-mark 65)
  (evil-next-line 1))

;; http://ergoemacs.org/emacs/elisp_compact_empty_lines.html
(defun xah-clean-empty-lines ()
  "Replace repeated blank lines to just 1."
  (interactive)
  (let ($begin $end)
    (if (region-active-p)
        (setq $begin (region-beginning) $end (region-end))
      (setq $begin (point-min) $end (point-max)))
    (save-excursion
      (save-restriction
        (narrow-to-region $begin $end)
        (progn
          (goto-char (point-min))
          (while (re-search-forward "\n\n\n+" nil "move")
            (replace-match "\n\n")))))))

(defun my-magit-stage-modified-and-commit ()
  (interactive)
  (progn
    (let ((current-prefix-arg '(4))) (magit-stage-modified))
    (magit-commit-create)))

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

(defun my-eval-buffer-quit ()
  (interactive)
  (eval-buffer)
  (let ((inhibit-message t))
    (save-some-buffers t)
    (quit-window)))

(defun my-eval-buffer-kill ()
  (interactive)
  (eval-buffer)
  (let ((inhibit-message t))
    (save-some-buffers t)
    (kill-current-buffer)))

;;;; REOPEN KILLED FILED ;;;;

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

(defun my-reload-file ()
  "Reopen the most recently killed file, if one exists."
  (interactive)
  (kill-this-buffer)
  (when killed-file-list
    (find-file (pop killed-file-list))))

(defun my-widen-to-center ()
  (interactive)
  (save-excursion
    (widen)
    (recenter)))

(defun my-recompile-doom ()
  (interactive)
  (let ((current-prefix-arg 4))
    (byte-force-recompile "~/.doom.d/ml/")))

(defun my-save-some-buffers ()
  (interactive)
  (save-some-buffers t 0))

(defun my-show-major-mode ()
  (interactive)
  (helpful-variable 'major-mode))

(defun my-recentf-empty ()
  (interactive)
  (setq recentf-list nil))

(defun my-goto-markdown ()
  (interactive)
  (find-file "~/.doom.d/.tmp/md.md"))

(fset 'my-dup-par
      (kmacro-lambda-form [?y ?i ?p ?\} escape ?p] 0 "%d"))

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
