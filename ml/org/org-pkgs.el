(use-package! org
  :init
  (remove-hook 'org-mode-hook 'flyspell-mode)
  (remove-hook 'org-cycle-hook 'org-optimize-window-after-visibility-change)
  ;; (add-hook 'org-cycle-hook 'org-cycle-hide-drawers)
  (add-hook 'org-agenda-mode-hook 'hl-line-mode)
  (add-hook 'org-mode-hook (lambda () (org-indent-mode t)))

  (add-hook! 'org-cycle-hook
             #'org-cycle-hide-archived-subtrees
             #'org-cycle-hide-drawers
             #'org-cycle-show-empty-lines)

  :general
  (:keymaps   '(evil-org-mode-map org-mode-map)
   "C-c j"   'org-metadown
   "C-c k"   'org-metaup
   "C-j" 'treemacs-select-window)
  (:keymaps   '(doom-leader-map)
   ;; "aa"        'org-agenda
   "at"        'org-today-agenda
   "a3"        'org-3-days-agenda
   "a7"        'org-7-days-agenda
   "a0"        'org-30-days-agenda)

  :custom
  (+org-capture-todo-file "Agenda/todo.org")
  (+org-capture-notes-file "Agenda/notes.org")
  (+org-capture-journal-file "Agenda/journal.org")
  (+org-capture-projects-file "Agenda/projects.org")
  (org-ellipsis ".")
  (org-log-into-drawer t)
  ;; (org-tab-follows-link 't)
  (org-timer-format "%s ")
  (org-return-follows-link t)
  (org-hide-emphasis-markers t)
  (org-footnote-auto-adjust t)
  (calendar-date-style 'european)
  (org-confirm-babel-evaluate nil)
  (org-show-notification-handler nil)
  (org-link-file-path-type 'relative)
  (org-html-htmlize-output-type 'css)
  (org-babel-no-eval-on-ctrl-c-ctrl-c t)
  (org-archive-location ".%s::datetree/")
  (org-outline-path-complete-in-steps nil)
  (org-enforce-todo-checkbox-dependencies t)
  (org-allow-promoting-top-level-subtree nil)
  (org-drawers (quote ("properties" "logbook")))
  ;; (org-todo-keywords '((sequence "TODO(t)" "STRT(s!)" "|" "DONE(d!)")))
  (org-todo-keywords '((sequence "TODO(t)" "WORK(s!)" "REVW(r!)" "|" "DONE(d!)")))
  (org-babel-temporary-directory (concat user-emacs-directory "babel-temp"))
  (org-id-link-to-org-use-id t)
  (org-agenda-show-all-dates nil)
  (org-agenda-hide-tags-regexp ".")
  ;; (org-tags-column -77)
  (org-tags-column 0)
  (org-agenda-show-outline-path nil)
  (org-agenda-skip-deadline-if-done t)
  (org-agenda-files '("~/org/Agenda"))
  (org-agenda-file "~/org/Agenda/agenda.org")
  (org-agenda-skip-archived-trees nil)
  (org-agenda-skip-timestamp-if-done t)
  (org-agenda-skip-scheduled-if-done t)
  (org-agenda-skip-unavailable-files 't)
  (org-agenda-show-future-repeats 'next)
  (org-agenda-skip-timestamp-if-deadline-is-shown t)
  (org-agenda-skip-additional-timestamps-same-entry 't)
  (org-clock-persist t)
  (org-clock-in-resume t)
  (org-clock-into-drawer t)
  (org-clock-persist-query-resume t)
  (org-clock-clocked-in-display nil)
  (org-clock-auto-clock-resolution nil)
  (org-clock-sound "~/Sounds/cuckoo.au")
  (org-clock-out-remove-zero-time-clocks t)
  (org-clock-report-include-clocking-task t)
  (org-edit-src-content-indentation 1)
  (org-edit-src-persistent-message nil)
  (org-edit-src-auto-save-idle-delay 0)
  (org-export-with-toc nil)
  (org-export-with-tags nil)
  (org-export-preserve-breaks t)
  (org-export-html-postamble nil)
  (org-export-with-broken-links t)
  (org-export-time-stamp-file nil)
  (org-export-with-todo-keywords nil)
  (org-export-with-archived-trees nil)
  (org-refile-use-outline-path 'file)
  (org-refile-allow-creating-parent-nodes nil)
  ;; (org-refile-targets '((projectile-project-buffers :maxlevel . 3)))
  (org-refile-targets nil)
  (org-src-fontify-natively t)
  (org-src-tab-acts-natively nil)
  (org-src-preserve-indentation t)
  (org-src-window-setup 'current-window)
  (org-src-ask-before-returning-to-edit-buffer nil)

  (org-capture-templates
   '(("t" "Todo" entry
      (file+headline org-agenda-file "Inbox")
      "* TODO %^{Title} %i\n[%<%Y-%m-%d>]\n%?")

     ("n" "Notes" entry
      (file+headline org-agenda-file "Notes")
      "* %? %i\n[%<%Y-%m-%d>]" :prepend t)
     ("j" "Journal" entry
      (file+olp+datetree org-agenda-file)
      "* %? %i" :prepend t)))

  :config

  (add-hook! '(org-mode-hook org-src-mode-hook) #'my-org-key-translation)
  (advice-add 'org-edit-special :after #'my-indent-buffer)
  (advice-add 'org-edit-special :after #'my-recenter-window)
  (advice-add 'org-edit-src-exit :before #'my-indent-buffer)
  (advice-add 'org-edit-src-exit :after #'my-recenter-window)

  (load! "~/.doom.d/ml/extras/org_defun.el")
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines)))

(use-package! org-roam
  ;; :after org
  :init
  (require 'org-roam-protocol)
  (add-hook 'org-roam-mode-hook 'hide-mode-line-mode)
  (add-hook 'org-roam-mode-hook 'abbrev-mode)
  :custom

  (org-roam-buffer-window-parameters '((no-other-window . t)))

  (org-roam-graph-edge-extra-config '(("arrowhead" . "odot")
                                      ("arrowtail" . "normal")
                                      ("dir" . "back")))

  (org-roam-graph-extra-config '(("rankdir" . "RL")))

  (org-roam-graph-node-extra-config '(("shape" . "underline")
                                      ("style" . "rounded,filled")
                                      ("fillcolor" . "#FFFFD7")
                                      ("color" . "#C9C9C9")

                                      ("fontcolor" . "#111111")))

  (org-roam-capture-templates '(("d" "default" plain
                                 #'org-roam-capture--get-point "%?"
                                 :file-name "${slug}-%<%C%m>"
                                 :head "#+title: ${title}"
                                 :unnarrowed t)))
  (org-roam-graph-exclude-matcher '("index.org"
                                    "afc_bboba-2006.org"
                                    "phil-2006.org"
                                    "ethics-2006.org"
                                    "logic_org-2006"
                                    "animalw-2006.org"
                                    "petitio_principii-2006.org"
                                    "conseq-2006.org"))

  ;; possible values: dot (default) neato fdp sfdp twopi circles circo
  (org-roam-graph-executable "dot")
  (org-roam-graph-viewer "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")

  (org-roam-directory "~/org/Data/roam")
  (org-roam-buffer-width 0.25)
  (org-roam-index-file "~/org/Data/roam/index.org")
  (:keymaps '(doom-leader-map)
   "SPC rf" 'org-roam-find-file
   "SPC rl" 'org-roam-find-file
   "SPC rj" 'org-roam-jump-to-index
   "SPC rb" 'org-roam-switch-to-buffer
   "SPC rg" 'org-roam-graph
   "SPC ri" 'org-roam-insert
   "SPC rç" 'org-roam
   "SPC rc" 'org-roam-db-build-cache
   "SPC rx" 'my-roam-indexes
   "SPC ro" 'my-roam-logic
   "SPC ra" 'my-roam-fallacies
   "SPC rs" 'my-show-org-roam-commands)

  :config

  (defun my-org-roam-open-link ()
    (interactive)
    (my-org-force-open-other-window)
    (delete-other-windows))

  (defun my-show-org-roam-commands ()
    (interactive)
    (counsel-M-x "^org-roam- "))

  (defun my-roam-indexes ()
    (interactive)
    (org-roam-find-file "index "))

  (defun my-roam-logic ()
    (interactive)
    (org-roam-find-file "logic "))

  (defun my-roam-fallacies ()
    (interactive)
    (org-roam-find-file "fallacy ")))

(use-package! org-web-tools
  :general
  (:keymaps '(doom-leader-map)
   "mwi"    'org-web-tools-insert-link-for-url
   "mwe"    'org-web-tools-archive-view
   "mwv"    'org-web-tools-archive-attach
   "mwr"    'org-web-tools-read-url-as-org
   "mwc"    'org-web-tools-convert-links-to-page-entries))

(use-package! org-pomodoro
  :after org
  :config
  (setq org-pomodoro-offset 1
        org-pomodoro-start-sound-args t
        org-pomodoro-length (* 25 org-pomodoro-offset)
        org-pomodoro-short-break-length (/ org-pomodoro-length 5)
        org-pomodoro-long-break-length (* org-pomodoro-length 0.8)
        org-pomodoro-long-break-frequency 4
        org-pomodoro-ask-upon-killing nil
        org-pomodoro-manual-break t
        org-pomodoro-keep-killed-pomodoro-time t
        org-pomodoro-time-format "%.2m"
        org-pomodoro-short-break-format "short: %s"
        org-pomodoro-long-break-format "long: %s"
        org-pomodoro-format "p: %s"))

(use-package! org2blog
  :custom
  (org2blog/wp-show-post-in-browser 'dont)

  (org2blog/wp-blog-alist
   '(("daviramos-en"
      :url "http://daviramos.com/en/xmlrpc.php"
      :username "daviramos"
      :default-title "hello world"
      :default-categories ("sci-fi")
      :tags-as-categories nil)
     ("daviramos-br"
      :url "http://daviramos.com/br/xmlrpc.php"
      :username "daviramos"
      :default-title "hello world"
      :default-categories ("sci-fi")
      :tags-as-categories nil)))
  :config
  (advice-add 'org2blog-buffer-post-publish :after #'my-silent-winner-undo))
