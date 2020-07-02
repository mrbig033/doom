;;; ~/.doom.d/functions.el -*- lexical-binding: t; -*-

(defun my-evil-sel-to-end ()
  (interactive)
  (evil-visual-char)
  (evil-last-non-blank))

(defun my-quiet-save-buffer ()
  (interactive)
  (let ((inhibit-message t))
    ;; (+popup/close-all)
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

(defun my-clean-all-empty-lines ()
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
          (while (re-search-forward "\n\n+" nil "move")
            (replace-match "\n")))))))

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

(defun my-widen-to-center-with-excursion ()
  (interactive)
  (widen)
  (recenter))

(defun my-recompile-doom ()
  (interactive)
  (let ((current-prefix-arg 4))
    (byte-force-recompile "~/.doom.d/ml/")))

(defun my-save-some-buffers ()
  (interactive)
  (save-some-buffers t 0))

(defun my-show-init-times ()
  (interactive)
  (message "Emacs: %s | Doom: %ss" (my-emacs-init-time) doom-init-time))

(defun my-emacs-init-time ()
  (interactive)
  (let ((str
         (format "%ss"
                 (float-time
                  (time-subtract after-init-time before-init-time)))))
    (if (called-interactively-p 'interactive)
        (message "%s" str)
      str)))

(defun my-show-major-mode ()
  (interactive)
  (message "Major Mode: %s" major-mode))

(defun my-show-server-name ()
  (interactive)
  (message "Server Name: %s" server-name))

(defun my-recentf-empty ()
  (interactive)
  (setq recentf-list nil))

(defun my-goto-markdown ()
  (interactive)
  (find-file "~/.doom.d/.tmp/md.md"))

(defun my-goto-scratch-buffer ()
  (interactive)
  (switch-to-buffer "*scratch*"))

(defun my-goto-python-scratch ()
  (interactive)
  (find-file "~/.doom.d/.tmp/py.py"))

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

(defun my-goto-my-packages ()
  (interactive)
  (find-file "~/.doom.d/ml/my-packages.el")
  (my-recenter-window)
  (message nil))

(defun my-copy-directory ()
  (interactive)
  (message (kill-new (abbreviate-file-name default-directory))))

(defun my-last-buffer ()
  (interactive)
  (switch-to-buffer nil))

(defun my-buffer-predicate (buffer)
  (if (string-match "\*" (buffer-name buffer)) nil t))

(set-frame-parameter nil 'buffer-predicate 'my-buffer-predicate)

(setq frame-title-format '("%n"))

(define-derived-mode scratch-lisp-mode
  lisp-interaction-mode "scratch-lisp")

(general-unbind 'scratch-lisp-mode-map
  :with 'evil-ex-nohighlight
  [remap my-quiet-save-buffer]
  [remap save-buffer])

(define-derived-mode scratch-fundamental-mode
  fundamental-mode "scratch-fundamental")

(general-unbind '(scratch-fundamental-mode-map scratch-lisp-mode-map)
  :with 'evil-ex-nohighlight
  [remap my-quiet-save-buffer]
  [remap save-buffer])

(general-unbind '(scratch-fundamental-mode-map scratch-lisp-mode-map)
  :with 'quit-window
  [remap kill-current-buffer])

(general-unbind '(scratch-fundamental-mode-map scratch-lisp-mode-map)
  :with 'quit-window
  [remap my-goto-scratch-buffer]
  [remap doom/open-scratch-buffer])

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

(defun my-goto-agenda ()
  (interactive)
  (find-file org-agenda-file))

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

(defun my-goto-messages-buffer ()
  (interactive)
  (switch-to-buffer "*Messages*"))

;; https://endlessparentheses.com/emacs-narrow-or-widen-dwim.html
(defun my-narrow-or-widen-dwim (p)
  "Widen if buffer is narrowed, narrow-dwim otherwise.
With prefix P, don't widen, just narrow even if buffer
is already narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning)
                           (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing
         ;; command. Remove this first conditional if
         ;; you don't want it.
         (cond ((ignore-errors (org-edit-src-code) t)
                (delete-other-windows))
               ((ignore-errors (org-narrow-to-block) t))
               (t (org-narrow-to-subtree))))
        ((derived-mode-p 'latex-mode)
         (LaTeX-narrow-to-environment))
        (t (narrow-to-defun))))

(defun my-goto-brain-game ()
  (interactive)
  (org-brain-visualize "game"))

(defun my-prose-enable-br ()
  (interactive)
  (auto-capitalize-mode +1)
  (electric-operator-mode +1)
  (hl-sentence-mode +1)
  (pabbrev-mode +1)
  (olivetti-mode +1)
  (typo-mode +1)
  (writegood-mode -1)
  (ispell-change-dictionary "brasileiro")
  (flyspell-mode +1)
  (flyspell-buffer)
  (message "prose br"))

(defun my-prose-enable-en ()
  (interactive)
  (auto-capitalize-mode +1)
  (electric-operator-mode +1)
  (hl-sentence-mode +1)
  (pabbrev-mode +1)
  (olivetti-mode +1)
  (typo-mode +1)
  (artbollocks-mode +1)
  (ispell-change-dictionary "english")
  (flyspell-mode +1)
  (flyspell-buffer)
  (message "prose en"))

(defun my-prose-disable ()
  (interactive)
  (auto-capitalize-mode -1)
  (electric-operator-mode -1)
  (hl-sentence-mode +1)
  (pabbrev-mode -1)
  (olivetti-mode -1)
  (typo-mode -1)
  (artbollocks-mode -1)
  (flyspell-mode -1)
  (message "prose disabled"))

(defun my-zen-mode ()
  (interactive)
  (if (get 'my-zen-mode 'state)
      (progn
        (olivetti-mode -1)
        (hide-mode-line-mode -1)
        (put 'my-zen-mode 'state nil)
        (message "zen mode off"))
    (progn
      (olivetti-mode +1)
      (hide-mode-line-mode +1)
      (put 'my-zen-mode 'state t)
      (message "zen mode on"))))

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
