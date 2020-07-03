(use-package! python
  :init

  (add-hook! '(python-mode-hook inferior-python-mode-hook)
             #'rainbow-delimiters-mode
             #'evil-swap-keys-swap-double-single-quotes
             #'evil-swap-keys-swap-underscore-dash
             #'evil-swap-keys-swap-colon-semicolon
             #'electric-operator-mode
             #'smartparens-strict-mode
             #'(lambda () (setq-local fill-column 57)))

  (add-hook! 'python-mode-hook
             #'elpy-mode
             #'apheleia-mode)
  :custom
  (python-shell-completion-native-enable nil)
  (python-indent-guess-indent-offset-verbose nil)
  :config

  (general-unbind
    :keymaps 'python-mode-map
    :with 'python-indent-dedent-line-backspace
    [remap evil-delete-backward-char-and-join])

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
    (windmove-down))

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

(use-package! dumb-jump
  :custom
  (dumb-jump-aggressive t))

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
  (company-global-modes '(not erc-mode text-mode org-mode markdown-mode message-mode help-mode gud-mode eshell-mode))

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

(use-package! prog-mode
  :init
  (remove-hook! 'prog-mode-hook 'display-line-numbers-mode 'highlight-numbers-mode)
  (add-hook! '(prog-mode-hook)
             #'electric-pair-local-mode
             #'hl-line-mode
             #'abbrev-mode)

  :general
  (:keymaps   '(prog-mode-map)
   :states    '(normal)
   "çç"        'dumb-jump-go
   "çb"        'dumb-jump-back
   "çl"        'dumb-jump-quick-look
   "çe"        'dumb-jump-go-prefer-external))

(use-package! conf-mode
  :config
  :general
  (:keymaps   '(conf-mode-map)
   :states    '(normal)))

(use-package! elisp-mode
  :init
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  :general
  (:keymaps   '(lisp-interaction-mode-map)
   :states    '(normal)
   "<escape>" 'evil-ex-nohighlight))

(use-package! flycheck
  :custom
  (flycheck-global-modes '(not lisp-interaction-mode
                               emacs-lisp-mode)))

(use-package! subword
  :config
  (global-subword-mode +1))

(use-package! eldoc
  :custom
  (eldoc-idle-delay 2)
  :config
  (global-eldoc-mode -1))

(use-package! projectile
  :custom
  (projectile-track-known-projects-automatically nil))
