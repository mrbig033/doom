(use-package! evil
  :custom
  (evil-emacs-state-cursor '((bar . 3) +evil-emacs-cursor-fn))
  (evil-respect-visual-line-mode t)
  (evil-visualstar/persistent t)
  :config
  ;; (evil-set-initial-state 'pdf-view-mode 'emacs)

  (map! :g "M-n"      'evil-forward-paragraph
        :g "M-p"      'evil-backward-paragraph
        :e "<escape>" 'evil-force-normal-state
        :e "C-c u"    'universal-argument
        :e "C-h"      'backward-delete-char
        :e "C-u"      'my-backward-kill-line
        :e "C-w"      'backward-kill-word
        :i "<f1>"     'hydra-help/body
        :i "C-c u"    'universal-argument
        :i "C-d"      'delete-forward-char
        :i "C-h"      'evil-delete-backward-char-and-join
        :i "C-k"      'kill-line
        :i "C-n"      'evil-next-line
        :i "C-p"      'evil-previous-line
        :i "C-u"      'my-backward-kill-line
        :n "<f1>"     'hydra-help/body
        :n "<f8>"     'counsel-M-x
        :ng "C-h"     'hydra-help/body
        :n "C-k"      'my-kill-visual-line-and-insert
        :n "ge"       'evil-end-of-visual-line
        :n "gi"       'cool-moves-open-line-above
        :n "go"       'cool-moves-open-line-below
        :n "'"        'evil-goto-mark
        :n "`"        'evil-goto-mark-line
        :nv ";"       'evil-repeat
        :nv "$"       'evil-last-non-blank
        :nv "g_"      'evil-end-of-line
        :nv "g_"      'evil-end-of-line
        :nv "gr"      'my-evil-sel-to-end
        :nv "gt"      '+eval/line-or-region
        :nv "M-i"     'better-jumper-jump-forward
        :nvi "M-o"    'better-jumper-jump-backward
        :map (minibuffer-local-map
              minibuffer-local-ns-map
              minibuffer-local-completion-map
              minibuffer-local-must-match-map
              minibuffer-local-isearch-map
              read-expression-map
              ivy-minibuffer-map
              ivy-switch-buffer-map
              evil-ex-completion-map
              evil-ex-search-keymap)
        :nvig "<insert>" 'yank
        :nvig "C-k"      'kill-line
        :nvig "C-d"      'delete-char
        :nvig "C-h"      'delete-backward-char
        :n "zi"       '+fold/open-all
        :map (global evil-org-mode-map)
        :n "zi"       '+fold/open-all
        :leader "su"  'my-evil-substitute)

  (advice-add '+evil-window-split-a :after #'evil-window-prev)
  (advice-add '+evil-window-vsplit-a :after #'evil-window-prev)

  (defun my-evil-substitute ()
    (interactive)
    (evil-ex "%s/"))

  (defun my-evil-sel-to-end ()
    (interactive)
    (evil-visual-char)
    (evil-last-non-blank))

  (defun my-evil-set-mark-A ()
    (interactive)
    (evil-set-marker 65))

  (defun my-evil-goto-mark-A ()
    (interactive)
    (evil-goto-mark 65))

  (evil-visualstar-mode t))

(use-package! which-key
  :config
  (which-key-add-key-based-replacements
    "SPC tc" "Clean Lines"
    "SPC td" "Dup Lines"
    "SPC bl" "Kill Matching"
    "SPC td" "Dup Par"
    "SPC bY" "Yank Dir"
    "SPC fk" "Search Pkgs")
  (setq! which-key-idle-delay 0.3)
  (which-key-mode +1))

(use-package! avy
  :custom
  (avy-case-fold-search 't)
  (avy-style 'at-full)
  (avy-timeout-seconds 0.3)
  (avy-highlight-first t)
  (avy-single-candidate-jump t)
  :custom-face
  (avy-background-face((t (:foreground "LightSkyBlue4"))))
  :init
  (map! :nv "F" 'evil-avy-goto-char-2-above
        :nv "f" 'evil-avy-goto-char-2-below)
  :config
  (setq! avy-keys (nconc (number-sequence ?a ?z)
                         (number-sequence ?0 ?9))))

(use-package! helpful
  :init
  (map! "C-;" 'helpful-at-point
        "C-c h" 'my-helpful-options)
  :custom
  (help-window-select t)
  :config
  (defun my-helpful-options ()
    (interactive)
    (counsel-M-x "^helpful-")))

(use-package! ivy
  :custom
  (ivy-extra-directories nil)
  (counsel-outline-display-style 'title)
  (counsel-find-file-at-point t)
  (counsel-bookmark-avoid-dired t)
  (ivy-count-format "")
  (counsel-ag-base-command "ag --filename --nocolor --nogroup --smart-case --skip-vcs-ignores --silent --ignore '*.html' --ignore '*.elc' %s")

  (ivy-ignore-buffers '("^#.*#$"
                        "^\\*.*\\*"
                        "^agenda.org$"
                        "magit"
                        "*org-src-fontification.\\*"))
  :config

  (map! :nvig "C-s"      'counsel-grep-or-swiper
        :nvig "C-/"      'counsel-projectile-ag
        :nvig "M-r"      'counsel-projectile-switch-to-buffer
        :nvig "C-,"      'ivy-switch-buffer
        :nv "."          'counsel-M-x
        :map ivy-minibuffer-map
        :g "M-r"      'ivy-next-line
        :g "C-,"      'ivy-next-line
        :g "M-w"      'ivy-done
        :g "C-."      'ivy-done
        :g "<insert>" 'yank)

  (defun ivy-with-thing-at-point (cmd)
    (let ((ivy-initial-inputs-alist
           (list
            (cons cmd (thing-at-point 'symbol)))))
      (funcall cmd)))

  (defun counsel-ag-thing-at-point ()
    (interactive)
    (ivy-with-thing-at-point 'counsel-ag))

  (defun counsel-projectile-ag-thing-at-point ()
    (interactive)
    (ivy-with-thing-at-point 'counsel-projectile-ag)))

(use-package unkillable-scratch
  :config
  (setq unkillable-scratch-behavior 'bury
        unkillable-buffers '("^agenda.org$"
                             "^pytasks.org$"
                             "config.el"
                             "defaults.el"
                             "defaults.el"
                             "init.el"
                             "my-hydras.el"
                             "my-packages.el"
                             "my-packages.el"
                             "my-settings.el"
                             "my-settings.el"
                             "packages.el"))
  (unkillable-scratch +1))

(use-package! prog-mode
  :hook (prog-mode . hl-line-mode)
  :custom
  (word-wrap nil)
  (truncate-lines t)
  :config
  (map! :map (prog-mode-map)
        "M-p"         'my-par-backward-to-indentation
        "M-n"         'my-par-forward-to-indentation
        :nv "TAB"     '+fold/toggle
        :n "<escape>" 'my-quiet-save-buffer
        "M-m"         'flycheck-first-error))

(use-package! hydra
  :config
  (map! :leader "j" 'hydra-org-clock/body))

(use-package ivy-hydra
  :disabled
  :after hydra)

(use-package! windmove
  :init
  (map! :map (global evil-org-mode-map)
        :nvig "M-h" 'windmove-left
        :nvig "M-l" 'windmove-right
        :nvig "M-j" 'windmove-down
        :nvig "M-k" 'windmove-up)
  :custom
  (windmove-wrap-around t))

(use-package! winner
  :config
  (map! :g "M--" 'winner-undo
        :g "M-=" 'winner-redo)
  (winner-mode +1))

(use-package! org
  :init
  (remove-hook 'org-cycle-hook 'org-optimize-window-after-visibility-change)
  (add-hook 'org-cycle-hook 'org-cycle-hide-drawers)
  :custom

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
  (org-edit-src-auto-save-idle-delay 1)
  (org-edit-src-persistent-message nil)
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
  (org-src-ask-before-returning-to-edit-buffer nil)
  (org-src-preserve-indentation t)
  (org-src-window-setup 'current-window)
  (org-timer-format "%s ")
  (org-todo-keywords '((sequence "TODO(t)" "STRT(s!)" "|" "DONE(d!)")))

  :config

  (org-indent-mode t)
  (setq org-agenda-files '("~/org/Agenda"))

  (map! :map (org-mode-map evil-org-mode-map)
        :nv "gr"      'my-evil-sel-to-end
        :v "<insert>" 'org-insert-link
        :i "C-l"      'completion-at-point)

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

(use-package! org-pomodoro
  :after org
  :custom
  (org-pomodoro-offset 1)
  (org-pomodoro-start-sound-args t)
  (org-pomodoro-length (* 25 org-pomodoro-offset))
  (org-pomodoro-short-break-length (/ org-pomodoro-length 5))
  (org-pomodoro-long-break-length (* org-pomodoro-length 0.8))
  (org-pomodoro-long-break-frequency 4)
  (org-pomodoro-ask-upon-killing nil)
  (org-pomodoro-manual-break t)
  (org-pomodoro-keep-killed-pomodoro-time t)
  (org-pomodoro-time-format "%.2m")
  (org-pomodoro-short-break-format "SHORT: %s")
  (org-pomodoro-long-break-format "LONG: %s")
  (org-pomodoro-format "P: %s"))

(use-package! company
  :custom
  (company-minimum-prefix-length 1)
  (company-show-numbers t)
  (company-tooltip-limit 10)
  (company-dabbrev-other-buffers t)
  (company-selection-wrap-around t)
  (company-dabbrev-ignore-case 'keep-prefix)
  (company-global-modes '(not erc-mode message-mode help-mode gud-mode eshell-mode text-mode org-mode))
  (company-backends '(company-bbdb
                      company-eclim
                      company-semantic
                      company-clang
                      company-xcode
                      company-cmake
                      company-capf
                      company-files (company-dabbrev-code company-gtags
                                                          company-etags
                                                          company-keywords)
                      company-oddmuse
                      company-dabbrev))
  :config
  (map! :map company-active-map
        "C-y" 'my-company-yasnippet
        "C-u" 'company-yasnippet
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
  :demand t
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

  (defun super-save-command ()
    "Save the current buffer if needed."
    (let ((inhibit-message t))
      (when (and buffer-file-name
                 (buffer-modified-p (current-buffer))
                 (file-writable-p buffer-file-name)
                 (if (file-remote-p buffer-file-name) super-save-remote-files t)
                 (super-save-include-p buffer-file-name))
        (save-buffer))))

  (super-save-mode t))

(use-package! ivy-prescient
  :hook ivy
  :config
  (ivy-prescient-mode +1))

(use-package! ranger
  :init

  (add-hook 'ranger-mode-hook 'olivetti-mode)

  :custom
  (ranger-max-tabs 0)
  (ranger-minimal nil)
  (ranger-footer-delay 0)
  (ranger-parent-depth 1)
  (ranger-footer-delay nil)
  (ranger-preview-file nil)
  (ranger-override-dired t)
  (ranger-persistent-sort t)
  (ranger-cleanup-eagerly t)
  (ranger-dont-show-binary nil)
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

  (map! :map ranger-mode-map
        "i"          'my-ranger-go
        "M-9"        'delete-other-windows
        "tp"         'delete-file
        "<escape>"   'ranger-close
        "m"          'my-ranger-toggle-mark-and-advance
        "gg"         'ranger-goto-top
        "zp"         'ranger-preview-toggle
        "çcm"        'dired-create-directory
        "C-c l"      'counsel-find-file
        "d"          'dired-do-flagged-delete
        "x"          'diredp-delete-this-file
        "d"          'dired-flag-file-deletion
        "<c-return>" 'dired-do-find-marked-files
        :leader "R" 'my-deer-goto-my-lisp)

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
    (deer my-lisp))

  (defun my-ranger-toggle-mark-and-advance ()
    (interactive)
    (ranger-toggle-mark)
    (ranger-next-file 1))

  )

(use-package! eyebrowse
  :demand t
  :custom
  (eyebrowse-wrap-around t)
  (eyebrowse-new-workspace t)
  (eyebrowse-mode-line-style 'smart)
  (eyebrowse-switch-back-and-forth t)
  (eyebrowse-mode-line-left-delimiter " [ ")
  (eyebrowse-mode-line-right-delimiter " ]  ")
  (eyebrowse-mode-line-separator " | ")
  :config
  (map! "M-q"       'eyebrowse-prev-window-config
        "M-w"       'eyebrowse-next-window-config
        :leader "v" 'eyebrowse-create-window-config
        :leader "x" 'eyebrowse-close-window-config)

  (eyebrowse-mode +1))

(use-package! nswbuff
  :init
  (map! :nvig "M-," 'nswbuff-switch-to-previous-buffer
        :nvig "M-." 'nswbuff-switch-to-next-buffer)
  :custom
  (nswbuff-left "  ")
  (nswbuff-clear-delay 2)
  (nswbuff-delay-switch nil)
  (nswbuff-this-frame-only 't)
  (nswbuff-recent-buffers-first t)
  (nswbuff-start-with-current-centered t)
  (nswbuff-display-intermediate-buffers t)
  (nswbuff-buffer-list-function 'nswbuff-projectile-buffer-list)
  (nswbuff-exclude-mode-regexp excluded-modes)
  (nswbuff-exclude-buffer-regexps '("^ " "^#.*#$" "^\\*.*\\*")))

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
  (doom-modeline-env-enable-elixir nil)
  (doom-modeline-env-load-string ".")
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-checker-simple-format t)
  (doom-modeline-buffer-modification-icon nil)
  (doom-modeline-buffer-file-name-style 'buffer-name))

(use-package! elpy
  :demand t
  :custom
  (elpy-rpc-virtualenv-path 'current)
  :config
  (elpy-enable))

(use-package! python
  :init

  (add-hook! 'python-mode-hook
             #'rainbow-delimiters-mode
             #'smartparens-strict-mode
             #'electric-operator-mode
             #'elpy-mode
             #'apheleia-mode)

  :custom
  (python-indent-guess-indent-offset-verbose nil)
  :config

  (map! :map python-mode-map
        "M-a"   'python-nav-backward-statement
        "M-e"   'python-nav-forward-statement
        "C-x m" 'elpy-multiedit-python-symbol-at-point
        "C-x M" 'elpy-multiedit-stop
        :e "C-h"'python-indent-dedent-line-backspace
        :n "<return>" 'hydra-python-mode/body
        :nvi "<C-return>" 'quickrun)

  (defun my-python-shebang ()
    (interactive)
    (kill-region (point-min) (point-max))
    (insert "#!/usr/bin/env python3\n\n")
    (evil-insert-state)))

(use-package! olivetti
  :custom
  (olivetti-body-width 95))

(use-package! pdf-tools
  :custom

  (pdf-view-continuous t)
  (pdf-view-resize-factor 1.15)
  (pdf-misc-size-indication-minor-mode t)

  :config

  (map! :map pdf-view-mode-map
        :nvieg "<escape>" 'quit-window
        :nvieg "q"        'quit-window
        :nvieg "w"        'pdf-view-fit-width-to-window
        :nvieg "C-l"      'my-show-pdf-view-commands)

  (defun my-show-pdf-view-commands ()
    (interactive)
    (counsel-M-x "^pdf-view- ")))

(use-package! flycheck
  :custom
  (flycheck-display-errors-delay 0.1)
  (flycheck-check-syntax-automatically '(save
                                         mode-enabled))

  (flycheck-sh-shellcheck-executable "/usr/local/bin/shellcheck"))

(use-package! message
  :config
  (read-only-mode -1))

(use-package treemacs
  :demand t
  :custom
  (treemacs-width 23)
  (treemacs-indentation '(10 px))
  (treemacs-follow-mode t)
  (treemacs-is-never-other-window t)
  (doom-themes-treemacs-enable-variable-pitch nil)
  :custom-face
  (treemacs-root-face ((t (:inherit font-lock-string-face :weight bold :height 1.1))))
  :config
  (map! :g "C-0" '+treemacs/toggle
        :map treemacs-mode-map
        "a" 'treemacs-add-project-to-workspace
        "d" 'treemacs-remove-project-from-workspace
        "D" 'treemacs-delete
        "p" 'treemacs-projectile
        "<C-return>" 'my-treemacs-visit-node-and-hide
        "C-0" 'treemacs-quit
        "C-c t" 'my-show-treemacs-commands
        "<escape>" 'treemacs-quit)

  (defun my-treemacs-commands ()
    (interactive)
    (counsel-M-x "^treemacs- "))

  (defun my-treemacs-visit-node-and-hide ()
    (interactive)
    (treemacs-visit-node-default)
    (+treemacs/toggle))

  (treemacs-resize-icons 15))

(use-package clipmon
  :custom
  (selection-coding-system 'utf-8-unix)
  :config
  (clipmon-mode +1))

(use-package evil-god-state
  :init
  (map! :n ","          'evil-execute-in-god-state
        :map god-local-mode-map
        :nig "<escape>" 'evil-god-state-bail
        :nig ","        'evil-god-state-bail)
  :custom
  (selection-coding-system 'utf-8-unix))

(use-package! apheleia-mode
  :config
  (after! apheleia
    (setf (alist-get 'black apheleia-formatters) '("black" "-l" "79" "-"))))

(use-package paren
  :ensure nil
  :custom
  (blink-matching-paren-dont-ignore-comments t)
  (show-paren-ring-bell-on-mismatch nil)
  :custom-face
  (show-paren-match ((t(:background "#292929"
                        :foreground "dark orange"
                        :inverse-video nil
                        :underline nil
                        :slant normal
                        :weight ultrabold)))))

(load! "cool-moves.el" my-load!)

(load! "xah-text.el" my-load!)

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))
