;;; ~/.doom.d/use-package.el -*- lexical-binding: t; -*-

(use-package! treemacs
  :custom
  (treemacs-width 25)
  (treemacs-indentation '(5 px))
  (treemacs-is-never-other-window t)
  (treemacs-no-delete-other-windows t)
  (doom-themes-treemacs-enable-variable-pitch nil)
  :custom-face
  (treemacs-root-face ((t (:inherit font-lock-string-face :weight bold :height 1.0))))
  :config

  (treemacs-follow-mode t)
  (treemacs-git-mode 'deferred)

  (advice-add 'treemacs-TAB-action :after #'my-recenter-window)
  (advice-add 'treemacs-RET-action :after #'my-recenter-window)
  (advice-add 'my-treemacs-visit-node-and-hide :after #'my-recenter-window)

  (general-unbind
    :keymaps 'treemacs-mode-map
    :with 'my-treemacs-nswbuff
    [remap nswbuff-switch-to-next-buffer]
    [remap nswbuff-switch-to-previous-buffer])

  (defun my-treemacs-nswbuff ()
    (interactive)
    (windmove-right)
    (nswbuff-switch-to-next-buffer))

  (general-unbind
    :keymaps 'treemacs-mode-map
    :with 'windmove-down
    [remap treemacs-next-neighbour])

  (general-unbind
    :keymaps 'treemacs-mode-map
    :with 'windmove-up
    [remap treemacs-previous-neighbour])

  (general-unbind
    :keymaps 'treemacs-mode-map
    :with 'avy-goto-char-2-above
    [remap evil-find-char-backward])

  (defun my-treemacs-commands ()
    (interactive)
    (counsel-M-x "^treemacs- "))

  (defun my-treemacs-visit-node-and-hide ()
    (interactive)
    (treemacs-RET-action)
    (treemacs))

  (treemacs-resize-icons 15))

(use-package! which-key
  :custom
  (which-key-idle-delay 0.4)
  :config
  (which-key-mode +1))

(use-package! nswbuff
  :custom
  (nswbuff-left "  ")
  (nswbuff-clear-delay 2)
  (nswbuff-delay-switch nil)
  (nswbuff-this-frame-only 't)
  (nswbuff-recent-buffers-first t)
  (nswbuff-start-with-current-centered t)
  (nswbuff-display-intermediate-buffers t)
  (nswbuff-buffer-list-function 'nswbuff-projectile-buffer-list)
  (nswbuff-exclude-buffer-regexps '("^ " "^#.*#$" "^\\*.*\\*"))
  (nswbuff-exclude-mode-regexp "info-mode\\|dired-mode\\|treemacs-mode\\|pdf-view-mode"))

(use-package! org
  :init
  (remove-hook 'org-cycle-hook 'org-optimize-window-after-visibility-change)
  (remove-hook 'org-mode-hook 'flyspell-mode)
  (add-hook 'org-cycle-hook 'org-cycle-hide-drawers)
  (add-hook! '(org-mode-hook org-src-mode-hook) #'my-org-key-translation)

  (advice-add 'org-edit-src-exit :after #'my-recenter-window)
  (advice-add 'org-edit-src-exit :before #'my-indent-buffer)

  (advice-add 'org-edit-special :after #'my-recenter-window)
  (advice-add 'org-edit-special :after #'my-indent-buffer)

  :custom
  (org-hide-emphasis-markers t)
  (org-ellipsis ".")
  (org-todo-keywords '((sequence "TODO(t)" "STRT(s!)" "|" "DONE(d!)")))
  (calendar-date-style 'european)
  (org-agenda-hide-tags-regexp ".")
  (org-agenda-show-all-dates nil)
  (org-agenda-show-future-repeats 'next)
  (org-agenda-show-outline-path nil)
  (org-agenda-skip-additional-timestamps-same-entry 't)
  (org-agenda-skip-archived-trees nil)
  (org-agenda-skip-deadline-if-done t)
  (org-agenda-skip-scheduled-if-done t)
  (org-agenda-skip-timestamp-if-deadline-is-shown t)
  (org-agenda-skip-timestamp-if-done t)
  (org-agenda-skip-unavailable-files 't)
  (org-allow-promoting-top-level-subtree nil)
  (org-archive-location ".%s::datetree/")
  (org-babel-no-eval-on-ctrl-c-ctrl-c t)
  (org-babel-temporary-directory (concat user-emacs-directory "babel-temp"))
  (org-clock-auto-clock-resolution nil)
  (org-clock-clocked-in-display nil)
  (org-clock-in-resume t)
  (org-clock-into-drawer t)
  (org-clock-out-remove-zero-time-clocks t)
  (org-clock-persist t)
  (org-clock-persist-query-resume t)
  (org-clock-report-include-clocking-task t)
  (org-clock-sound "~/Sounds/cuckoo.au")
  (org-confirm-babel-evaluate nil)
  (org-drawers (quote ("PROPERTIES" "LOGBOOK")))
  (org-enforce-todo-checkbox-dependencies t)
  (org-export-html-postamble nil)
  (org-export-preserve-breaks t)
  (org-export-time-stamp-file nil)
  (org-export-with-archived-trees nil)
  (org-export-with-broken-links t)
  (org-export-with-tags nil)
  (org-export-with-toc nil)
  (org-export-with-todo-keywords nil)
  (org-footnote-auto-adjust 't)
  (org-html-htmlize-output-type 'css)
  (org-link-file-path-type 'relative)
  (org-log-into-drawer t)
  (org-outline-path-complete-in-steps nil)
  (org-refile-allow-creating-parent-nodes nil)
  (org-refile-targets '((projectile-project-buffers :maxlevel . 3)))
  (org-refile-use-outline-path 'file)
  (org-return-follows-link t)
  (org-show-notification-handler nil)
  (org-timer-format "%s ")
  (org-src-preserve-indentation t)
  (org-src-window-setup 'current-window)
  (org-edit-src-content-indentation 1)
  (org-edit-src-persistent-message nil)
  (org-src-fontify-natively t)
  (org-src-tab-acts-natively nil)
  (org-src-ask-before-returning-to-edit-buffer nil)
  (org-edit-src-auto-save-idle-delay 0)
  (org-todo-keywords '((sequence "TODO(t)" "STRT(s!)" "|" "DONE(d!)")))

  (org-capture-templates
   '(("t" "Personal todo" entry
      (file+headline +org-capture-todo-file "Inbox") "* [ ] %? %i\nFrom: %f" :prepend t)

     ("n" "Personal notes" entry
      (file+headline +org-capture-notes-file "Inbox") "* %u %? %i \nFrom: %f" :prepend t)

     ("j" "Journal" entry
      (file+olp+datetree +org-capture-journal-file) "* %U %? %i \nFrom: %f" :prepend t)

     ("p" "Project Templates")

     ("pt" "Project - local todo" entry
      (file+headline +org-capture-project-todo-file "Inbox") "* TODO %? %i \nFrom: %f" :prepend t)

     ("pn" "Project - local notes" entry
      (file+headline +org-capture-project-notes-file "Inbox") "* %U %? %i \nFrom: %f" :prepend t)

     ("pc" "Project - local changelog" entry
      (file+headline +org-capture-project-changelog-file "Unreleased") "* %U %? %i \nFrom: %f" :prepend t)

     ("o" "Central Project Templates")

     ("ot" "Project todo" entry #'+org-capture-central-project-todo-file
      "* TODO %? %i \nFrom: %f" :heading "Tasks" :prepend nil)

     ("on" "Project notes" entry #'+org-capture-central-project-notes-file
      "* %U %? %i \nFrom: %f" :heading "Notes" :prepend t)

     ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file
      "* %U %? %i \nFrom: %f" :heading "Changelog" :prepend t)))

  :config

  (map! :map (org-mode-map evil-org-mode-map)
        :n "zi"        '+fold/open-all
        :nv "<insert>" 'org-insert-link
        "C-c o"        'my-org-force-open-other-window
        "C-l"          'recenter-top-bottom
        "s-w"          'org-edit-special)

  (map! :map (org-src-mode-map)
        "s-w" 'my-eval-buffer-and-leave-org-source)

  (org-indent-mode t)

  (setq org-agenda-files '("~/org/Agenda"))

  (defun my-org-force-open-other-window ()
    (interactive)
    (let ((org-link-frame-setup (quote
                                 ((vm . vm-visit-folder)
                                  (vm-imap . vm-visit-imap-folder)
                                  (gnus . gnus)
                                  (file . find-file-other-window)
                                  (wl . wl)))))
      (org-open-at-point)))

  ;; MAKES SOURCE BUFFER NAMES NICER
  (defun org-src--construct-edit-buffer-name (org-buffer-name lang)
    (concat "[S] "org-buffer-name""))

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
    (org-edit-src-exit)
    (my-tangle-init))

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
    (org-clock-out)))

(use-package! avy
  :custom
  (avy-case-fold-search 't)
  (avy-style 'at-full)
  (avy-timeout-seconds 0.3)
  (avy-highlight-first t)
  (avy-single-candidate-jump t)
  :custom-face
  (avy-background-face((t (:foreground "LightSkyBlue4"))))
  :config

  (add-to-list 'avy-orders-alist '(my-avy-goto-parens . avy-order-closest))


  (defun my-avy-goto-parens ()
    (interactive)
    (let ((avy-command this-command))   ; for look up in avy-orders-alist
      (avy-jump "(+")))


  (setq! avy-keys (nconc (number-sequence ?a ?z)
                         (number-sequence ?0 ?9))))

(use-package! ranger
  :hook (ranger-mode . olivetti-mode)
  :custom
  (ranger-max-tabs 0)
  (ranger-minimal nil)
  (ranger-parent-depth 1)
  (ranger-footer-delay nil)
  (ranger-preview-file nil)
  (ranger-override-dired t)
  (ranger-persistent-sort t)
  (ranger-cleanup-eagerly t)
  (ranger-dont-show-binary t)
  (ranger-width-preview 0.65)
  (ranger-width-parents 0.12)
  (ranger-max-preview-size 0.5)
  (ranger-cleanup-on-disable t)
  (ranger-return-to-ranger nil)
  (ranger-max-parent-width 0.42)
  (ranger-deer-show-details nil)
  (ranger-excluded-extensions '("mkv" "iso"
                                "mp4" "bin"
                                "exe" "msi"
                                "pdf" "doc"
                                "docx"))
  :config

  (defun my-ranger-go (path)
    "Go subroutine"
    (interactive
     (list
      (read-char-choice
       "
    d: dotfiles  n : downloads  s : scripts   m: doom
    e/E: emacs   o : org        f: config     q: quit
    h: home      p/a: py/alien  c: documents
  > "
       '(?a ?d ?e ?E ?h ?i ?n ?o ?p ?s ?f ?c ?m ?q))))
    (message nil)
    (let* ((c (char-to-string path))
           (new-path
            (cl-case (intern c)
              ('d "~/dotfiles")
              ('e "~/.emacs.d")
              ('E "~/emacs/.emacs.d.back")
              ('m "~/.doom.d")
              ('h "~")
              ('n "~/Downloads")
              ('o "~/org")
              ('p "~/Documents/Python")
              ('a "~/Documents/Python/proj/alien")
              ('s "~/scripts")
              ('f "~/.config")
              ('c "~/Documents")
              ('q "quit")
              ('i "quit")))
           (alt-option
            (cl-case (intern c)
              ;; Subdir Handlng
              ('j 'ranger-next-subdir)
              ('k 'ranger-prev-subdir)
              ;; Tab Handling
              ('n 'ranger-new-tab)
              ('T 'ranger-prev-tab)
              ('t 'ranger-next-tab)
              ('c 'ranger-close-tab)
              ('g 'ranger-goto-top))))
      (when (string-equal c "q")
        (keyboard-quit))
      (when (and new-path (file-directory-p new-path))
        (ranger-find-file new-path))
      (when (eq system-type 'windows-nt)
        (when (string-equal c "D")
          (ranger-show-drives)))
      (when alt-option
        (call-interactively alt-option))))

  (defun my-deer-goto-my-lisp ()
    (interactive)
    (deer "~/.doom.d/my-lisp/my-packages.el"))

  (defun my-deer-goto-python ()
    (interactive)
    (deer "~/Documents/Python/"))

  (defun my-ranger-toggle-mark-and-advance ()
    (interactive)
    (ranger-toggle-mark)
    (ranger-next-file 1)))
