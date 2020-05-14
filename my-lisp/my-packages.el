(use-package! evil
  :init
  (add-hook 'evil-insert-state-entry-hook 'evil-emacs-state)
  :bind (:map text-mode-map
         ("M-p" . evil-backward-paragraph)
         ("M-n" . evil-forward-paragraph)
         :map prog-mode-map
         ("M-p" . evil-backward-paragraph)
         ("M-n" . evil-forward-paragraph)
         :map evil-emacs-state-map
         ("<escape>" . evil-force-normal-state))
  :custom
  (evil-emacs-state-cursor '((bar . 3) +evil-emacs-cursor-fn))
  (evil-respect-visual-line-mode t)
  :config
  (advice-add '+evil-window-split-a :after #'evil-window-prev)
  (advice-add '+evil-window-vsplit-a :after #'evil-window-prev)
  (evil-visualstar-mode t))

(after! which-key
  (setq! which-key-idle-delay 0.5)
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
        :nv "f" 'evil-avy-goto-char-timer
        :nv "F" 'evil-avy-goto-char-2-above)
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
  ("C-s" . 'counsel-grep-or-swiper)
  ("C-/" . 'counsel-ag)
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
  :custom
  (word-wrap nil)
  (truncate-lines t)
  :config
  (map! :map (prog-mode-map)
        :nv "TAB" '+fold/toggle
        :n "<escape>" 'my-quiet-save-buffer))

(use-package! hydra
  :functions show-major-mode
  :config

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
    ("m" show-major-mode)
    ("o" describe-mode)

    ("k" describe-key-briefly)
    ("l" helpful-key)
    ("w" where-is)

    ("a" counsel-apropos)
    ("c" helpful-command)
    ("d" apropos-documentation)
    ("i" info))

  (defhydra hydra-window (:color pink :hint nil :exit nil :foreign-keys nil)
    ("<escape>" nil)
    ("L" evil-window-increase-width "+w")
    ("H" evil-window-decrease-width "+-w")
    ("J" evil-window-decrease-height "+h")
    ("K" evil-window-increase-height "-h")
    ("j" +evil-window-split-a "sp" :exit t)
    ("l" +evil-window-vsplit-a "vs" :exit t)
    ("b" balance-windows "bal" :exit t)))

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
  (remove-hook 'org-cycle-hook #'org-optimize-window-after-visibility-change))

(use-package! company
  :bind (:map company-active-map
         ("C-y" . my-company-yasnippet)
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

  ;; (set-company-backend! 'python-mode
  ;;   'company-jedi 'company-yasnippet)

  (defun my-company-yasnippet ()
    (interactive)
    (company-abort)))

(use-package! company-jedi
  :config
  (defun my/python-mode-hook ()
    (add-to-list 'company-backends 'company-jedi))

  (add-hook 'python-mode-hook 'my/python-mode-hook))

(use-package! shut-up
  :demand t)

(use-package! super-save
  :demand t
  :after shut-up
  :custom
  (auto-save-default nil)
  (super-save-idle-duration 5)
  (super-save-auto-save-when-idle nil)
  (super-save-triggers
   '(quickrun
     quit-window
     last-buffer
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
    (shut-up
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
       '(?d ?e ?h ?n ?o ?p ?s ?f ?c ?m ?q))))
    (message nil)
    (let* ((c (char-to-string path))
           (new-path
            (cl-case (intern c)
              ('d "~/dotfiles")
              ('e "~/.emacs.d")
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
  :bind (:map eyebrowse-mode-map
         ("M-q" . eyebrowse-prev-window-config)
         ("M-w" . eyebrowse-next-window-config))
  :custom
  (eyebrowse-wrap-around t)
  (eyebrowse-new-workspace t)
  (eyebrowse-mode-line-style 'smart)
  (eyebrowse-switch-back-and-forth t)
  (eyebrowse-mode-line-left-delimiter " [ ")
  (eyebrowse-mode-line-right-delimiter " ]  ")
  (eyebrowse-mode-line-separator " | ")
  :config
  (map! :leader "v" 'eyebrowse-create-window-config)
  (map! :leader "x" 'eyebrowse-close-window-config)
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

(use-package! xah-text
  :hook (prog-mode text-mode)
  :load-path  "~/.doom.d/my-lisp/text/xah-text")

(use-package! cool-moves
  :hook (prog-mode text-mode)
  :load-path "~/.doom.d/my-lisp/text/cool-moves")

(use-package! elpy
  :demand t
  :hook (python-mode . elpy-enable)
  :custom
  (elpy-rpc-virtualenv-path 'current))

(use-package doom-modeline
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

(use-package python
  :custom
  (python-indent-guess-indent-offset-verbose nil)
  :config
  (add-hook! 'python-mode-hook
             #'rainbow-delimiters-mode
             #'smartparens-strict-mode
             #'electric-operator-mode))
