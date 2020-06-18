;;;;;;;;;; INITIAL SETTINGS ;;;;;;;;;;

(setq user-full-name "mrbig"
      user-mail-address "mrbig033@protonmail.com"
      doom-font (font-spec :family "Input Mono" :size 20)
      doom-variable-pitch-font (font-spec :family "Input Mono") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "Input Mono" :size 20)
      doom-big-font (font-spec :family "Input Mono" :size 20)
      doom-theme 'doom-solarized-light
      org-directory "~/org/"
      display-line-numbers-type nil
      my-lisp "~/.doom.d/ml"
      my-kbd "~/.doom.d/ml/kbd"
      use-package-always-defer t
      recentf-auto-cleanup "11:59pm"
      +word-wrap-extra-indent 'single
      confirm-kill-emacs nil
      auto-revert-verbose nil
      eldoc-idle-delay 2
      trash-directory "~/.Trash"
      flyspell-correct-auto-delay 1
      custom-file "~/.doom.d/.custom-file.el"
      abbrev-file-name "~/.doom.d/etc/abbrev.el"
      flycheck-global-modes '(not emacs-lisp-mode)
      recentf-max-saved-items 20
      langtool-language-tool-jar "~/maps/langtool/langtooljar")

(setq-hook! 'eww-mode-hook display-buffer-alist nil)

(defun my-buffer-predicate (buffer)
  (if (string-match "\*" (buffer-name buffer)) nil t))
(set-frame-parameter nil 'buffer-predicate 'my-buffer-predicate)

(put 'narrow-to-region 'disabled nil)
(put 'customize-group 'disabled nil)

(map! :map (org-mode-map evil-org-mode-map)
      :n "gr"       'my-evil-sel-to-end)

;;;;;;;;;; KEYBINDINGS ;;;;;;;;;;
(define-key key-translation-map (kbd "C-0") (kbd "-"))
(define-key key-translation-map (kbd "-") (kbd "C-0"))
(define-key key-translation-map (kbd "s-8") (kbd"["))
(define-key key-translation-map (kbd "s-9") (kbd"]"))
(define-key key-translation-map (kbd "s-(") (kbd"{"))
(define-key key-translation-map (kbd "s-)") (kbd"}"))

;; INSERT STATE ;;
(map! :i "C-h" 'evil-delete-backward-char-and-join
      :i "C-k" 'kill-line
      :i "C-p" 'previous-line
      :i "C-n" 'next-line
      :i "M-d" 'kill-word
      :i "C-d" 'delete-char
      :i "M-e" 'yas-expand
      :i "C-ç d" 'deft)

;; NORMAL STATE ;;
(map! :n "gr"  'my-evil-sel-to-end
      :n "go"  'cool-moves-open-line-below
      :n "g,"  'goto-last-change
      :n "g;"  'goto-last-change-reverse
      :n "C-k" 'evil-change-line
      :n "gO"  'cool-moves-open-line-above
      :n "gsP" 'cool-moves-paragraph-backward
      :n "gsp" 'cool-moves-paragraph-forward
      :n "TAB" '+fold/toggle
      :n "zi"  '+fold/open-all
      :n "ge"  'evil-end-of-visual-line
      :n "Q"   'my-delete-frame
      :n "0"   'evil-beginning-of-visual-line
      :n "g3"  'evil-backward-word-end
      :n "g#"  'evil-forward-word-end
      :n "-"   'insert-char
      :n "H"   'projectile-previous-project-buffer
      :n "L"   'projectile-next-project-buffer

      :n "z0"  'endless/ispell-word-then-abbrev
      :n "z="  'flyspell-correct-previous

      :vn "çd" 'deft

      )

;; VISUAL AND MIXED STATES ;;
(map! :v "C-c a"  'align-regexp
      :nv "M-o"   'better-jumper-jump-backward
      :nv "M-i"   'better-jumper-jump-forward
      :nv "C-h M" 'my-show-major-mode
      :nv ";"     'link-hint-open-link
      :nvg "C-S-j" 'cool-moves-line-forward
      :nvg "C-S-k" 'cool-moves-line-backward)
;; GLOBALS
(map! "M--"   'winner-undo
      "M-'"   'winner-undo
      "M-="   'winner-redo
      "M-+"   'winner-redo
      "M-/"   'hippie-expand
      "C-x p" 'check-parens
      "C-;"   'helpful-at-point
      "M-RET" 'my-indent-buffer
      "C-9"   'evilnc-comment-or-uncomment-lines
      "C-c v" 'vlf
      "M-9"   'delete-other-windows
      "M-0"   'quit-window
      "M-n"   'my-forward-paragraph-do-indentation
      "M-p"   'my-backward-paragraph-do-indentation
      "M-]"   'evil-window-prev
      "M-["   'evil-window-next
      "M-k"   'windmove-up
      "M-j"   'windmove-down
      "M-h"   'windmove-left
      "M-l"   'windmove-right
      "C-c h" 'previous-buffer
      "C-c y" 'kill-ring-save
      "C-c l" 'next-buffer
      "C-c m" 'define-mode-abbrev
      "C-c M" 'define-global-abbrev
      "C-'"   'org-cycle-agenda-files
      "C-c u" 'redraw-display
      "C-c a" 'my-goto-agenda
      "C-l"   'recenter-top-bottom
      "C-c d" 'ispell-change-dictionary
      "C-c o" 'my-org-force-open-other-window
      "C-h e" 'describe-package
      "C-h N" 'my-show-server-name
      "C-c t" 'git-timemachine
      "C-c -" 'insert-char
      "C-c i" 'emacs-init-time)
;; LEADER KEY
(map! :leader "sw"  'wordnut-lookup-current-word
      :leader "sW"  'wordnut-search
      :leader "sg"  'counsel-ag
      :leader "sp"  'counsel-projectile-ag
      :leader "l"   'link-hint-open-link
      :leader "br"  '+popup/raise
      :leader "mgx" 'org-capture-goto-last-stored
      :leader "z"   'org-capture
      :leader "ww"  'doom/window-maximize-vertically
      :leader "k"   'kill-current-buffer
      :leader "x"   'eyebrowse-close-window-config
      :leader "r"   'deer
      :leader "0"   'delete-window
      :leader "pG"  'projectile-configure-project
      :leader "fp"  '+ivy/projectile-find-file
      :leader "nn"  'recursive-narrow-or-widen-dwim
      :leader "nw"  'my-widen-to-center
      :leader "to"  'olivetti-mode
      :leader "cw"  'count-words
      :leader "hdS" 'my-search-doom-help
      :leader "SPC" nil
      :leader "k"   'kill-current-buffer
      :leader "SPC k"  'my-deer-goto-my-kdb
      :leader "SPC l"   'my-deer-goto-my-lisp
      :leader "SPC p" 'my-goto-my-packages
      :leader "SPC x" 'org-capture
      ;; TEXT ;;
      :leader "tT"  'my-reload-file
      :leader "tB"  'spelling-brasileiro
      :leader "tE"  'spelling-english
      :leader "td"  'my-dup-line
      :leader "te"  'hl-sentence-mode
      :leader "th"  'hl-line-mode
      :leader "tD"  'ispell-change-dictionary
      :leader "tc"  'xah-clean-empty-lines
      :leader "ti"  'my-dup-par
      :leader "tv"  'visible-mode
      :leader "tS"  'my-sort-lines-by-length
      :leader "ta"  'artbollocks-mode
      :leader "tg"  'writegood-mode
      :leader "tb"  'flyspell-buffer
      :leader "tl"  'langtool-check-buffer
      :leader "tL"  'langtool-check-done
      :leader "tt"  'google-translate-smooth-translate
      :leader "tC"  'company-mode
      :leader "oo"  'hydra-org-mode/body
      :leader "mm"  'lisp-interaction-mode

      ;; COPY DIRECTORY PATH ;;
      :leader "fY" 'my-copy-directory

      ;; SEARCH SETTINGS ;;
      :leader "fs" 'my-search-settings
      :leader "fk" 'my-search-packages
      :leader "fK" 'my-search-kbds

      ;; EVIL SUBSTITUTE ;;
      :leader "su" (lambda () (interactive)
                     (evil-ex "%s/"))

      ;; WINDOWS ;;
      :leader "wl" (lambda () (interactive)
                     (+evil-window-vsplit-a) (other-window 1))
      :leader "wj" (lambda () (interactive)
                     (+evil-window-split-a) (other-window 1))
      :leader "wk"    '+evil-window-split-a
      :leader "wh"    '+evil-window-vsplit-a
      :leader "T"     'my-reopen-killed-file
      :leader "g SPC" 'my-magit-stage-modified-and-commit
      :leader "meb"   'my-eval-buffer
      :leader "ee"    'my-eval-buffer
      :leader "el"    'my-eval-buffer-and-leave
      :leader "eq"    'my-eval-buffer-quit
      :leader "ek"    'my-eval-buffer-kill
      :leader "ek"    'my-eval-buffer-kill
      :leader "ba"    'my-goto-markdown
      :leader "bd"    'server-force-delete
      :leader "mwi"    'org-web-tools-insert-link-for-url
      :leader "mwe"    'org-web-tools-archive-view
      :leader "mwv"    'org-web-tools-archive-attach
      :leader "mwr"    'org-web-tools-read-url-as-org
      :leader "mwc"    'org-web-tools-convert-links-to-page-entries)
;; LOCAL KEYBINDINGS
(map! (:map pabbrev-mode-map
       :i "C-l" 'pabbrev-expand-maybe)

      (:map helpful-mode-map
       :nvig "C-r" 'helpful-update)

      (:map (minibuffer-local-map
             minibuffer-local-ns-map
             minibuffer-local-completion-map
             minibuffer-local-must-match-map
             minibuffer-local-isearch-map
             read-expression-map
             evil-ex-completion-map
             evil-ex-search-keymap)

       "C-y" 'kill-ring-save
       :nvig "<insert>" 'yank
       :nvig "C-k"      'kill-line
       :nvig "C-d"      'delete-char
       :nvig "C-h"      'delete-backward-char
       :nvig "C-w"      'backward-kill-word))

(map! :map (org-mode-map evil-org-mode-map)
      :n "gr"       'my-evil-sel-to-end)


;;;;;;;;;; PACKAGE SETTINGS ;;;;;;;;;;

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
  :demand t
  :init
  (remove-hook 'org-mode-hook 'flyspell-mode)
  (remove-hook 'org-cycle-hook 'org-optimize-window-after-visibility-change)
  (add-hook 'org-cycle-hook 'org-cycle-hide-drawers)
  (add-hook 'org-mode-hook (lambda () (org-indent-mode t)))
  (add-hook! '(org-mode-hook org-src-mode-hook) #'my-org-key-translation)
  (advice-add 'org-edit-special :after #'my-indent-buffer)
  (advice-add 'org-edit-special :after #'my-recenter-window)
  (advice-add 'org-edit-src-exit :before #'my-indent-buffer)
  (advice-add 'org-edit-src-exit :after #'my-recenter-window)
  ;; :general
  ;; (:keymaps   '(org-mode-map evil-org-mode-map)
  ;;  :states    'normal
  ;;  "gr"       'my-evil-sel-to-end)

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

  (map! :leader "sg"  'counsel-ag
        :leader "sp"  'counsel-projectile-ag)

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

(use-package! evil-god-state
  :after evil
  :config

  (map! :v "."          'evil-exit-visual-state
        :v "gr"         'eval-region
        :n "."          'evil-execute-in-god-state
        :map god-local-mode-map
        :nig "<escape>" 'evil-god-state-bail
        :nig "."        'evil-god-state-bail)

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
  (doom-modeline-env-version nil)
  (doom-modeline-env-enable-go nil)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-buffer-state-icon nil)
  (doom-modeline-buffer-encoding t)
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
  :after-call after-find-file
  :config
  (delight '((org-mode "[o]")
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
  (company-global-modes '(not erc-mode message-mode help-mode gud-mode eshell-mode))
  :config

  (map! :map company-active-map
        "M-e"       'my-company-yasnippet
        "C-y"       'company-yasnippet
        "<return>"  'company-complete-selection
        "C-m"  'company-complete-selection
        "M-q"       'company-complete-selection
        "M-w"       'my-company-comp-with-paren
        "M-."       'my-company-comp-with-dot
        "M-j"       'my-company-comp-space
        "C-u"       'my-backward-kill-line
        "C-h"       'delete-backward-char
        "M-0"       'company-complete-number
        "M-1"       'company-complete-number
        "M-2"       'company-complete-number
        "M-3"       'company-complete-number
        "M-4"       'company-complete-number
        "M-5"       'company-complete-number
        "M-6"       'company-complete-number
        "M-7"       'company-complete-number
        "M-8"       'company-complete-number
        "M-9"       'company-complete-number)

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
  (evil-respect-visual-line-mode nil)
  (+evil-want-o/O-to-continue-comments nil)
  :general

  (:keymaps 'override
   :states '(normal visual insert)
   "M-s"         'evil-switch-to-windows-last-buffer)
  :config

  (defun my-open-two-lines ()
    (interactive)
    (end-of-line)
    (newline-and-indent 2)
    (evil-insert-state))

  (add-hook 'evil-jumps-post-jump-hook 'my-recenter-window))

(use-package! projectile
  :custom
  (projectile-track-known-projects-automatically nil))

(after! evil
  (evil-better-visual-line-on))

;; (use-package! yasnippet
;;   :after-call after-find-file
;;   :init
;;   (setq! +snippets-dir "/Users/davi/.doom.d/etc/snips"
;;          yas--default-user-snippets-dir "/Users/davi/.doom.d/etc/snips"))

(after! apheleia
  (setf (alist-get 'black apheleia-formatters) '("black" "-l" "57" "-")))

(use-package! text-mode
  :init
  (add-hook! 'text-mode-hook 'my-text-mode-hooks)
  (remove-hook 'text-mode-hook 'hl-line-mode)
  :config
  (map! :map (text-mode-map)
        :n "<escape>" 'my-quiet-save-buffer)
  (defun my-text-mode-hooks ()
    (electric-operator-mode +1)
    (abbrev-mode +1)
    (auto-capitalize-mode +1)))

(use-package! recursive-narrow
  :init
  (require 'recursive-narrow))

(use-package! windmove
  :after-call (windmove-up windmove-down windmove-left windmove-right)
  :custom
  (windmove-wrap-around t)
  :config
  (map! :nvig "M-k"   'windmove-up
        :nvig "M-j"   'windmove-down
        :nvig "M-h"   'windmove-left
        :nvig "M-l"   'windmove-right))

(use-package! hl-sentence
  :config

  (custom-set-faces
   '(hl-sentence ((t (:inherit hl-line))))))

;; osx-dictionary

(use-package! wordnut
  :init
  (add-hook! 'wordnut-mode-hook 'hide-mode-line-mode)
  :config
  (map! :leader "sw"  'wordnut-lookup-current-word
        :leader "sW"  'wordnut-search
        :map (wordnut-mode-map)
        :nv "q" 'quit-window
        :nv "Q" 'kill-this-buffer
        :n "<escape>" 'quit-window))

(use-package! osx-dictionary
  :init
  (add-hook! 'osx-dictionary-mode-hook 'hide-mode-line-mode)
  :config
  (map! :map (osx-dictionary-mode-map)
        :nv "q" 'quit-window
        :nv "Q" 'kill-this-buffer
        :n "<escape>" 'quit-window))

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
             #'typo-mode
             #'artbollocks-mode
             #'abbrev-mode
             #'my-mardown-hooks)
  :custom
  (markdown-hide-urls 't)
  (markdown-hide-markup nil)
  (markdown-enable-wiki-links t)
  :config

  (map! :map (markdown-mode-map evil-markdown-mode-map)
        :i "C-h" 'markdown-outdent-or-delete
        :i "<tab>" 'tab-to-tab-stop
        :nvig "<C-return>"   'my-open-two-lines
        :nvig "M--"   'winner-undo
        :nvig "M-="   'winner-redo
        :nvig "M-n"   'my-forward-paragraph-do-indentation
        :nvig "M-p"   'my-backward-paragraph-do-indentation
        :v "<insert>" 'markdown-insert-link)


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
  (add-hook 'prog-mode-hook 'abbrev-mode)
  :config
  (map! :map (prog-mode-map)
        :n "<escape>" 'my-quiet-save-buffer))

(use-package! conf-mode
  :config
  (map! :map (conf-mode-map)
        :n "<escape>" 'my-quiet-save-buffer))

(use-package! elisp-mode
  :init
  :config
  (map! :map (emacs-lisp-mode-map)
        :n "<escape>" 'my-quiet-save-buffer
        :map (lisp-interaction-mode-map)
        :n "<escape>" 'ignore))


(use-package! git-auto-commit-mode
  :custom
  (gac-debounce-interval (* 60 5)))

;;;;;;;;;; FUNCTIONS ;;;;;;;;;;

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

(defun my-show-major-mode ()
  (interactive)
  (helpful-variable 'major-mode))

(defun my-show-server-name ()
  (interactive)
  (helpful-variable 'server-name))

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

(defun my-goto-my-packages ()
  (interactive)
  (find-file "~/.doom.d/ml/my-packages.el")
  (my-recenter-window)
  (message nil))

(defun my-goto-agenda ()
  (interactive)
  (find-file "~/org/Agenda/agenda.org")
  (message nil))

(defun my-copy-directory ()
  (interactive)
  (message (kill-new (abbreviate-file-name default-directory))))

(defun my-last-buffer ()
  (interactive)
  (switch-to-buffer nil))

;;;;;;;;;; HYDRAS ;;;;;;;;;;

(defhydra hydra-help (:color blue :hint nil :exit t :foreign-keys nil)
  "

    ^^Help
    ----------------------------------------
    _f_: callable  _k_: key       _i_: info
    _v_: variable  _l_: key long
    _e_: package   _w_: where is
    _p_: at point  _a_: apropos
    _m_: major     _d_: docs
    _o_: modes     _c_: command
   "

  ("<escape>" nil)
  ("C-h" helpful-variable)
  ("C-f" helpful-callable)

  ("f" helpful-callable)
  ("F" helpful-function)
  ("e" describe-package)
  ("v" helpful-variable)
  ("p" helpful-at-point)
  ("m" my-show-major-mode)
  ("o" describe-mode)

  ("k" describe-key-briefly)
  ("l" helpful-key)

  ("w" where-is)

  ("a" counsel-apropos)
  ("c" helpful-command)
  ("d" apropos-documentation)
  ("i" info))

(defhydra hydra-window (:color pink :hint nil :exit nil :foreign-keys nil)
  "

  _H_: -w  _h_: sp ←  _b_: bal
  _J_: +h  _j_: sp ↓
  _K_: -h  _k_: sp ↑
  _L_: +w  _l_: sp →

"
  ("<escape>" nil)
  ("L" evil-window-increase-width)
  ("H" evil-window-decrease-width)
  ("J" evil-window-decrease-height)
  ("K" evil-window-increase-height)
  ("h" +evil-window-vsplit-a :exit t)
  ("j" my-window-split-below :exit t)
  ("k" +evil-window-split-a  :exit t)
  ("l" my-window-split-right :exit t)
  ("b" balance-windows :exit t))

(defun my-window-split-right ()
  (interactive)
  (+evil-window-vsplit-a)
  (other-window 1))

(defun my-window-split-below ()
  (interactive)
  (+evil-window-split-a)
  (other-window 1))

(defhydra hydra-python-mode (:color blue :hint nil :foreign-keys run)
  "

    _d_: goto def    _s_: quickshell     _c_: classes ag
    _a_: go at point _l_: clear errors   _f_: functions ager
    _g_: goto dumb   _C_: classes swiper
    _b_: go back     _F_: functions swip
"

  ("<escape>" nil)
  ("q" nil)

  ("d" elpy-goto-definition)
  ("ç" elpy-goto-definition)
  ("<return>" elpy-goto-definition)
  ("a" counsel-ag-thing-at-point)

  ("g" dumb-jump-go)
  ("b" better-jumper-jump-backward)
  ("C-ç" better-jumper-jump-backward)
  ("<C-return>" better-jumper-jump-backward)
  ("s" quickrun-shell)
  ("l" flycheck-clear)

  ("C" my-swiper-python-classes)
  ("F" my-swiper-python-functions)

  ("c" my-search-python-classes)
  ("f" my-search-python-function))

(defhydra hydra-org-clock (:color blue :hint nil :exit nil :foreign-keys nil)
  "

    _i_: in      _d_: done  _p_: pomo
    _o_: out     _l_: last
    _c_: cancel  _g_: goto
    _s_: start   _h_: show"

  ("q" nil)
  ("<escape>" nil)

  ("i" org-clock-in)
  ("o" org-clock-out)
  ("c" org-clock-cancel)
  ("s" my-org-started-with-clock)

  ("d" my-org-todo-done)
  ("l" org-clock-in-last)
  ("g" org-clock-goto)
  ("h" org-clock-display)

  ("t" my-org-todo)
  ("p" hydra-org-pomodoro/body))

(defhydra hydra-org-pomodoro (:color blue :hint nil :exit nil :foreign-keys nil)
  ("q" nil)
  ("<escape>" nil)

  ("s" my-org-started-with-pomodoro "task + pomo")
  ("g" my-org-goto-clock-and-start-pomodoro "goto + start")
  ("d" my-org-todo-done-pomodoro "done all")
  ("p" org-pomodoro "pomo"))

(defhydra hydra-org-mode (:color blue :hint nil :exit nil :foreign-keys nil)
  ("<escape>" nil)
  ("q" nil)

  ("a" org-archive-subtree-default "archive")
  ("p" org-capture-goto-last-stored "last capt.")
  ("d" org-deadline "deadline")
  ("l" org-store-link "link")
  ("g" counsel-org-tag "tags")
  ("t" org-todo "todos"))

;;;;;;;;;; LOAD LISP ;;;;;;;;;;

(load! "~/.doom.d/ml/cool-moves.el")
(load! "~/.doom.d/ml/auto-capitalize.el")
(load! "~/.doom.d/ml/theme_switcher.el")

;;;;;;;;;; ACTIVATE MODES ;;;;;;;;;;

(global-flycheck-mode -1)
(global-subword-mode +1)
(mouse-avoidance-mode 'jump)
