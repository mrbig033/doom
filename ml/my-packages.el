;;; ~/.doom.d/use-package.el -*- lexical-binding: t; -*-

(use-package! hydra
  :config
  (map! :leader "j" 'hydra-org-clock/body))

(use-package! treemacs
  :commands treemacs-select-window
  :custom
  (treemacs-width 25)
  (treemacs-indentation '(5 px))
  (treemacs-show-hidden-files nil)
  (treemacs-is-never-other-window t)
  (treemacs-no-delete-other-windows t)
  (doom-themes-treemacs-enable-variable-pitch nil)
  :custom-face
  (treemacs-root-face ((t (:inherit font-lock-string-face
                           :weight bold
                           :height 1.0))))

  :general

  (:keymaps   '(global)
   "C-0"      'my-treemacs-quit
   "C-j"      'treemacs-select-window)
  (:keymaps   '(treemacs-mode-map evil-treemacs-state-map)
   "C-j"      'my-treemacs-visit-node-and-hide
   "C-p"      'treemacs-previous-project
   "C-n"      'treemacs-next-project
   "C-c t"    'my-show-treemacs-commands
   "C-c D"    'treemacs-delete
   "C-c pa"   'treemacs-projectile
   "C-c pd"   'treemacs-remove-project-from-workspace
   "<escape>" 'treemacs-quit
   "<insert>" 'treemacs-create-file
   "tp"       'move-file-to-trash
   "çm"       'treemacs-create-dir
   "zm"       'treemacs-collapse-all-projects)

  (:states '(normal visual)
   :prefix "SPC"
   "pA" 'treemacs-add-and-display-current-project)

  :config

  (add-to-list 'treemacs-pre-file-insert-predicates
               #'treemacs-is-file-git-ignored?)

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

  (defun my-treemacs-quit ()
    (interactive)
    (treemacs-select-window)
    (treemacs-quit))

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
  (which-key-add-key-based-replacements

    "SPC mwi"  "OW Insert"
    "SPC mwe"  "OW Archive"
    "SPC mwv"  "OW Attach"
    "SPC mwr"  "OW Read As Org"
    "SPC mwc"  "OW Links to Entries"

    "çf"  "Roam Find-File"
    "çj"  "Roam Index"
    "çl"  "Roam Find-File"
    "çb"  "Roam Switch Buffer"
    "çg"  "Roam Graph"
    "çi"  "Roam Insert"
    "çd"  "Roam Deft"
    "çc"  "Roam Re-Cache"
    "çx"  "Roam Indexes"
    "ço"  "Roam Logic"
    "ça"  "Roam Fallacies"
    "çç"  "Roam"


    "C-ç f"  "Roam Find-File"
    "C-ç j"  "Roam Index"
    "C-ç b"  "Roam Switch Buffer"
    "C-ç g"  "Roam Graph"
    "C-ç i"  "Roam Insert"
    "C-ç d"  "Roam Deft"
    "C-ç c"  "Roam Re-Cache"
    "C-ç ç"  "Roam"

    "SPC sW"  "Wordnut Search"
    "SPC sw"  "Wornut Word"
    "SPC te"  "HL Sentence"
    "SPC br"  "Popup Raise"
    "SPC mgx" "Org Last"
    "SPC nrn" "Index"
    "SPC nrc" "Capture"
    "SPC nrb" "Switch Buffer"
    "SPC tc"  "Clean Lines"
    "SPC td"  "Dup Lines"
    "SPC tv"  "Visible Mode"
    "SPC to"  "Olivetti Mode"
    "SPC ti"  "Dup Par"
    "SPC tS"  "Sort by Len"
    "SPC bY"  "Yank Dir"
    "SPC fk"  "Search Pkgs"
    "SPC cw"  "Count Words"
    "SPC nn"  "Narrow Dwin"
    "SPC nw"  "Widen"
    "SPC ba"  "Goto Markdown"
    "SPC meb" "Eval Buffer"
    "SPC med" "Eval Defun"
    "SPC mer" "Eval Region")
  (which-key-mode +1))

(use-package! nswbuff
  :general
  (:keymaps 'override
   :states '(normal visual insert)
   "M-," 'nswbuff-switch-to-previous-buffer
   "M-." 'nswbuff-switch-to-next-buffer)

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

  (add-hook 'org-cycle-hook 'org-cycle-hide-drawers)
  (add-hook 'org-mode-hook (lambda () (org-indent-mode t)))
  (add-hook! '(org-mode-hook org-src-mode-hook) #'my-org-key-translation)

  (remove-hook 'org-cycle-hook 'org-optimize-window-after-visibility-change)
  (remove-hook 'org-mode-hook 'flyspell-mode)

  (advice-add 'org-edit-src-exit :after #'my-recenter-window)
  (advice-add 'org-edit-src-exit :before #'my-indent-buffer)
  (advice-add 'org-edit-special :after #'my-recenter-window)
  (advice-add 'org-edit-special :after #'my-indent-buffer)

  :general

  (:keymaps     'org-capture-mode-map
   :states      '(normal visual insert)
   "<M-return>" 'org-capture-finalize)

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
  (org-footnote-auto-adjust 't)
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
  (org-drawers (quote ("PROPERTIES" "LOGBOOK")))
  (org-todo-keywords '((sequence "TODO(t)" "STRT(s!)" "|" "DONE(d!)")))
  (org-todo-keywords '((sequence "TODO(t)" "STRT(s!)" "|" "DONE(d!)")))
  (org-babel-temporary-directory (concat user-emacs-directory "babel-temp"))

  (org-agenda-show-all-dates nil)
  (org-agenda-hide-tags-regexp ".")
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
  (org-refile-targets '((projectile-project-buffers :maxlevel . 3)))

  (org-src-fontify-natively t)
  (org-src-tab-acts-natively nil)
  (org-src-preserve-indentation t)
  (org-src-window-setup 'current-window)
  (org-src-ask-before-returning-to-edit-buffer nil)

  (org-capture-templates
   '(("t" "Todo" entry
      (file+headline org-agenda-file "Inbox")
      "* TODO %? %i\n:DEADLINE: %^t")

     ("n" "Notes" entry
      (file+headline org-agenda-file "Notes")
      "* [%<%y-%m-%d>] %? %i" :prepend t)

     ("j" "Journal" entry
      (file+olp+datetree org-agenda-file)
      "* %? %i" :prepend t)

     ;; ("p" "Projects")

     ;; ("pt" "Project - local todo" entry
     ;;  (file+headline +org-capture-project-todo-file "Inbox")
     ;;  "* TODO %? %i" :prepend t)

     ;; ("pn" "Project - local notes" entry
     ;;  (file+headline +org-capture-project-notes-file "Inbox")
     ;;  "* %U %? %i" :prepend t)

     ;; ("pc" "Project - local changelog" entry
     ;;  (file+headline +org-capture-project-changelog-file "Unreleased")
     ;;  "* %U %? %i" :prepend t)

     ;; ("ot" "Project todo" entry #'+org-capture-central-project-todo-file
     ;;  "* TODO %? %i" :heading "Tasks" :prepend nil)

     ;; ("on" "Project notes" entry #'+org-capture-central-project-notes-file
     ;;  "* %U %? %i" :heading "Notes" :prepend t)

     ;; ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file
     ;;  "* %U %? %i" :heading "Changelog" :prepend t)

     ;; ("o" "Central Projects")
     ))

  :config
  (setq! org-id-link-to-org-use-id t)

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
  (defun org-src--construct-edit-buffer-name (org-buffer-name)
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
    (org-clock-out)))

(use-package! org-roam
  :after org
  :init
  (require 'org-roam-protocol)
  (add-hook 'org-roam-mode-hook 'hide-mode-line-mode)
  (add-hook 'org-roam-mode-hook 'abbrev-mode)
  :custom

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
  (org-roam-graph-exclude-matcher '("index"
                                    "bboba"
                                    "phil"
                                    "ethics"
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
  :config
  (setq! org-roam-buffer-window-parameters '((no-other-window . t)))

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

(use-package! deft
  :after org

  :general

  (:keymaps   'deft-mode-map
   :states    'normal
   "q"        'quit-window
   "<escape>" 'quit-window
   "m"        'widget-button-press)

  (:keymaps   'deft-mode-map
   :states    'insert
   "<escape>" 'quit-window
   "C-h" 'deft-filter-decrement)

  :custom
  (deft-separator " - ")
  (deft-extensions '("org"))
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory  "~/org/Data/roam"))

(use-package! avy

  :general
  (:states '(normal visual)
   "g9"      'my-avy-goto-open-paren
   "g0"      'my-avy-goto-close-paren
   "F"       'evil-avy-goto-char-2-above
   "f"       'evil-avy-goto-char-2-below)

  :custom
  (avy-case-fold-search 't)
  (avy-style 'at-full)
  (avy-timeout-seconds 0.3)
  (avy-highlight-first t)
  (avy-single-candidate-jump t)
  :custom-face
  (avy-background-face((t (:foreground "LightSkyBlue3"))))
  :config

  (add-to-list 'avy-orders-alist '(my-avy-goto-parens . avy-order-closest))

  (defun my-avy-goto-open-paren ()
    (interactive)
    (let ((avy-command this-command))   ; for look up in avy-orders-alist
      (avy-jump "(+")))

  (defun my-avy-goto-close-paren ()
    (interactive)
    (let ((avy-command this-command))   ; for look up in avy-orders-alist
      (avy-jump ")+")))
  (setq! avy-keys (nconc (number-sequence ?a ?z)
                         (number-sequence ?0 ?9))))

(use-package! ranger
  :demand t
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

  :general

  (:keymaps     'ranger-mode-map
   "çm"         'dired-create-directory
   "r"          'ranger-refresh
   "<insert>"   'dired-create-empty-file
   "i"          'my-ranger-go
   "M-9"        'delete-other-windows
   "tp"         'move-file-to-trash
   "C-c 0"      'move-file-to-trash
   "<escape>"   'ranger-close
   "m"          'my-ranger-toggle-mark-and-advance
   "gg"         'ranger-goto-top
   "zp"         'ranger-preview-toggle
   "çcm"        'dired-create-directory
   "C-c l"      'counsel-find-file
   "d"          'dired-do-flagged-delete
   "x"          'diredp-delete-this-file
   "d"          'dired-flag-file-deletion
   "<c-return>" 'dired-do-find-marked-files)

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

(use-package! ivy
  :custom
  (counsel-grep-swiper-limit 300000)
  (ivy-extra-directories nil)
  (counsel-outline-display-style 'title)
  (counsel-find-file-at-point t)
  (counsel-bookmark-avoid-dired t)
  (ivy-count-format "")
  ;; (ivy-count-format "%-2d ")

  (counsel-ag-base-command "ag --filename --nocolor --nogroup --smart-case --skip-vcs-ignores --silent --ignore '*.html' --ignore '*.elc' --ignore 'flycheck*' %s")

  (ivy-ignore-buffers '("^#.*#$"
                        "^\\*.*\\*"
                        "^agenda.org$"
                        "magit"
                        "*org-src-fontification.\\*"))
  :general

  (:states '(normal visual insert)
   "C-s" 'counsel-grep-or-swiper
   "M-y" 'counsel-yank-pop
   "C-," 'ivy-switch-buffer
   "C-." 'counsel-M-x)

  (:keymaps 'counsel-describe-map
   "C-." 'ivy-next-line
   "C-," 'counsel-find-symbol)

  (:keymaps '(ivy-minibuffer-map ivy-switch-buffer-map)
   "M-y"      'ivy-next-line
   "M-r"      'ivy-next-line
   "C-,"      'ivy-next-line
   "C-."      'ivy-next-line
   "C-/"      'ivy-next-line
   "C-j" 'ivy-immediate-done
   "M-q"      'ivy-done
   "<insert>" 'yank
   "C-k"      'kill-line
   "C-d"      'delete-char
   "C-h"      'delete-backward-char
   "C-w"      'backward-kill-word
   "<insert>" 'yank)

  :config
  ;; https://github.com/abo-abo/swiper/issues/2588#issuecomment-637042732
  (setq swiper-use-visual-line-p #'ignore)

  (defun my-search-settings ()
    (interactive)
    (counsel-ag nil "~/.doom.d/ml/"))

  (defun my-search-packages ()
    (interactive)
    (counsel-ag  "(use-package\\! "  "~/.doom.d/ml/"))

  (defun my-swiper-python-classes ()
    (interactive)
    (swiper  "^class "))

  (defun my-swiper-python-functions ()
    (interactive)
    (swiper  "def "))

  (defun my-search-python-classes ()
    (interactive)
    (counsel-ag  "^class "))

  (defun my-search-python-function ()
    (interactive)
    (counsel-ag  "def "))

  (defun ivy-with-thing-at-point (cmd)
    (let ((ivy-initial-inputs-alist
           (list
            (cons cmd (thing-at-point 'symbol)))))
      (funcall cmd)))

  (defun counsel-ag-thing-at-point ()
    (interactive)
    (ivy-with-thing-at-point 'counsel-ag)))

(use-package! evil-smartparens
  :after evil
  :config
  (map! :map evil-smartparens-mode-map
        :v "o" 'exchange-point-and-mark))

(use-package! python
  :init

  (add-hook! '(python-mode-hook inferior-python-mode-hook)
             #'rainbow-delimiters-mode
             #'electric-operator-mode
             #'evil-smartparens-mode
             #'smartparens-strict-mode
             #'yafolding-mode
             #'evil-swap-keys-swap-double-single-quotes
             #'evil-swap-keys-swap-underscore-dash
             #'evil-swap-keys-swap-colon-semicolon
             #'(lambda () (setq-local fill-column 57)))

  (add-hook! 'python-mode-hook
             #'elpy-mode
             #'apheleia-mode)

  :custom
  (python-indent-guess-indent-offset-verbose nil)
  :config

  ;; (add-to-list 'undo-fu-session-incompatible-major-modes #'python-mode)
  (defun my-quickrun-shell ()
    (interactive)
    (quickrun-shell)
    (other-window 1))

  (set-company-backend!
    'python-mode
    'elpy-company-backend
    '(company-files :with company-yasnippet)
    '(company-dabbrev-code :with company-keywords company-dabbrev))

  (set-company-backend!
    'inferior-python-mode
    'elpy-company-backend
    '(company-files :with company-yasnippet)
    '(company-dabbrev-code :with company-keywords company-dabbrev))

  (map! :map python-mode-map
        ;; "C-c y" 'engine/search-python-3
        ;; "C-c g" 'engine/search-pygame-docs
        ;; "C-c d" 'engine/search-python-3-docs
        ;; "<M-backspace>"   'apheleia-format-buffer
        "M-p" 'my-backward-paragraph-do-indentation
        "M-n" 'my-forward-paragraph-do-indentation
        "C-c ç" 'my-python-shebang
        "C-ç" 'elpy-shell-switch-to-shell
        "M-a"   'python-nav-backward-statement
        "M-e"   'python-nav-forward-statement
        :i "C-=" 'my-python-colon-newline
        :i "C-h"'python-indent-dedent-line-backspace
        :n "ç" 'hydra-python-mode/body
        :nv "zi" 'yafolding-show-all
        :nv "zm" 'yafolding-toggle-all
        :nv "TAB" 'yafolding-toggle-element
        :nv "<backtab>" 'yafolding-toggle-all
        :nv "<return>" 'hydra-python-mode/body
        :nv "<" 'python-indent-shift-left
        :nv ">" 'python-indent-shift-right
        :nvi "<C-return>" 'my-quickrun)

  (map! :map inferior-python-mode-map
        "C-ç" 'my-elpy-switch-to-buffer
        :i "C-l" 'comint-clear-buffer)

  (defun my-quickrun ()
    (interactive)
    (quickrun)
    ;; (sit-for 0.5)
    (windmove-down)
    ;; (compilation-next-error 1)
    )

  (defun my-python-shebang ()
    (interactive)
    (kill-region (point-min) (point-max))
    (insert "#!/usr/bin/env python3\n\n")
    (evil-insert-state))

  (defun my-python-colon-newline ()
    (interactive)
    (end-of-line)
    (insert ":")
    (newline-and-indent)))

(use-package! elpy
  :custom
  (elpy-rpc-virtualenv-path 'current)
  :config

  (map! :map elpy-mode-map
        "C-x m" 'elpy-multiedit-python-symbol-at-point
        "C-x M" 'elpy-multiedit-stop)

  (advice-add 'elpy-goto-definition :after #'my-recenter-window)
  (advice-add 'elpy-goto-assignment :after #'my-recenter-window)

  (defun my-elpy-switch-to-buffer ()
    (interactive)
    (elpy-shell-switch-to-buffer)
    (quit-windows-on "*Python*"))

  (elpy-enable))

(use-package! evil-swap-keys
  :after evil
  :config
  (defun evil-swap-keys-swap-dash-underscore ()
    "Swap the underscore and the dash."
    (interactive)
    (evil-swap-keys-add-pair "-" "_")))

(use-package! eyebrowse
  :custom

  (eyebrowse-wrap-around t)
  (eyebrowse-new-workspace t)
  (eyebrowse-mode-line-style 'smart)
  (eyebrowse-switch-back-and-forth t)
  (eyebrowse-mode-line-left-delimiter " [ ")
  (eyebrowse-mode-line-right-delimiter " ]  ")
  (eyebrowse-mode-line-separator " | ")

  :general

  ("M-q" 'eyebrowse-prev-window-config
   "M-w" 'eyebrowse-next-window-config)
  (:keybindings '(treemacs-mode-map evil-treemacs-state-map)
   "<escape>"   'treemacs-quit)
  (:states '(normal visual)
   :prefix "SPC"
   "1" 'eyebrowse-switch-to-window-config-1
   "2" 'eyebrowse-switch-to-window-config-2
   "3" 'eyebrowse-switch-to-window-config-3
   "4" 'eyebrowse-switch-to-window-config-4
   "v" 'eyebrowse-create-window-config
   "x" 'eyebrowse-close-window-config
   )

  :config

  (eyebrowse-mode +1))

(use-package! doom-modeline
  :custom
  (doom-modeline-percent-position '(-3 "%p"))
  (doom-modeline-env-version nil)
  (doom-modeline-env-enable-go nil)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-buffer-state-icon nil)
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-enable-word-count nil)
  (doom-modeline-env-enable-ruby nil)
  (doom-modeline-env-enable-perl nil)
  (doom-modeline-env-enable-rust nil)
  (doom-modeline-env-enable-python nil)
  (doom-modeline-env-enable-elixir nil)
  (doom-modeline-env-load-string ".")
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-checker-simple-format t)
  (doom-modeline-buffer-modification-icon nil)
  (doom-modeline-buffer-file-name-style 'buffer-name))

(use-package! company
  :custom
  (company-ispell-dictionary "brazilian")
  (company-minimum-prefix-length 1)
  (company-show-numbers t)
  (company-tooltip-limit 10)
  (company-dabbrev-other-buffers t)
  (company-selection-wrap-around t)
  (company-auto-complete nil)
  (company-dabbrev-ignore-case 'keep-prefix)
  (company-global-modes '(not erc-mode message-mode help-mode gud-mode eshell-mode))
  :config
  (setq-default company-call-backends '(company-capf
                                        company-yasnippet
                                        company-shell
                                        company-shell-env
                                        company-files
                                        company-semantic
                                        (company-dabbrev-code
                                         company-gtags
                                         company-etags
                                         company-keywords)
                                        company-dabbrev))

  (map! :map company-active-map
        "M-e" 'my-company-yasnippet
        "C-y" 'company-yasnippet
        "M-q" 'company-complete-selection
        "M-w" 'my-company-comp-with-paren
        "M-." 'my-company-comp-with-dot
        "M-j" 'my-company-comp-space
        "C-h" 'delete-backward-char
        "M-0" 'company-complete-number
        "M-1" 'company-complete-number
        "M-2" 'company-complete-number
        "M-3" 'company-complete-number
        "M-4" 'company-complete-number
        "M-5" 'company-complete-number
        "M-6" 'company-complete-number
        "M-7" 'company-complete-number
        "M-8" 'company-complete-number
        "M-9" 'company-complete-number)

  (defun my-company-yasnippet ()
    (interactive)
    (company-abort)
    (yas-expand))

  (defun my-company-comp-with-paren ()
    (interactive)
    (company-complete-selection)
    (insert "()")
    (backward-char))

  (defun my-company-comp-with-dot ()
    (interactive)
    (company-complete-selection)
    (insert ".")
    (company-complete))

  (defun my-company-comp-space ()
    (interactive)
    (company-complete-selection)
    (insert " ")))

(use-package! super-save
  :after-call (pre-command-hook after-find-file super-save-mode)
  :custom
  (auto-save-default nil)
  (super-save-idle-duration 5)
  (super-save-auto-save-when-idle nil)
  (super-save-triggers
   '(quickrun
     quit-window
     eval-buffer
     my-last-buffer
     windmove-up
     windmove-down
     windmove-left
     windmove-right
     switch-to-buffer
     delete-window
     eyebrowse-close-window-config
     eyebrowse-create-window-config
     eyebrowse-prev-window-config))

  :config

  (super-save-mode t))

(use-package! pdf-view
  :init

  (add-hook 'pdf-outline-buffer-mode-hook (lambda () (toggle-truncate-lines +1)))

  :general

  (:keymaps   'pdf-view-mode-map
   :states '(normal visual)
   "H"        'pdf-history-backward
   "L"        'pdf-history-forward
   "C-s"      'pdf-occur
   "<escape>" 'ignore
   "TAB"      'pdf-outline
   "o"      'pdf-outline
   "q"        'quit-window
   "w"        'pdf-view-fit-width-to-window
   "h"        'pdf-view-scroll-up-or-next-page
   "l"        'pdf-view-scroll-down-or-previous-page
   "j"        'pdf-view-next-page
   "k"        'pdf-view-previous-page
   "p"        'pdf-view-previous-line-or-previous-page
   "n"        'pdf-view-next-line-or-next-page
   "K"        'pdf-view-previous-line-or-previous-page
   "J"        'pdf-view-next-line-or-next-page
   "C-l"      'my-show-pdf-view-commands)

  (:keymaps   'pdf-outline-buffer-mode-map
   :states '(normal visual)
   "<escape>"  'quit-window)

  :custom

  (pdf-view-continuous t)
  (pdf-view-resize-factor 1.15)
  (pdf-misc-size-indication-minor-mode t)

  :config

  (defun my-show-pdf-view-commands ()
    (interactive)
    (counsel-M-x "^pdf-view- ")))

(use-package! evil
  :custom
  (evil-visualstar/persistent t)
  (evil-respect-visual-line-mode t)
  (+evil-want-o/O-to-continue-comments nil)
  :general

  (:keymaps 'override
   :states '(normal visual insert)
   "M-s"         'evil-switch-to-windows-last-buffer)
  :config

  (add-hook 'evil-jumps-post-jump-hook 'my-recenter-window))

(use-package! projectile
  :custom
  (projectile-track-known-projects-automatically nil))

(after! evil
  (evil-better-visual-line-on))

(after! yasnippet
  (setq! +snippets-dir "/Users/davi/.doom.d/ml/snips"))

(after! apheleia
  (setf (alist-get 'black apheleia-formatters) '("black" "-l" "57" "-")))

(use-package! text-mode
  :init
  (add-hook! 'text-mode-hook 'my-text-mode-hooks)
  (remove-hook 'text-mode-hook 'hl-line-mode)
  (add-hook 'text-mode-hook 'abbrev-mode)
  :config
  (defun my-text-mode-hooks ()
    (electric-operator-mode +1)
    (auto-capitalize-mode +1)
    (hl-line-mode -1)))

(use-package! recursive-narrow
  :init
  (require 'recursive-narrow))


(use-package! windmove
  :general
  (:keymaps 'override
   :states '(normal visual insert)
   "M-k" 'windmove-up
   "M-j" 'windmove-down
   "M-h" 'windmove-left
   "M-l" 'windmove-right)
  :custom
  (windmove-wrap-around t))

(use-package! hl-sentence
  :config

  (custom-set-faces
   '(hl-sentence ((t (:inherit hl-line))))))

(use-package! wordnut
  :init
  (add-hook 'wordnut-mode-hook 'hide-mode-line-mode))

(use-package! clipmon
  :config
  (clipmon-mode-start))

;; (use-package! org-brain
;;   :init
;;   (setq! org-brain-path "/Users/davi/org/Data/roam")
;;   :custom
;;   (org-id-locations-file "/Users/davi/org/Data/roam/.orgids")
;;   (org-brain-visualize-default-choices 'all)
;;   (org-brain-title-max-length 12)
;;   (org-brain-include-file-entries nil)
;;   (org-brain-file-entries-use-title nil)
;;   :config
;;   (bind-key "C-c b" 'org-brain-prefix-map org-mode-map)

;;   (add-hook 'before-save-hook #'org-brain-ensure-ids-in-buffer)
;;   (push '("b" "Brain" plain (function org-brain-goto-end)
;;           "* %i%?" :empty-lines 1)
;;         org-capture-templates))

(after! shut-up-ignore
  (when noninteractive
    (shut-up-silence-emacs)))

(after! circe
  (set-irc-server! "chat.freenode.net"
                   `(:tls t
                     :port 6697
                     :nick "mrblack"
                     :sasl-username "mrblack"
                     ;; :sasl-password "mypassword"
                     :channels ("#emacs"))))
