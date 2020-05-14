(setq! load-prefer-newer t
       eldoc-idle-delay 1
       personal-keybindings nil
       auto-save-no-message t
       auto-revert-verbose nil
       use-package-always-defer t
       ns-option-modifier 'meta
       ns-right-option-modifier 'meta
       initial-major-mode 'scratch-mode
       doom-scratch-initial-major-mode 'scratch-mode)

(setq excluded-modes "Buffer-menu-mode\\| Info-mode\\|Man-mode\\| calc-mode\\|calendar-mode\\| compilation-mode\\|completion-list-mode\\| dired-mode\\|fundamental-mode\\| gnus-mode\\|help-mode\\| helpful-mode\\|ibuffer-mode\\| lisp-interaction-mode\\|magit-auto-revert-mode\\| magit-blame-mode\\|magit-blame-read-only-mode\\| magit-blob-mode\\|magit-cherry-mode\\| magit-diff-mode\\|magit-diff-mode\\| magit-file-mode\\|magit-log-mode\\| magit-log-select-mode\\|magit-merge-preview-mode\\| magit-mode\\|magit-process-mode\\| magit-reflog-mode\\|magit-refs-mode\\| magit-repolist-mode\\|magit-revision-mode\\| magit-stash-mode\\|magit-stashes-mode\\| magit-status-mode\\|magit-submodule-list-mode\\| magit-wip-after-apply-mode\\|magit-wip-after-save-local-mode\\| magit-wip-after-save-mode\\|magit-wip-before-change-mode\\| magit-wip-initial-backup-mode\\|magit-wip-mode\\| minibuffer-inactive-mode\\|occur-mode\\| org-agenda-mode\\|org-src-mode\\| ranger-mode\\|special-mode\\| special-mode\\|term-mode\\| treemacs-mode\\|messages-buffer-mode")

(map! "M-s"   'my-last-buffer
      "M-RET" 'my-indent-buffer
      "M-9"   'delete-other-windows
      "M-0"   'quit-window
      "M-/"   'hippie-expand
      "C-c R" 'doom/restart
      "C-c e" 'eval-buffer
      "C-c r" 'my-recompile-doom
      :v "C-c a" 'align-regexp
      :nvi "M-." nil)

(map! :map help-mode-map
      :n "<escape>"'quit-window)

(map! :map (text-mode-map)
      :n "<escape>" 'my-quiet-save-buffer)

(map! :leader
      "r" 'deer
      "z" 'hydra-window/body
      "a" 'counsel-M-x
      "q" 'my-kill-this-buffer
      "hh" 'hydra-help/body
      "0"'delete-window)

(defun my-quiet-save-buffer ()
  (interactive)
  (let ((inhibit-message t))
    (evil-ex-nohighlight)
    (save-buffer)))

(defun my-kill-this-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(defun my-indent-buffer ()
  (interactive)
  (let ((inhibit-message t))
    (evil-indent
     (point-min)
     (point-max))))

(defun my-last-buffer ()
  (interactive)
  (switch-to-buffer nil))

(defun my-recompile-doom ()
  (interactive)
  (let ((current-prefix-arg 4))
    (byte-force-recompile "~/.doom.d/my-lisp/")))

(define-derived-mode scratch-mode
  lisp-interaction-mode "scratch")

(defun my-cp-filename-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename))
    (message filename)))


(map! :map scratch-mode-map
      :n "<escape>"'evil-ex-nohighlight)
