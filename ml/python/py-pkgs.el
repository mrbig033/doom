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
