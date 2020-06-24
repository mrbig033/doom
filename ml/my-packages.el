;;; ~/.doom.d/use-package.el -*- lexical-binding: t; -*-

(use-package! hydra
  :general
  (:keymaps '(doom-leader-map)
   "j"     'hydra-org-clock/body))

(use-package! treemacs
  :commands treemacs-select-window
  :custom
  (treemacs-width 20)
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

  (:keymaps   '(global )
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
  (which-key-allow-evil-operators nil)
  (which-key-idle-delay 0.3)
  :config
  (which-key-add-key-based-replacements

    "SPC SPC rf"  "Roam Find File"
    "SPC SPC rl"  "Roam Find-File"
    "SPC SPC rj"  "Roam Index"
    "SPC SPC rb"  "Roam Switch Buffer"
    "SPC SPC rg"  "Roam Graph"
    "SPC SPC ri"  "Roam Insert"
    "SPC SPC rd"  "Roam Deft"
    "SPC SPC rc"  "Roam Re-Cache"
    "SPC SPC rx"  "Roam Indexes"
    "SPC SPC ro"  "Roam Logic"
    "SPC SPC ra"  "Roam Fallacies"
    "SPC SPC rs"  "Roam Commands"
    "SPC SPC rç"  "Roam"

    "SPC mwi"  "OW Insert"
    "SPC mwe"  "OW Archive"
    "SPC mwv"  "OW Attach"
    "SPC mwr"  "OW Read As Org"
    "SPC mwc"  "OW Links to Entries"

    "SPC SPC k"  "Goto KBDs"
    "SPC SPC l"  "Goto Lisp"
    "SPC SPC p"  "Goto Packages"
    "SPC SPC a"  "Goto Agenda"

    "SPC SPC x"  "Org Capture"

    "SPC ee" "Eval Buffer"
    "SPC el" "Eval & Leave"
    "SPC eq" "Eval & Quit"
    "SPC ek" "Eval & Kill"

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
  (remove-hook 'org-mode-hook 'flyspell-mode)
  (remove-hook 'org-cycle-hook 'org-optimize-window-after-visibility-change)
  (add-hook 'org-cycle-hook 'org-cycle-hide-drawers)
  (add-hook 'org-agenda-mode-hook 'hl-line-mode)
  (add-hook 'org-mode-hook (lambda () (org-indent-mode t)))
  (add-hook! '(org-mode-hook org-src-mode-hook) #'my-org-key-translation)
  (advice-add 'org-edit-special :after #'my-indent-buffer)
  (advice-add 'org-edit-special :after #'my-recenter-window)
  (advice-add 'org-edit-src-exit :before #'my-indent-buffer)
  (advice-add 'org-edit-src-exit :after #'my-recenter-window)

  :general
  (:keymaps   '(evil-org-mode-map org-mode-map)
   :states    '(normal insert visual)
   "M-k"   'windmove-up
   "M-j"   'windmove-down
   "M-h"   'windmove-left
   "M-l"   'windmove-right
   "C-j" 'treemacs-select-window)
  (:keymaps   '(evil-org-mode-map)
   :states    '(normal)
   "gr"       'my-evil-sel-to-end)
  (:keymaps   '(doom-leader-map)
   "aa"        'org-agenda
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
  (org-babel-temporary-directory (concat user-emacs-directory "babel-temp"))
  (org-id-link-to-org-use-id t)
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
      "* TODO %^{Title} %i\n[%<%Y-%m-%d>]\n%?")

     ("n" "Notes" entry
      (file+headline org-agenda-file "Notes")
      "* %? %i\n[%<%Y-%m-%d>]" :prepend t)
     ("j" "Journal" entry
      (file+olp+datetree org-agenda-file)
      "* %? %i" :prepend t)))

  :config

  ;; (:map (evil-org-mode-map org-mode-map global-map)
  ;;  :nvig "M-k"   'windmove-up
  ;;  :nvig "M-j"   'windmove-down
  ;;  :nvig "M-h"   'windmove-left
  ;;  :nvig "M-l"   'windmove-right)


  (load! "~/.doom.d/ml/extras/org_defun.el"))

(use-package! org-roam
  :after org
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
  :general
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
  (:states '(normal visual operator)
   "g9"      'my-avy-goto-open-paren
   "g0"      'my-avy-goto-close-paren
   ","       'avy-goto-subword-1
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
  :hook (ranger-mode . my-ranger-olivetti)
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

  (:keymaps 'doom-leader-map
   "r"      'deer
   "R"      'ranger
   "SPC k"  'my-deer-goto-my-kdb
   "SPC l"  'my-deer-goto-my-lisp)

  :config

  (defun my-ranger-olivetti ()
    (interactive)
    (setq-local olivetti-body-width '65)
    (olivetti-mode +1))

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
    (deer "~/.doom.d/ml/"))

  (defun my-deer-goto-my-kdb ()
    (interactive)
    (deer "~/.doom.d/ml/kbd/"))

  '(lambda () (interactive)
     (find-file "~/.doom.d/ml/my-packages.el")
     (my-recenter-window)
     (message nil))

  (defun my-deer-goto-python ()
    (interactive)
    (deer "~/Documents/Python/"))

  (defun my-ranger-toggle-mark-and-advance ()
    (interactive)
    (ranger-toggle-mark)
    (ranger-next-file 1)))

(use-package! ivy
  :custom
  (ivy-height 10)
  (counsel-grep-swiper-limit 300000)
  (ivy-extra-directories nil)
  (counsel-outline-display-style 'title)
  (counsel-find-file-at-point t)
  (counsel-bookmark-avoid-dired t)
  (ivy-count-format "")

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
   "C-." 'counsel-M-x
   "M-u" 'ivy-yasnippet)

  (:keymaps 'doom-leader-map
   "sg"  'counsel-ag
   "sç"  'counsel-ag
   "sp"  'counsel-projectile-ag)
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

  (defun my-search-kbds ()
    (interactive)
    (counsel-ag nil "~/.doom.d/ml/kbd/"))

  (defun my-search-doom-help ()
    (interactive)
    (counsel-ag nil "~/.emacs.d/" "-G '.org'"))

  (defun my-search-packages ()
    (interactive)
    (my-widen-to-center-with-excursion)
    (counsel-ag  "(use-package\\! "  "~/.doom.d/ml/"))

  (defun my-swiper-python-classes ()
    (interactive)
    (swiper  "class "))

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

;; (use-package! yasnippet
;;   :after-call after-find-file
;;   :config
;;   (yas-global-mode +1))

(use-package! ivy-yasnippet
  :after (ivy yasnippet)
  :custom
  (ivy-yasnippet-expand-keys nil))

(use-package! evil-smartparens
  :after evil
  :general
  (:keymaps '(evil-smartparens-mode-map)
   :states  '(visual)
   "o"     'exchange-point-and-mark))

(use-package! python
  :init

  (add-hook! '(python-mode-hook inferior-python-mode-hook)
             #'rainbow-delimiters-mode
             #'electric-operator-mode
             #'evil-smartparens-mode
             #'smartparens-strict-mode
             #'yafolding-mode
             #'hl-line-mode
             #'evil-swap-keys-swap-double-single-quotes
             #'evil-swap-keys-swap-underscore-dash
             #'evil-swap-keys-swap-colon-semicolon
             #'(lambda () (setq-local fill-column 57)))

  (add-hook! 'python-mode-hook
             #'elpy-mode
             #'apheleia-mode)
  :general

  (:keymaps    '(python-mode-map)
   "M-p"       'my-backward-paragraph-do-indentation
   "M-n"       'my-forward-paragraph-do-indentation
   "C-c ç"     'my-python-shebang
   "C-ç"       'elpy-shell-switch-to-shell
   "M-a"       'python-nav-backward-statement
   "M-e"       'python-nav-forward-statement
   :states    '(normal)
   "ç"        'hydra-python-mode/body
   "<return>" 'hydra-python-mode/body)

  (:keymaps    '(python-mode-map)
   :states '(insert)
   "C-="   'my-python-colon-newline)

  (:keymaps    '(python-mode-map)
   :states '(normal visual)
   "zi" 'yafolding-show-all
   "zm" 'yafolding-toggle-all
   "TAB" 'yafolding-toggle-element
   "<backtab>" 'yafolding-toggle-all
   "<" 'python-indent-shift-left
   ">" 'python-indent-shift-right)

  (:keymaps    '(python-mode-map)
   :states '(normal visual insert)
   "<C-return>" 'my-quickrun)

  (:keymaps '(inferior-python-mode-map)
   "C-ç" 'my-elpy-switch-to-buffer
   :states '(insert)
   "C-l" 'comint-clear-buffer)

  :custom
  (python-indent-guess-indent-offset-verbose nil)
  :config

  (general-unbind
    :keymaps 'python-mode-map
    :with 'python-indent-dedent-line-backspace
    [remap evil-delete-backward-char-and-join])

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
  :general
  (:keymaps '(elpy-mode-map)
   "C-x m" 'elpy-multiedit-python-symbol-at-point
   "C-x M" 'elpy-multiedit-stop)

  :config

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

(use-package! evil-god-state
  :after evil
  :general

  (:keymaps '(god-local-mode-map)
   :states  '(normal insert global)
   "."        'evil-god-state-bail
   "<escape>" 'evil-god-state-bail)

  (:keymaps '(evil-normal-state-map)
   "."        'evil-execute-in-god-state)

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
  (doom-modeline-lsp nil)
  (doom-modeline-env-enable-elixir nil)
  (doom-modeline-env-load-string ".")
  (doom-modeline-buffer-modification-icon nil)
  (doom-modeline-irc nil)
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-checker-simple-format t)
  (doom-modeline-bar-width 2)
  (doom-modeline-percent-position '(-3 "%p"))
  (doom-modeline-buffer-file-name-style 'buffer-name)
  :config
  (setq-default doom-modeline--vcs-text nil))

(use-package! delight
  :after-call after-init-hook
  :config
  (delight '((org-mode "[o]")
             (scratch-fundamental-mode "[scf]" "scratch-fundamental")
             (scratch-lisp-mode "[scl]" "scratch-lisp")
             (markdown-mode "[md]" "markdown")
             (sh-mode "[sh]" "Shell-script[bash]")
             (special-mode "[spe]" "special")
             (message-mode "[msg]" "messages")
             (fundamental-mode "[fun]" "fundamental")
             (python-mode "[py]" " python")
             (emacs-lisp-mode "[el]" "emacs-lisp")
             (lisp-interaction-mode "[lin]" "lisp interaction"))))

(use-package! flyspell
  :config
  (defun spelling-brasileiro ()
    (interactive)

    (setq-local company-ispell-dictionary "/Users/davi/.doom.d/etc/iv_sorted.txt"
                company-dabbrev-ignore-case 'keep-prefix)

    (ispell-change-dictionary "brasileiro")
    (flyspell-mode +1)
    (message " ispell brasileiro"))

  (defun spelling-english ()
    (interactive)
    (setq-local company-ispell-dictionary nil
                ispell-local-dictionary "english")
    (flyspell-mode)
    (message " ispell english")))

(use-package! ispell
  :custom
  (ispell-quietly t)

  :config

  ;; https://stackoverflow.com/a/19186801

  (defvar limit-ispell-choices-to 5
    "Number indicating the maximum number of choices to present")

  (setq! limit-ispell-choices-to 20)

  (defadvice ispell-parse-output (after limit-ispell-choices activate)
    (when (and (listp ad-return-value)
               ad-return-value)
      (let* ((miss-list-end (nthcdr (- limit-ispell-choices-to 1)
                                    (nth 2 ad-return-value)))
             (guess-list-end (nthcdr (- limit-ispell-choices-to 1)
                                     (nth 3 ad-return-value))))
        (when miss-list-end (setcdr miss-list-end nil))
        (when guess-list-end (setcdr guess-list-end nil)))))

  ;; Save corrections to abbrev

  (defun endless/simple-get-word ()
    (car-safe (save-excursion (ispell-get-word nil))))

  (defun endless/ispell-word-then-abbrev (p)
    "call `ispell-word', then create an abbrev for it.
      with prefix p, create local abbrev. otherwise it will
      be global.
      if there's nothing wrong with the word at point, keep
      looking for a typo until the beginning of buffer. you can
      skip typos you don't want to fix with `spc', and you can
      abort completely with `c-g'."
    (interactive "p")
    (let (bef aft)
      (save-excursion
        (while (if (setq bef (endless/simple-get-word))
                   ;; word was corrected or used quit.
                   (if (ispell-word nil 'quiet)
                       nil ; end the loop.
                     ;; also end if we reach `bob'.
                     (not (bobp)))
                 ;; if there's no word at point, keep looking
                 ;; until `bob'.
                 (not (bobp)))
          (backward-word)
          (backward-char))
        (setq aft (endless/simple-get-word)))
      (if (and aft bef (not (equal aft bef)))
          (let ((aft (downcase aft))
                (bef (downcase bef)))
            (define-abbrev
              (if p local-abbrev-table global-abbrev-table)
              bef aft)
            (message "\"%s\" now expands to \"%s\" %sally"
                     bef aft (if p "loc" "glob")))
        (user-error "no typo at or before point")))))

(use-package! company
  :custom
  (company-ispell-available t)
  (company-minimum-prefix-length 1)
  (company-show-numbers t)
  (company-tooltip-limit 10)
  (company-dabbrev-other-buffers t)
  (company-selection-wrap-around t)
  (company-auto-complete nil)
  (company-dabbrev-ignore-case 'keep-prefix)
  (company-global-modes        '(not erc-mode message-mode help-mode gud-mode eshell-mode))

  :general
  (:keymaps                    '(company-active-map)
   "M-e"                       'my-company-yasnippet
   "C-y"                       'company-yasnippet
   "<return>"                  'company-complete-selection
   "C-m"                       'company-complete-selection
   "M-q"                       'company-complete-selection
   "M-w"                       'my-company-comp-with-paren
   "M-."                       'my-company-comp-with-dot
   "M-j"                       'my-company-comp-space
   "C-u"                       'my-backward-kill-line
   "C-h"                       'delete-backward-char
   "M-0"                       'company-complete-number
   "M-1"                       'company-complete-number
   "M-2"                       'company-complete-number
   "M-3"                       'company-complete-number
   "M-4"                       'company-complete-number
   "M-5"                       'company-complete-number
   "M-6"                       'company-complete-number
   "M-7"                       'company-complete-number
   "M-8"                       'company-complete-number
   "M-9"                       'company-complete-number)

  :config

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
  ;; :after-call (pre-command-hook after-find-file super-save-mode)
  :after-call after-find-file
  :custom
  (auto-save-default nil)
  (super-save-idle-duration 5)
  (super-save-auto-save-when-idle t)
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
  (evil-respect-visual-line-mode nil)
  (+evil-want-o/O-to-continue-comments nil)

  :general

  (:keymaps   '(evil-emacs-state-map)
   "<escape>" 'evil-force-normal-state)

  (:keymaps   '(evil-normal-state-map)
   "C-z"      'ignore
   "M-d"      'evil-multiedit-match-and-next
   "C-c z"    'evil-emacs-state
   "g3"       'evil-backward-word-end
   "g#"       'evil-forward-word-end
   "gr"       'my-evil-sel-to-end
   "go"       'cool-moves-open-line-below
   "g,"       'goto-last-change
   "g;"       'goto-last-change-reverse
   "gO"       'cool-moves-open-line-above
   "gsP"      'cool-moves-paragraph-backward
   "gsp"      'cool-moves-paragraph-forward
   "C-S-p"    'cool-moves-word-backwards
   "C-S-n"    'cool-moves-word-forward
   "TAB"      '+fold/toggle
   "zi"       '+fold/open-all
   "Q"        'my-delete-frame
   "-"        'insert-char
   "z0"       'endless/ispell-word-then-abbrev
   "z="       'flyspell-correct-previous
   "<escape>" 'my-quiet-save-buffer)

  (:keymaps   '(evil-normal-state-map
                evil-insert-state-map
                evil-visual-state-map)
   "M-k"   'windmove-up
   "M-j"   'windmove-down
   "M-h"   'windmove-left
   "M-l"   'windmove-right)

  (:keymaps '(evil-insert-state-map)
   "C-h"    'evil-delete-backward-char-and-join
   "M-e"    'yas-expand
   "C-ç d"  'deft
   "C-k"    'kill-line
   "C-p"    'previous-line
   "C-n"    'next-line
   "M-d"    'kill-word
   "C-d"    'delete-char)

  (:keymaps '(evil-visual-state-map)
   "C-c a"  'align-regexp)

  (:keymaps '(evil-visual-state-map evil-normal-state-map current-global-map)
   "M-s"      'my-last-buffer
   "M-]"      'evil-window-prev
   "M-["      'evil-window-next
   "C-S-j" 'cool-moves-line-forward
   "C-S-k" 'cool-moves-line-backward
   "s-2"      'evil-execute-macro
   "ge"       'evil-end-of-visual-line
   "0"        'evil-beginning-of-visual-line
   "C-9"      'evilnc-comment-or-uncomment-lines)
  (:keymaps '(evil-visual-state-map evil-normal-state-map)
   "M-s"      'my-last-buffer
   "M-]"      'evil-window-prev
   "çd" 'deft
   "M-o"   'better-jumper-jump-backward
   "M-i"   'better-jumper-jump-forward
   "C-h M" 'my-show-major-mode
   "M-["      'evil-window-next
   "s-2"      'evil-execute-macro
   "C-9"      'evilnc-comment-or-uncomment-lines
   "0"        'evil-beginning-of-visual-line
   "ge"       'evil-end-of-visual-line)

  :config

  (defun my-open-two-lines ()
    (interactive)
    (end-of-line)
    (newline-and-indent 2)
    (evil-insert-state))

  (add-hook 'evil-jumps-post-jump-hook 'my-recenter-window))

(use-package! projectile
  :general
  (:keymaps '(doom-leader-map)
   "sp"  'counsel-projectile-ag
   "pG"  'projectile-configure-project
   "fp"  '+ivy/projectile-find-file)
  (:states '(normal visual)
   "H"   'projectile-previous-project-buffer
   "L"   'projectile-next-project-buffer)
  :custom
  (projectile-track-known-projects-automatically nil))

(after! evil
  (evil-better-visual-line-on))

(after! apheleia
  (setf (alist-get 'black apheleia-formatters) '("black" "-l" "57" "-")))

(use-package! text-mode
  :init
  (add-hook! 'text-mode-hook 'my-text-mode-hooks)
  (remove-hook 'text-mode-hook 'hl-line-mode)

  :config
  (defun my-text-mode-hooks ()
    (electric-operator-mode +1)
    (abbrev-mode +1)
    (auto-capitalize-mode +1)))

(use-package! recursive-narrow
  :init
  (require 'recursive-narrow))

(use-package! windmove
  ;; :after-call (windmove-up windmove-down windmove-left windmove-right)
  :custom
  (windmove-wrap-around t))

(use-package! hl-sentence
  :config

  (custom-set-faces
   '(hl-sentence ((t (:inherit hl-line))))))

;; osx-dictionary

(use-package! wordnut
  :init
  (add-hook! 'wordnut-mode-hook 'hide-mode-line-mode)
  :general
  (:keymaps '(doom-leader-map)
   "sW"  'wordnut-search
   "sw"  'wordnut-lookup-current-word)
  (:keymaps '(wordnut-mode-map)
   :states '(normal visual)
   "q" 'quit-window
   "Q" 'kill-this-buffer
   :states '(normal)
   "<escape>" 'quit-window))

(use-package! osx-dictionary
  :init
  (add-hook! 'osx-dictionary-mode-hook 'hide-mode-line-mode)
  :general
  (:keymaps '(osx-dictionary-mode-map)
   :states  '(normal)
   "<escape>" 'quit-window
   "q" 'quit-window))

(use-package! clipmon
  :init
  (clipmon-mode-start))

(use-package! olivetti
  :init
  (setq-default olivetti-body-width 85))

(use-package! typo
  :config

  (define-typo-cycle typo-cycle-right-single-quotation-mark
    "Cycle through the right quotation mark and the typewriter apostrophe."
    ( "'" "’"))

  (define-typo-cycle typo-cycle-dashes
    "Cycle through various dashes."
    ("—"   ; em dash
     "‐"   ; hyphen
     "-"   ; hyphen-minus
     "−"   ; minus sign
     "–"   ; en dash
     "‑"   ; non-breaking hyphen
     )))

(use-package! google-translate
  :custom
  (google-translate-pop-up-buffer-set-focus t)
  (google-translate-default-source-language "pt")
  (google-translate-default-target-language "en")
  (google-translate-translation-directions-alist '(("pt" . "en") ("en" . "pt"))))

(use-package! markdown-mode
  :init

  (add-hook! 'markdown-mode-hook
             #'artbollocks-mode
             #'abbrev-mode
             #'my-mardown-hooks)
  :custom
  (markdown-hide-urls 't)
  (markdown-hide-markup nil)
  (markdown-enable-wiki-links t)
  :general
  (:keymaps     '(markdown-mode-map evil-markdown-mode-map)
   :states      '(insert)
   "<tab>"      'tab-to-tab-stop
   "C-h"        'markdown-outdent-or-delete
   :states      '(visual)
   "<insert>" 'markdown-insert-link
   :states      '(normal visual insert global)
   "M--"        'winner-undo
   "M-="        'winner-redo
   "<C-return>" 'my-open-two-lines
   "M-n"        'my-forward-paragraph-do-indentation
   "M-p"        'my-backward-paragraph-do-indentation)

  :config

  (defun my-mardown-hooks ()
    (interactive)
    (setq-local company-dabbrev-other-buffers nil
                company-minimum-prefix-length 1
                company-tooltip-idle-delay 0.5
                company-idle-delay 0.25))

  (set-company-backend!
    'text-mode
    'company-ispell
    'company-dabbrev
    '(company-dabbrev  :with company-capf company-yasnippet)
    '(company-dabbrev-code :with company-keywords company-dabbrev)))

(after! shut-up-ignore
  (when noninteractive
    (shut-up-silence-emacs)))

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

(use-package pabbrev
  :custom
  (pabbrev-idle-timer-verbose nil))

(use-package! unkillable-scratch
  :demand t
  :custom
  (unkillable-scratch-behavior 'bury)
  (unkillable-buffers '("^\\*scratch\\*$" "^agenda.org$"))
  :config
  (unkillable-scratch))

(use-package! prog-mode
  :init
  (add-hook   'prog-mode-hook 'abbrev-mode)
  (remove-hook   'prog-mode-hook 'hl-line-mode)
  :general
  (:keymaps   '(prog-mode-map)
   :states    '(normal)
   "<escape>" 'my-quiet-save-buffer))

(use-package! conf-mode
  :config
  :general
  (:keymaps   '(conf-mode-map)
   :states    '(normal)
   "<escape>" 'my-quiet-save-buffer))

(use-package! elisp-mode
  :init
  (add-hook 'emacs-lisp-mode 'smartparens-strict-mode)
  :general
  (:keymaps   '(emacs-lisp-mode-map)
   :states    '(normal)
   "<escape>" 'my-quiet-save-buffer)
  (:keymaps   '(lisp-interaction-mode-map)
   :states    '(normal)
   "<escape>" 'ignore))

(use-package! git-auto-commit-mode
  :custom
  (gac-debounce-interval (* 60 60)))

(use-package! zoom
  :custom
  ;; golden ration:
  ;; (zoom-size '(0.618 . 0.618))
  (zoom-size '(0.550 . 0.550)))
