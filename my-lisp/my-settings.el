(map! :map scratch-mode-map
      :n "<escape>"'evil-ex-nohighlight)

(map! :leader "tc" 'xah-clean-empty-lines
      :leader "d" 'my-dup-line)

(map! :map help-mode-map
      :n "<escape>"'quit-window)

(map! "M-s"   'my-last-buffer
      "M-RET" 'my-indent-buffer
      "M-9"   'delete-other-windows
      "M-0"   'quit-window
      "M-/"   'hippie-expand
      "C-c R" 'doom/restart
      "C-c e" 'eval-buffer
      "C-c r" 'my-recompile-doom
      "C-S-j" 'cool-moves-line-forward
      "C-S-k" 'cool-moves-line-backward
      :n "gsP" 'cool-moves-paragraph-backward
      :n "gsp" 'cool-moves-paragraph-forward
      :v "C-c a" 'align-regexp
      :nvi "M-." nil)

(map! :map (text-mode-map)
      :n "<escape>" 'my-quiet-save-buffer)

(map! :leader
      "r" 'deer
      "z" 'hydra-window/body
      "a" 'counsel-M-x
      "q" 'my-kill-this-buffer
      "hh" 'hydra-help/body
      "0"'delete-window)

(setq my-load! "~/emacs/.doom.d/my-lisp/load!")

(setq! load-prefer-newer t
       eldoc-idle-delay 1
       personal-keybindings nil
       auto-save-no-message t
       auto-revert-verbose nil
       use-package-always-defer t
       ns-option-modifier 'meta
       warning-minimum-level :emergency
       ns-right-option-modifier 'meta
       initial-major-mode 'scratch-mode
       kill-whole-line t
       doom-scratch-initial-major-mode 'scratch-mode)

(setq excluded-modes "Buffer-menu-mode\\| Info-mode\\|Man-mode\\| calc-mode\\|calendar-mode\\| compilation-mode\\|completion-list-mode\\| dired-mode\\|fundamental-mode\\| gnus-mode\\|help-mode\\| helpful-mode\\|ibuffer-mode\\| lisp-interaction-mode\\|magit-auto-revert-mode\\| magit-blame-mode\\|magit-blame-read-only-mode\\| magit-blob-mode\\|magit-cherry-mode\\| magit-diff-mode\\|magit-diff-mode\\| magit-file-mode\\|magit-log-mode\\| magit-log-select-mode\\|magit-merge-preview-mode\\| magit-mode\\|magit-process-mode\\| magit-reflog-mode\\|magit-refs-mode\\| magit-repolist-mode\\|magit-revision-mode\\| magit-stash-mode\\|magit-stashes-mode\\| magit-status-mode\\|magit-submodule-list-mode\\| magit-wip-after-apply-mode\\|magit-wip-after-save-local-mode\\| magit-wip-after-save-mode\\|magit-wip-before-change-mode\\| magit-wip-initial-backup-mode\\|magit-wip-mode\\| minibuffer-inactive-mode\\|occur-mode\\| org-agenda-mode\\|org-src-mode\\| ranger-mode\\|special-mode\\| special-mode\\|term-mode\\| treemacs-mode\\|messages-buffer-mode")

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

(defun my-backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(define-derived-mode scratch-mode
  lisp-interaction-mode "scratch")

(defun my-show-major-mode ()
  (interactive)
  (helpful-variable 'major-mode))

;; https://stackoverflow.com/a/998472
(defun my-dup-line (arg)
  (interactive "*p")
  (setq buffer-undo-list (cons (point) buffer-undo-list))
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion
      (end-of-line)
      (setq eol (point))
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        (while (> count 0)
          (newline)
          (insert line)
          (setq count (1- count))))
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list))))
  (forward-line arg))

(fset 'duplicate-inner-paragraph
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item '("vipy'>gop" 0 "%d") arg)))
