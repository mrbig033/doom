(use-package! treemacs
  :after-call after-find-file
  :custom
  (treemacs-width 15)
  (treemacs-indentation '(1 px))
  (treemacs-file-follow-delay 0.1)
  (treemacs-show-hidden-files nil)
  (treemacs-is-never-other-window nil)
  (treemacs-no-delete-other-windows t)
  (doom-themes-treemacs-enable-variable-pitch nil)
  :custom-face
  (treemacs-root-face ((t (:inherit font-lock-string-face
                           :weight bold
                           :height 1.0))))

  :general

  (:keymaps   '(global )
   "C-0"      'my-treemacs-quit
   "C-j"      'treemacs-select-window)

  (:keymaps   '(treemacs-mode-map evil-treemacs-state-map)
   "M-k"    'windmove-up
   "M-j"    'windmove-down
   "M-h"    'windmove-left
   "M-l"    'windmove-right
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

(use-package! ranger
  :demand t
  :init
  (setq ranger-deer-show-details nil)
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
   "x"          'dired-do-flagged-delete
   "d"          'dired-flag-file-deletion
   "<c-return>" 'dired-do-find-marked-files)
  :config
  (defun my-ranger-olivetti ()
    (interactive)
    (setq-local olivetti-body-width '65)
    (olivetti-mode +1))

  (defun my-ranger-go (path)
    "Go subroutine"
    (interactive
     (list
      (read-char-choice
       "
    d: doom   n : downloads  s : scripts   D: dotfiles
    e: emacs  o : org        f: config     i: eclipse
    h: home   p: python      c: documents  q: quit
  > "
       '(?a ?d ?D ?e ?E ?h ?i ?n ?o ?p ?s ?f ?c ?m ?q))))
    (message nil)
    (let* ((c (char-to-string path))
           (new-path
            (cl-case (intern c)
              ('D "~/dotfiles")
              ('e "~/.emacs.d")
              ('E "~/.backup/.emacs.back/vanilla/2020_26_05/init.el")
              ('i "~/org/Creative/eclipse/pt")
              ('d "~/.doom.d")
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

(use-package! super-save
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
     projectile-next-project-buffer
     projectile-previous-project-buffer
     eyebrowse-close-window-config
     eyebrowse-create-window-config
     eyebrowse-prev-window-config))

  :config

  (defun super-save-command ()
    "Save the current buffer if needed."
    (when (and buffer-file-name
               (buffer-modified-p (current-buffer))
               (file-writable-p buffer-file-name)
               (if (file-remote-p buffer-file-name) super-save-remote-files t)
               (super-save-include-p buffer-file-name))
      (let ((inhibit-message t))
        (save-buffer))))

  (super-save-mode t))

(use-package! projectile
  :custom
  (projectile-track-known-projects-automatically nil))

(use-package! windmove
  :custom
  (windmove-wrap-around t))

(use-package! unkillable-scratch
  :after-call after-find-file
  :custom
  (unkillable-scratch-behavior 'bury)
  (unkillable-buffers '("^\\*scratch\\*$" ;; "^agenda.org$"
                        "*Messages*"))
  :config
  (unkillable-scratch))

(use-package! git-auto-commit-mode
  :custom
  (gac-debounce-interval (* 30 60))
  :config

  (defun gac-commit (buffer)
    "Commit the current buffer's file to git."
    (let ((inhibit-message t))
      (let* ((buffer-file (buffer-file-name buffer))
             (filename (convert-standard-filename
                        (file-name-nondirectory buffer-file)))
             (commit-msg (gac--commit-msg buffer-file))
             (default-directory (file-name-directory buffer-file)))
        (shell-command
         (concat "git add " gac-add-additional-flag " " (shell-quote-argument filename)
                 gac-shell-and
                 "git commit -m " (shell-quote-argument commit-msg)))))))

(use-package! avoid
  :after-call after-find-file
  :config
  (mouse-avoidance-mode 'banish))

(use-package! recentf
  :custom
  (recentf-auto-cleanup 'mode)
  (recentf-max-saved-items 20)
  :config
  (add-to-list 'recentf-exclude "/\\.emacs\\.d/.local/straight/"))

(use-package! midnight
  :after-call after-find-file
  :custom
  (midnight-period (* 1 60 60))
  (clean-buffer-list-delay-general 1)
  (clean-buffer-list-delay-special 1800)
  (clean-buffer-list-kill-regexps '("\\`\\*Man " "^#.*#$" "^\\*.*\\*"))
  :config
  (midnight-mode +1))

(use-package! files
  :init
  (add-hook 'after-save-hook (lambda () (executable-make-buffer-file-executable-if-script-p))))

(after! undo-fu-session
  (add-to-list 'undo-fu-session-incompatible-major-modes #'python-mode)
  (add-to-list 'undo-fu-session-incompatible-major-modes #'org-brain-visualize-mode))

(after! (:or markdown-mode text-mode prog-mode)
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

  (defun my-clean-all-empty-lines ()
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
            (while (re-search-forward "\n\n+" nil "move")
              (replace-match "\n"))))))))
