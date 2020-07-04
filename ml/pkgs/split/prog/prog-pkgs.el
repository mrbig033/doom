(use-package! dumb-jump
  :custom
  (dumb-jump-aggressive t))

(use-package! company
  :custom
  (company-ispell-available t)
  (company-show-numbers t)
  (company-idle-delay 0.1)
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
  (:keymaps                    '(company-active-map)
   "M-e"                       'my-company-yasnippet
   "C-y"                       'company-yasnippet
   "<return>"                  nil
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

(define-derived-mode scratch-lisp-mode
  lisp-interaction-mode "scratch-lisp")

(after! apheleia
  (setf (alist-get 'black apheleia-formatters) '("black" "-l" "57" "-")))
