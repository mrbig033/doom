(defun my-org-force-open-other-window ()
  (interactive)
  (let ((org-link-frame-setup (quote
                               ((vm . vm-visit-folder)
                                (vm-imap . vm-visit-imap-folder)
                                (gnus . gnus)
                                (file . find-file-other-window)
                                (wl . wl)))))
    (org-open-at-point)))

(defun my-org-key-translation ()
  "Custom `org-mode' behaviours."
  ;; Buffer-local key translation from "`" to "~".
  (let ((keymap (make-sparse-keymap)))

    (set-keymap-parent keymap key-translation-map)
    (setq-local key-translation-map keymap)
    (define-key key-translation-map (kbd "s-s") (kbd "C-c '"))))

(defun my-eval-buffer-and-leave-org-source ()
  (interactive)
  (eval-buffer)
  (org-edit-src-exit))

(defun my-org-started-with-clock ()
  (interactive)
  (org-todo "STRT")
  (org-clock-in))

(defun my-org-started-with-pomodoro ()
  (interactive)
  (org-todo "STRT")
  (org-pomodoro))

(defun my-org-goto-clock-and-start-pomodoro ()
  (interactive)
  (org-clock-goto)
  (org-todo "STRT")
  (org-pomodoro))

(defun my-org-started-no-clock ()
  (interactive)
  (org-todo "STRT"))

(defun my-org-todo-done ()
  (interactive)
  (org-todo "DONE"))

(defun my-org-todo-done-pomodoro ()
  (interactive)
  (org-todo "DONE")
  (org-pomodoro))

(defun my-org-todo ()
  (interactive)
  (org-todo "TODO")
  (org-clock-out))

(defun org-today-agenda ()
  (interactive)
  (let ((current-prefix-arg 1)
        (org-deadline-warning-days 0))
    (org-agenda t "a")))

(defun org-3-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 3)
        (org-deadline-warning-days 0))
    (org-agenda t "a")))

(defun org-7-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 7)
        (org-deadline-warning-days 0))
    (org-agenda t "a")))

(defun org-30-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 30)
        (org-deadline-warning-days 0))
    (org-agenda t "a")))

(defun my-indent-buffer ()
  (interactive)
  (let ((inhibit-message t))
    (evil-indent
     (point-min)
     (point-max))))

(defun my-evil-sel-to-end ()
  (interactive)
  (evil-visual-char)
  (evil-last-non-blank))

(defun my-recenter-window ()
  (interactive)
  (recenter-top-bottom
   `(4)))

(defun my-org-hide-all-function ()
  (interactive)
  (let ((inhibit-message t))
    (let ((current-prefix-arg 1))
      (call-interactively 'org-shifttab))))
