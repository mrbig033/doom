(use-package! evil
  :init
  (add-hook 'evil-insert-state-exit-hook 'expand-abbrev)
  :custom
  (evil-jumps-cross-buffers t)
  (evil-visualstar/persistent t)
  (+evil-want-o/O-to-continue-comments nil)

  :config  

  (defun my-open-two-lines ()
    (interactive)
    (end-of-line)
    (newline-and-indent 2)
    (evil-insert-state))

  (evil-define-operator my-eval-region (beg end)
    "Evaluate selection or sends it to the open REPL, if available."
    :move-point nil
    (interactive "<r>")
    (eval-region beg end)
    (my-save-some-buffers)
    (message "region evaluated"))

  (add-hook 'evil-jumps-post-jump-hook 'my-recenter-window))

(use-package! evil-smartparens
  :config
  (general-unbind 'evil-smartparens-mode-map
    :with 'exchange-point-and-mark
    [remap evil-sp-override]))

(use-package! evil-swap-keys
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

(after! evil
  (evil-better-visual-line-on))

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))
