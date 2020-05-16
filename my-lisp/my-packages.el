(use-package! evil
  :bind (:map evil-insert-state-map
         ("C-p"      . evil-previous-line)
         ("C-n"      . evil-next-line)
         ("C-u"      . my-backward-kill-line)
         ("C-h"      . evil-delete-backward-char-and-join)
         ("C-k"      . kill-line)
         ("C-c u"    . universal-argument)
         ("<f1>" . hydra-help/body)
         :map evil-normal-state-map
         ("C-h" . hydra-help/body)
         ("<f1>" . hydra-help/body)
         ("zi" . '+fold/open-all)
         :map text-mode-map
         ("M-p"      . evil-backward-paragraph)
         ("M-n"      . evil-forward-paragraph)
         :map prog-mode-map
         ("M-p"      . evil-backward-paragraph)
         ("M-n"      . evil-forward-paragraph)
         :map evil-emacs-state-map
         ("C-w"      . backward-kill-word)
         ("<escape>" . evil-force-normal-state)
         ("C-u"      . my-backward-kill-line)
         ("C-c u"    . universal-argument)
         ("C-h"      . backward-delete-char))

  :custom
  (evil-emacs-state-cursor '((bar . 3) +evil-emacs-cursor-fn))
  (evil-respect-visual-line-mode t)
  :config
  (evil-set-initial-state 'pdf-view-mode 'emacs)

  (map! :nv "$" 'evil-last-non-blank)
  (map! :nv "g_" 'evil-end-of-line)
  (map! :n "go" 'cool-moves-open-line-below)
  (map! :n "gi" 'cool-moves-open-line-above)
  (map! :nv "gr" 'my-evil-sel-to-end)
  (map! :nv "gt" '+eval/line-or-region)
  (map! :n "ge" 'evil-end-of-visual-line)
  (map! :leader "su" 'my-evil-substitute)
  (advice-add '+evil-window-split-a :after #'evil-window-prev)
  (advice-add '+evil-window-vsplit-a :after #'evil-window-prev)
  (defun my-evil-substitute ()
    (interactive)
    (evil-ex "%s/"))
  (defun my-evil-sel-to-end ()
    (interactive)
    (evil-visual-char)
    (evil-last-non-blank))

  (evil-visualstar-mode t))

(use-package! which-key
  :config
  (which-key-add-key-based-replacements
    "SPC tc" "Clean Lines"
    "SPC td" "Dup Lines"
    "SPC td" "Dup Par")
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
  (map! :map global
        :nv "F" 'evil-avy-goto-char-2-above
        :nv "f" 'evil-avy-goto-char-2-below)
  :config
  (setq! avy-keys (nconc (number-sequence ?a ?z)
                         (number-sequence ?0 ?9))))

(use-package! helpful
  :bind
  ("C-;" . helpful-at-point)
  ("C-c h" . my-helpful-options)
  :custom
  (help-window-select t)
  :config
  (defun my-helpful-options ()
    (interactive)
    (counsel-M-x "^helpful-")))

(use-package! ivy
  :bind
  (("C-s" . 'counsel-grep-or-swiper)
   ("C-/" . 'counsel-projectile-ag)
   ("M-r" . 'ivy-switch-buffer)
   ("M-;" . 'counsel-projectile-switch-to-buffer)
   :map ivy-minibuffer-map
   ("C-h" . 'backward-delete-char-untabify))
  :custom
  (ivy-extra-directories nil)
  (counsel-outline-display-style 'title)
  (counsel-find-file-at-point t)
  (counsel-bookmark-avoid-dired t)
  (ivy-count-format "")
  (counsel-ag-base-command "ag --filename --nocolor --nogroup --smart-case --skip-vcs-ignores --silent --ignore '*.html' --ignore '*.elc' %s")
  (ivy-ignore-buffers '("^#.*#$"
                        "^\\*.*\\*"
                        "^init.org$"
                        "^agenda.org$"
                        "magit"
                        "*org-src-fontification.\\*"))
  :config
  (map! :nv ";" 'counsel-M-x))

(use-package! prog-mode
  :hook (prog-mode . hl-line-mode)
  :custom
  (word-wrap nil)
  (truncate-lines t)
  :config
  (map! :map (prog-mode-map)
        :nv "TAB"     '+fold/toggle
        :n "<escape>" 'my-quiet-save-buffer
        "M-m"         'flycheck-first-error))

(use-package! hydra
  :config
  (map! :leader "j" 'hydra-org-clock/body))

(use-package! windmove
  :bind
  ("M-h" . windmove-left)
  ("M-l" . windmove-right)
  ("M-j" . windmove-down)
  ("M-k" . windmove-up)
  :custom
  (windmove-wrap-around t))

(use-package! winner
  :bind
  ("M--" . winner-undo)
  ("M-=" . winner-redo)
  :config
  (winner-mode +1))

(use-package! org
  :init
  (remove-hook 'org-cycle-hook #'org-optimize-window-after-visibility-change)
  :custom
  (org-ellipsis ".")
  :config
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
  :init
  :custom
  (company-minimum-prefix-length 1)
  (company-show-numbers t)
  (company-tooltip-limit 10)
  (company-dabbrev-other-buffers t)
  (company-selection-wrap-around t)
  (company-dabbrev-ignore-case 'keep-prefix)

  :bind (:map company-active-map
         ("C-y" . my-company-yasnippet)
         ("C-u" . company-yasnippet)
         ("M-q" .  company-complete-selection)
         ("M-w" .  my-company-comp-with-paren)
         ("M-." .  my-company-comp-with-dot)
         ("M-j" .  my-company-comp-space)
         ("C-h" .  delete-backward-char)
         ("M-0" . company-complete-number)
         ("M-1" . company-complete-number)
         ("M-2" . company-complete-number)
         ("M-3" . company-complete-number)
         ("M-4" . company-complete-number)
         ("M-5" . company-complete-number)
         ("M-6" . company-complete-number)
         ("M-7" . company-complete-number)
         ("M-8" . company-complete-number)
         ("M-9" . company-complete-number))
  :config
  (setq company-backends '(company-bbdb
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
  :bind (:map ranger-mode-map
         ("i"          . my-ranger-go)
         ("M-9"        . delete-other-windows)
         ("tp"         . delete-file)
         ("<escape>"   . ranger-close)
         ("gg"         . ranger-goto-top)
         ("zp"         . ranger-preview-toggle)
         ("çcm"        . dired-create-directory)
         ("C-c l"      . counsel-find-file)
         ("d"          . dired-do-flagged-delete)
         ("x"          . diredp-delete-this-file)
         ("d"          . dired-flag-file-deletion)
         ("<c-return>" . dired-do-find-marked-files))
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
  (defun my-ranger-go (path)
    "Go subroutine"
    (interactive
     (list
      (read-char-choice
       "
    d : dotfiles  n : downloads  s : scripts  m: doom
    e : emacs     o : org        f: config    q: quit
    h : home      p: python      c: documents
  > "
       '(?d ?e ?E ?h ?n ?o ?p ?s ?f ?c ?m ?q))))
    (message nil)
    (let* ((c (char-to-string path))
           (new-path
            (cl-case (intern c)
              ('d "~/dotfiles")
              ('e "~/.emacs.d")
              ('E "~/emacs/.emacs.d")
              ('m "~/.doom.d")
              ('h "~")
              ('n "~/Downloads")
              ('o "~/org")
              ('p "~/Documents/Python")
              ('s "~/scripts")
              ('f "~/.config")
              ('c "~/Documents")
              ('q "quit")))
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
        (call-interactively alt-option)))))

(use-package! eyebrowse
  :init
  (map! :leader "v" 'eyebrowse-create-window-config)
  (map! :leader "x" 'eyebrowse-close-window-config)
  (map! :leader "M-q" 'eyebrowse-close-window-config)
  (map! :leader "M-w" 'eyebrowse-next-window-config)
  :custom
  (eyebrowse-wrap-around t)
  (eyebrowse-new-workspace t)
  (eyebrowse-mode-line-style 'smart)
  (eyebrowse-switch-back-and-forth t)
  (eyebrowse-mode-line-left-delimiter " [ ")
  (eyebrowse-mode-line-right-delimiter " ]  ")
  (eyebrowse-mode-line-separator " | ")
  :config
  (eyebrowse-mode +1))

(use-package! nswbuff
  :bind
  ("M-," . nswbuff-switch-to-previous-buffer)
  ("M-." . nswbuff-switch-to-next-buffer)
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
  :bind (:map python-mode-map
         ("M-a"        . 'python-nav-backward-statement)
         ("M-e"        . 'python-nav-forward-statement)
         ("C-x m"      . 'elpy-multiedit-python-symbol-at-point)
         ("C-x M"      . 'elpy-multiedit-stop))

  :custom
  (python-indent-guess-indent-offset-verbose nil)
  :config
  (map! :map python-mode-map
        :nvi "<C-return>" 'quickrun
        :e "C-h"'python-indent-dedent-line-backspace)

  (defun my-python-shebang ()
    (interactive)
    (kill-region (point-min) (point-max))
    (insert "#!/usr/bin/env python3\n\n")
    (evil-insert-state)))

(use-package! olivetti
  :custom
  (olivetti-body-width 95))

(load! "cool-moves.el" my-load!)

(load! "xah-text.el" my-load!)

(use-package! pdf-tools
  :bind (:map pdf-view-mode-map
         ("q"   . my-last-buffer)
         ("C-l" . my-show-pdf-view-commands))
  :custom
  (pdf-view-continuous nil)
  (pdf-view-resize-factor 1.15)
  (pdf-misc-size-indication-minor-mode t)
  :config
  (map! :map pdf-view-mode-map ("<escape>" 'my-last-buffer))
  (defun my-show-pdf-view-commands ()
    (interactive)
    (counsel-M-x "^pdf-view- ")))

(use-package! flycheck
  :custom
  (flycheck-idle-change-delay 0.3)
  (flycheck-check-syntax-automatically '(save
                                         idle-change
                                         idle-buffer-switch
                                         new-line
                                         mode-enabled))

  (flycheck-sh-shellcheck-executable "/usr/local/bin/shellcheck"))

(use-package! message
  :config
  (read-only-mode -1))

(straight-use-package '(apheleia :host github :repo "raxod502/apheleia")
                      :config
                      (after! apheleia
                        (setf (alist-get 'black apheleia-formatters) '("black" "-l" "79" "-"))))
