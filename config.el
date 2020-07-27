(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

(setq use-package-always-defer t
      confirm-kill-emacs nil)

(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))

(set-popup-rule! "^\\*Org Src" :ignore t)
(after! org (setq org-src-window-setup 'current-window))

(setq display-line-numbers-type nil
      doom-font (font-spec :family "Menlo" :size 19)
      doom-big-font (font-spec :family "Menlo" :size 19)
      doom-unicode-font (font-spec :family "Menlo" :size 19)
      doom-variable-pitch-font (font-spec :family "Input Mono")
      doom-theme 'doom-one)

(use-package! eyebrowse
  :demand t
  :config
  (map! :map override "M-w" 'eyebrowse-next-window-config
        :map override "M-q" 'eyebrowse-prev-window-config
        :leader "v" 'eyebrowse-create-window-config
        :leader "x" 'eyebrowse-close-window-config)
  (eyebrowse-mode +1))

(use-package! evil-god-state
  :init
  (map! :n "," 'evil-execute-in-god-state)
  :config
  (evil-define-key 'god global-map [escape] 'evil-god-state-bail))

(use-package! clipmon
  :custom
  (kill-ring-max 30)
  (savehist-autosave-interval (* 10 60))
  :config
  (clipmon-mode-start))

(use-package! helpful
  :custom
  (global-eldoc-mode -1)
  (help-window-select +1)
  :config
  (map! ("C-h e" 'describe-package
         :nvig "C-," 'helpful-at-point
         :map (helpful-mode-map help-mode-map)
         :nvig "C-r" 'helpful-update
         :n "<escape>" 'quit-window)))

(use-package! avy
  :init
  (map! :n "f" 'avy-goto-word-1-below
        :n "F" 'avy-goto-word-1-above))

(use-package! org
  :init
  (add-hook 'org-src-mode-hook 'my-indent-buffer)
  :custom
  (org-src-ask-before-returning-to-edit-buffer nil)
  (org-ellipsis ".")
  (org-directory "~/org/")
  :config

  (map! :map (evil-org-mode-map org-mode-map)
        :n "<backspace>" 'org-edit-special
        :n "zi" 'org-show-all)

  (general-unbind
    :keymaps '(org-src-mode-map prog-mode-map)
    :states 'normal
    :with 'org-edit-src-exit
    "<backspace>"))

(use-package! super-save
  :custom
  (auto-save-default nil)
  (super-save-exclude '(".py"))
  (super-save-remote-files nil)
  (super-save-auto-save-when-idle nil)
  :config
  (add-to-list 'super-save-triggers 'evil-switch-to-windows-last-buffer)
  (add-to-list 'super-save-hook-triggers 'find-file-hook)
  (super-save-mode +1))

(use-package! python
  :config
  (map! :map python-mode-map
        :n "<C-return>" 'quickrun))

(use-package! ranger
  :init
  (setq ranger-deer-show-details nil)
  :config
  (map! :map ranger-mode-map
        "q" 'ranger-close
        "<escape>" 'ranger-close
        :desc "Deer" :leader "r" 'deer))

(use-package! ivy
  :custom
  (ivy-height 15)
  (ivy-extra-directories nil)
  (counsel-outline-display-style 'title)
  (counsel-find-file-at-point t)
  (counsel-bookmark-avoid-dired t)
  (ivy-count-format "")
  (counsel-grep-swiper-limit 25000)
  (ivy-ignore-buffers '("^#.*#$"
                        "^\\*.*\\*"
                        "^agenda.org$"
                        "magit"
                        "*org-src-fontification.\\*"))

  (counsel-ag nil "~/.emacs.d/" "-G '.org'")

  :config

  (map! :nvi "C-s" 'counsel-grep-or-swiper
        :nvi "M-y" 'counsel-yank-pop
        :nvi "C-." 'counsel-projectile-switch-to-buffer
        :nvi "C-<" 'ivy-switch-buffer
        :nvi "M-u" 'yas-insert-snippet
        :nvi "C-s" 'counsel-grep-or-swiper
        :desc "Counsel Ag" :leader "sg"  'counsel-ag)

  (map! :map (ivy-minibuffer-map ivy-switch-buffer-map)
        "M-y"      'ivy-next-line
        "M-r"      'ivy-next-line
        "C-,"      'ivy-next-line
        "C-."      'ivy-next-line
        "C-/"      'ivy-next-line
        "C-j"      'ivy-immediate-done
        "M-q"      'ivy-done
        "C-k"      'kill-line
        "C-d"      'delete-char
        "C-h"      'delete-backward-char
        "C-w"      'backward-kill-word
        "<insert>" 'yank))

(use-package! company
  :custom
  (company-ispell-available t)
  (company-show-numbers t)
  (company-idle-delay 0.2)
  (company-tooltip-limit 10)
  (company-minimum-prefix-length 1)
  (company-dabbrev-other-buffers t)
  (company-selection-wrap-around t)
  (company-auto-complete nil)
  (company-dabbrev-ignore-case 'keep-prefix)
  (company-global-modes '(not erc-mode
                              ;; text-mode
                              ;; org-mode
                              ;; markdown-mode
                              message-mode
                              help-mode
                              gud-mode
                              eshell-mode))

  :general
  (:keymaps '(company-active-map)
   "<return>" nil
   "TAB"      nil
   "C-h"    'backward-delete-char
   "M-e"    'my-company-yasnippet
   "M-q"    'company-complete-selection
   "C-d"    'counsel-company
   "M-w"    'my-company-comp-with-paren
   "M-."    'my-company-comp-with-dot
   "M-j"    'my-company-comp-space
   "C-u"    'my-backward-kill-line
   "M-0"    'company-complete-number
   "M-1"    'company-complete-number
   "M-2"    'company-complete-number
   "M-3"    'company-complete-number
   "M-4"    'company-complete-number
   "M-5"    'company-complete-number
   "M-6"    'company-complete-number
   "M-7"    'company-complete-number
   "M-8"    'company-complete-number
   "M-9"    'company-complete-number)

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

(use-package! which-key
  :custom
  (which-key-idle-delay 0.5))

(define-key key-translation-map (kbd "s-(") (kbd "{"))
(define-key key-translation-map (kbd "s-)") (kbd "}"))
(define-key key-translation-map (kbd "<f19>") (kbd "C-c"))
(define-key key-translation-map (kbd "<f18>") (kbd "C-x"))

(map! :map override
      "C-0"            'insert-char
      "M-0"            'quit-window
      "M-9"            'delete-other-windows
      :i "C-u"         'my-backward-kill-line
      :n "ge"          'evil-end-of-visual-line
      :n "gr"          'my-sel-to-end
      :v "gr"          'eval-region
      :nv "C-s"        'counsel-grep-or-swiper
      :n "'"           'evil-goto-mark
      :n "`"           'evil-goto-mark-line
      :n "0"           'evil-beginning-of-visual-line
      :n "g0"          'evil-digit-argument-or-evil-beginning-of-line
      :n "M-k"         'windmove-up
      :n "M-j"         'windmove-down
      :n "M-h"         'windmove-left
      :n "M-l"         'windmove-right
      :v "C-c a"       'align-regexp
      :n "M-o"         'better-jumper-jump-backward
      :n "M-i"         'better-jumper-jump-forward
      :v "K"           'ignore
      :i "C-h"         'delete-backward-char
      "M-s"            'evil-switch-to-windows-last-buffer)

(map! :n "<escape>"    'my-save-buffer
      :n "C-o"         'my-counsel-outline)

(map! :map (prog-mode-map)
      :i "M-e"         'yas-expand
      :n "M-RET"       'my-indent-buffer)

(map! :desc "Kill Buffer"    :leader "k"   'kill-this-buffer
      :desc "Show Server"    :leader "hn"  'my-show-server
      :desc "Show Mode"      :leader "hM"  'my-show-major-mode
      :desc "Goto Agenda"    :leader "fa"  'goto-agenda
      :desc "Goto List"      :leader "fl"  'deer-goto-lisp
      :desc "Goto Pkgs"      :leader "fp"  'goto-packages
      :desc "Goto Setqs"     :leader "fs"  'goto-settings
      :desc "Goto MD"        :leader "fm"  'goto-markdown
      :desc "Goto Config"    :leader "fc"  'my-doom-goto-private-config-org-file
      :desc "Goto Org"       :leader "fo"  'goto-org
      :desc "Tangle"         :leader "tt"  'my-tangle-config
      :desc "Sort by Length" :leader "tC"  'my-sort-lines-by-length
      :desc "Change Dict"    :leader "td"  'ispell-change-dictionary
      :desc "Yes New"        :leader "tyn" 'yas-new-snippet
      :desc "Yes Visit"      :leader "tyv" 'yas-visit-snippet-file
      :desc "Yes Reload"     :leader "tyr" 'yas-reload-all
      :desc "Flyspell"       :leader "tF"  'flyspell-mode)

(setq doom-localleader-key "m")

(defun my-backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(defun my-backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(defun my-sel-to-end ()
  (interactive)
  (evil-visual-char)
  (evil-last-non-blank))

(defun my-indent-buffer ()
  (interactive)
  (let ((inhibit-message t))
    (evil-indent
     (point-min)
     (point-max))))

(defun my-save-buffer ()
  (interactive)
  (evil-ex-nohighlight)
  (save-buffer))

(defun goto-settings ()
  (interactive)
  (counsel-ag nil "~/.doom.d/" "-f -G '.org'"))

(defun goto-functions ()
  (interactive)
  (counsel-ag "(defun " "~/.doom.d" "-f -G '.org'")
  (my-recenter-window))

(defun my-recenter-window ()
  (interactive)
  (recenter-top-bottom
   `(4)))

(defun goto-packages ()
  (interactive)
  (counsel-ag "(use-package! " "~/.doom.d" "-f -G '.org'")
  (my-recenter-window))

(defun my-tangle-config ()
  (interactive)
  (my-save-some-buffers)
  (start-process-shell-command "tangle config.org" nil "~/dotfiles/scripts/emacs_scripts/nt-config")
  (message " config tangled"))

(defun my-tangle-restart ()
  (interactive)
  (my-save-some-buffers)
  (start-process-shell-command "tangle restart" nil "~/dotfiles/scripts/emacs_scripts/nt-config")
  (doom/restart-and-restore))

(defun my-tangle-debug ()
  (interactive)
  (my-save-some-buffers)
  (start-process-shell-command "tangle restart" nil "emacs --debug-init &")
  (message " tangle debug"))

(map! :desc "Tangle Init" :leader "att" 'my-tangle-config)

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

(defun my-show-server ()
  (interactive)
  (describe-variable 'server-name))

(defun my-show-major-mode ()
  (interactive)
  (describe-variable 'major-mode))

(defun my-counsel-outline ()
  (interactive)
  (my-widen-to-center)
  (counsel-outline))

(defun my-widen-to-center ()
  (interactive)
  (widen)
  (recenter-top-bottom))

(defun my-save-some-buffers ()
  (interactive)
  (let ((inhibit-message t))
    (evil-ex-nohighlight)
    (save-some-buffers t 0)))

(defun my-doom-goto-private-config-org-file ()
  "Open your private config.org file."
  (interactive)
  (find-file (expand-file-name "config.org" doom-private-dir)))

(defun xah-clean-empty-lines ()
  "replace repeated blank lines to just 1."
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
