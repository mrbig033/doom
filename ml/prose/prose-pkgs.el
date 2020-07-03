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

(use-package! deft
  :after org-brain
  :init
  (evil-set-initial-state 'deft-mode 'emacs)
  :custom
  (deft-separator " - ")
  (deft-extensions '("org"))
  (deft-recursive t)
  (deft-use-filename-as-title t)
  (deft-default-extension "org")
  (deft-use-filter-string-for-filename t)
  (deft-directory org-brain-path))

(use-package! avy

  :general
  (:states '(normal)
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

  ;; DON'T SPELLCHECK ORG BLOCKS
  (pushnew! ispell-skip-region-alist
            '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:")
            '("#\\+BEGIN_SRC" . "#\\+END_SRC")
            '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))

  ;; SAVE CORRECTIONS TO ABBREV
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

(use-package! text-mode
  :init
  (add-hook! 'text-mode-hook 'my-text-mode-hooks)
  (remove-hook 'text-mode-hook 'hl-line-mode)

  :config
  (defun my-text-mode-hooks ()
    (electric-operator-mode +1)
    (abbrev-mode +1)
    (pabbrev-mode +1)
    (auto-capitalize-mode +1)))

(use-package! recursive-narrow
  :init
  (require 'recursive-narrow))

(use-package! hl-sentence
  :config
  (custom-set-faces
   '(hl-sentence ((t (:inherit hl-line))))))

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
    ("-"   ; hyphen-minus
     "—"   ; em dash
     "−"   ; minus sign
     "‐"   ; hyphen
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
  (add-hook! 'markdown-mode-hook #'abbrev-mode #'typo-mode)
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
   "M-p"        'my-backward-paragraph-do-indentation))

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

(use-package! pabbrev
  :custom
  (pabbrev-scavenge-some-chunk-size 120)
  (pabbrev-marker-distance-before-scavenge 1000)
  (pabbrev-idle-timer-verbose nil))

(use-package! org-brain
  :after-call after-find-file
  :init
  (add-hook 'org-brain-visualize-mode-hook (lambda () (+word-wrap-mode +1)))
  (add-hook  'org-brain-visualize-mode-hook 'hide-mode-line-mode)

  (add-hook! 'org-brain-visualize-follow-hook
             #'my-clean-all-empty-lines
             #'xah-clean-empty-lines
             #'my-save-some-buffers
             #'org-hide-drawer-all)
  :custom
  (org-brain-open-same-window t)
  (org-brain-show-text nil)
  (org-brain-path "~/org/Data/brain/boogey")
  (org-brain-show-history nil)
  (org-brain-headline-links-only-show-visible t)
  (org-brain-include-file-entries t)
  ;; (org-brain-scan-for-header-entries nil)
  (org-brain-show-full-entry nil)
  (org-brain-refile-max-level 5)
  (org-brain-visualize-sort-function 'ignore)
  (org-id-track-globally t)
  (org-brain-title-max-length 0)
  (org-brain-file-entries-use-title t)
  (org-brain-mind-map-parent-level 5)
  (org-brain-mind-map-child-level 5)
  (org-brain-visualize-default-choices 'all)
  (org-id-locations-file "~/org/Data/brain/.org-id-locations")
  :config

  (defun my-brain-olivetti ()
    (interactive)
    (setq-local olivetti-body-width '65)
    (olivetti-mode))

  (defun my-brain-goto-current-maximize ()
    (interactive)
    (push-button)
    (org-brain-goto-current)
    (org-hide-drawer-all)
    (doom/window-maximize-vertically)
    (windmove-right))

  (defun my-brain-goto-current-maximize-and-go ()
    (interactive)
    (push-button)
    (org-brain-goto-current)
    (org-hide-drawer-all)
    (doom/window-maximize-vertically))

  (defun my-goto-brain-main ()
    (interactive)
    (org-brain-visualize "boogey"))

  (defun my-goto-brain ()
    (interactive)
    (switch-to-buffer-other-window "*org-brain*"))

  (defun my-goto-brain-same-window ()
    (interactive)
    (switch-to-buffer "*org-brain*"))

  (defun my-brain-erase-history ()
    (interactive)
    (setq org-brain--vis-history nil))

  (add-hook 'before-save-hook #'org-brain-ensure-ids-in-buffer))

(use-package! beacon
  :custom
  (beacon-size 30)
  (beacon-blink-delay 0.1)
  (beacon-blink-duration 0.06)
  (beacon-blink-when-focused nil)
  (beacon-blink-when-window-scrolls t)
  (beacon-blink-when-window-changes t)
  (beacon-blink-when-point-moves-vertically nil)
  (beacon-blink-when-point-moves-horizontally nil)

  (beacon-dont-blink-commands '(evil-forward-word-begin
                                evil-backward-word-begin
                                evil-scroll-line-up
                                evil-scroll-line-down
                                evil-better-visual-line-next-line
                                evil-better-visual-line-previous-line
                                evil-forward-paragraph
                                evil-backward-paragraph
                                evil-next-visual-line
                                evil-previous-visual-line
                                evil-next-line
                                evil-previous-line
                                beginning-of-visual-line
                                evil-indent
                                helpful-at-point
                                quit-window)))

(use-package! lorem-ipsum
  :custom
  (lorem-ipsum-paragraph-separator "\n\n"))

(use-package! engine-mode
  :config

  (defun engine/search-aurelio-ap ()
    (interactive)
    (engine/search-aurelio (current-word)))

  (defengine aurelio "https://www.dicio.com.br/%s")

  (defun engine/search-wikitionary-pt-ap ()
    (interactive)
    (engine/search-wikitionary-pt (current-word)))
  (defengine wikitionary-pt "https://pt.wiktionary.org/wiki/%s")

  (defun engine/free-dic-pt-ap ()
    (interactive)
    (engine/search-free-dic-pt (current-word)))
  (defengine free-dic-pt "https://pt.thefreedictionary.com/%s")

  (defun engine/search-dic-infor-ap ()
    (interactive)
    (engine/search-dic-infor (current-word)))
  (defengine dic-infor "https://www.dicionarioinformal.com.br/%s")

  (defun engine/search-dic-infor-sin-ap ()
    (interactive)
    (engine/search-dic-infor-sin (current-word)))
  (defengine dic-infor-sin "https://www.dicionarioinformal.com.br/sinonimos/%s")

  (defun my-engine-dic-infor-rimas-ap ()
    (interactive)
    (engine/search-dic-infor-rimas (current-word)))
  (defengine dic-infor-rimas "https://www.dicionarioinformal.com.br/rimas/%s")

  (defun my-engine-search-michaealis-ap ()
    (interactive)
    (engine/search-michaelis (current-word)))
  (defengine michaelis "https://michaelis.uol.com.br/moderno-portugues/busca/portugues-brasileiro/%s")

  (defun my-engine-rhymit-pt-ap ()
    (interactive)
    (engine/search-rhymit-pt (current-word)))
  (defengine rhymit-pt "https://www.rhymit.com/pt/palavras-que-rimam-com-%s?")

  (engine-mode t))

(use-package! fountain-mode
  :init
  (add-to-list 'auto-mode-alist '("\\ft\\'" . fountain-mode))
  (add-hook 'fountain-mode-hook (lambda () (+word-wrap-mode -1)))
  (add-hook! 'fountain-mode-hook
             #'auto-capitalize-mode
             #'electric-operator-mode
             #'olivetti-mode))

(use-package! url-shortener
  :custom
  (bitly-access-token "3026d7e8b1a0f89da10740c69fd77b4b3293151e"))

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
