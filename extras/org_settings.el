(setq org-todo-keywords '((sequence "TODO(t)" "WORK(s!)" "REVW(r!)" "|" "DONE(d!)"))
      +org-capture-todo-file "Agenda/todo.org"
      +org-capture-notes-file "Agenda/notes.org"
      +org-capture-journal-file "Agenda/journal.org"
      +org-capture-projects-file "Agenda/projects.org"
      org-ellipsis "."
      org-log-into-drawer t
      org-timer-format "%s "
      org-return-follows-link t
      org-hide-emphasis-markers t
      org-footnote-auto-adjust t
      calendar-date-style 'european
      org-confirm-babel-evaluate nil
      org-show-notification-handler nil
      org-link-file-path-type 'relative
      org-html-htmlize-output-type 'css
      org-babel-no-eval-on-ctrl-c-ctrl-c t
      org-archive-location ".%s::datetree/"
      org-outline-path-complete-in-steps nil
      org-enforce-todo-checkbox-dependencies t
      org-allow-promoting-top-level-subtree nil
      org-drawers (quote ("properties" "logbook"))
      org-id-link-to-org-use-id nil
      org-agenda-show-all-dates nil
      org-agenda-hide-tags-regexp "."
      org-tags-column 0
      org-agenda-show-outline-path nil
      org-agenda-skip-deadline-if-done t
      org-agenda-files '("~/org/Agenda")
      org-agenda-file "~/org/Agenda/agenda.org"
      org-agenda-skip-archived-trees nil
      org-agenda-skip-timestamp-if-done t
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-unavailable-files 't
      org-agenda-show-future-repeats 'next
      org-agenda-skip-timestamp-if-deadline-is-shown t
      org-agenda-skip-additional-timestamps-same-entry 't
      org-clock-persist t
      org-clock-in-resume t
      org-clock-into-drawer t
      org-clock-persist-query-resume t
      org-clock-clocked-in-display nil
      org-clock-auto-clock-resolution nil
      org-clock-sound "~/Sounds/cuckoo.au"
      org-clock-out-remove-zero-time-clocks t
      org-clock-report-include-clocking-task t
      org-edit-src-content-indentation 1
      org-edit-src-persistent-message nil
      org-edit-src-auto-save-idle-delay 1
      org-export-with-toc nil
      org-export-with-tags nil
      org-export-preserve-breaks t
      org-export-html-postamble nil
      org-export-with-broken-links t
      org-export-time-stamp-file nil
      org-export-with-todo-keywords nil
      org-export-with-archived-trees nil
      org-refile-use-outline-path 'file
      org-refile-allow-creating-parent-nodes nil
      org-refile-targets nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-src-preserve-indentation t
      org-src-ask-before-returning-to-edit-buffer nil
      org-capture-templates
      '(("t" "Todo" entry
         (file+headline org-agenda-file "Inbox")
         "* TODO %^{Title} %i\n[%<%Y-%m-%d>]\n%?")

        ("n" "Notes" entry
         (file+headline org-agenda-file "Notes")
         "* %? %i\n[%<%Y-%m-%d>]" :prepend t)
        ("j" "Journal" entry
         (file+olp+datetree org-agenda-file)
         "* %? %i" :prepend t)))
;; (org-refile-targets '((projectile-project-buffers :maxlevel . 3))


(advice-remove 'org-edit-special 'my-indent-buffer)
(advice-remove 'org-edit-src-exit 'my-indent-buffer)
