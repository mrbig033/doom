(define-key key-translation-map (kbd "<help>") (kbd "<insert>"))
(define-key key-translation-map (kbd "<f12>") (kbd "C-c"))

(general-define-key
 :states '(normal visual insert)
 :keymaps  '(global text-mode-map evil-treemacs-state-map treemacs-mode-map evil-org-mode-map prog-mode-map)
 "M-h"      'windmove-left
 "M-l"      'windmove-right
 "M-k"      'windmove-up
 "M-j"      'windmove-down)

(map! "M-s"      'my-last-buffer
      "M-RET"    'my-indent-buffer
      "M-9"      'delete-other-windows
      "M-0"      'quit-window
      "M-/"      'hippie-expand
      "C-c R"    'doom/restart
      "C-c e"    'eval-buffer
      "C-9"      'evilnc-comment-or-uncomment-lines
      "C-c g"    'dumb-jump-go
      "M-t"      'pop-tag-mark
      "C-c t"    'my-reload-file
      "C-S-j"    'cool-moves-line-forward
      "C-S-k"    'cool-moves-line-backward
      :n "gsP"   'cool-moves-paragraph-backward
      :n "gsp"   'cool-moves-paragraph-forward
      :nv "Q"    'delete-frame
      :nv "\\"    'toggle-truncate-lines
      :v "C-c a" 'align-regexp
      :nvi "M-." nil
      :map scratch-mode-map
      :n "<escape>"'evil-ex-nohighlight
      :map help-mode-map
      :n "<escape>"'quit-window
      :map text-mode-map
      :n "<escape>" 'my-quiet-save-buffer
      :map snippet-mode-map
      :n "<escape>" 'ignore
      :leader "pR" 'projectile-replace
      :leader "T" 'my-reopen-killed-file
      :leader "k" '+popup/close-all
      :leader "ft" 'my-tangle-init
      :leader "fk" 'my-search-packages
      :leader "tc" 'xah-clean-empty-lines
      :leader "ti" 'my-dup-inner-paragraph
      :leader "d" 'my-dup-line
      :leader "bM" 'bookmark-delete
      :leader "fY" 'my-yank-dir
      :leader "bi" 'my-insert-dir
      :leader "," 'olivetti-mode
      :leader "r" 'deer
      :leader "z" 'hydra-window/body
      :leader "a" 'counsel-M-x
      :leader "q" 'my-kill-this-buffer
      :leader "hh" 'hydra-help/body
      :leader "0"'delete-window)

(setq +word-wrap-visual-modes nil)
(add-hook 'emacs-lisp-mode-hook 'evil-smartparens-mode)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(remove-hook 'quickrun-after-run-hook '+eval-quickrun-scroll-to-bof-h)
(add-hook 'quickrun--mode-hook 'hl-line-mode)

(setq my-load! "~/.doom.d/my-lisp/load!"
      excluded-modes "Buffer-menu-mode\\| Info-mode\\|Man-mode\\| calc-mode\\|calendar-mode\\| compilation-mode\\|completion-list-mode\\| dired-mode\\|fundamental-mode\\| gnus-mode\\|help-mode\\| helpful-mode\\|ibuffer-mode\\| lisp-interaction-mode\\|magit-auto-revert-mode\\| magit-blame-mode\\|magit-blame-read-only-mode\\| magit-blob-mode\\|magit-cherry-mode\\| magit-diff-mode\\|magit-diff-mode\\| magit-file-mode\\|magit-log-mode\\| magit-log-select-mode\\|magit-merge-preview-mode\\| magit-mode\\|magit-process-mode\\| magit-reflog-mode\\|magit-refs-mode\\| magit-repolist-mode\\|magit-revision-mode\\| magit-stash-mode\\|magit-stashes-mode\\| magit-status-mode\\|magit-submodule-list-mode\\| magit-wip-after-apply-mode\\|magit-wip-after-save-local-mode\\| magit-wip-after-save-mode\\|magit-wip-before-change-mode\\| magit-wip-initial-backup-mode\\|magit-wip-mode\\| minibuffer-inactive-mode\\|occur-mode\\| org-agenda-mode\\|org-src-mode\\| ranger-mode\\|special-mode\\| special-mode\\|term-mode\\| treemacs-mode\\|messages-buffer-mode")

(setq doom-font (font-spec :family "monospace" :size 20)
      doom-variable-pitch-font (font-spec :family "monospace") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "monospace" :size 20)
      doom-big-font (font-spec :family "monospace" :size 20))


(setq! load-prefer-newer t
       eldoc-idle-delay 1
       confirm-kill-emacs nil
       personal-keybindings nil
       dumb-jump-aggressive t
       auto-save-no-message t
       auto-revert-verbose nil
       custom-safe-themes t
       yas-indent-line 'fixed
       use-package-always-defer t
       ns-option-modifier 'meta
       warning-minimum-level :error
       ns-right-option-modifier 'meta
       initial-major-mode 'scratch-mode
       kill-whole-line t
       doom-scratch-initial-major-mode 'scratch-mode)

(setq-default menu-bar-mode nil)
(menu-bar-mode nil)


(global-subword-mode +1)


(add-hook 'after-init-hook 'toggle-frame-maximized)

(defun my-quiet-save-buffer ()
  (interactive)
  (let ((inhibit-message t))
    (evil-ex-nohighlight)
    (save-buffer)))

(defun my-save-some-buffers ()
  (interactive)
  (let ((current-prefix-arg 4))
    (call-interactively 'save-some-buffers)))

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

(defun my-kill-visual-line-and-insert ()
  (interactive)
  (kill-visual-line)
  (evil-insert-state))

(defun my-recenter-window ()
  (interactive)
  (recenter-top-bottom
   `(4)))


;; https://stackoverflow.com/a/998472
(defun my-dup-line (arg)
  (interactive "*p")
  (my-evil-set-mark-A)
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
  (my-evil-goto-mark-A)
  (evil-next-line 1))

(defun my-yank-dir ()
  "Yank curent dir name"
  (interactive)
  (message (kill-new (abbreviate-file-name default-directory))))

(defun my-insert-dir ()
  "Insert current dir name"
  (interactive)
  (setq dir (kill-new (abbreviate-file-name default-directory)))
  (insert dir))

(defun my-search-packages ()
  (interactive)
  (progn
    (find-file "~/.doom.d/my-lisp/my-packages.org")
    (swiper "(use-package ")))

(defun my-par-backward-to-indentation ()
  (interactive)
  (backward-paragraph)
  (backward-to-indentation))

(defun my-par-forward-to-indentation ()
  (interactive)
  (forward-paragraph)
  (forward-to-indentation))

(defun my-bash-shebang ()
  (interactive)
  (erase-buffer)
  (insert "#!/usr/bin/env bash\n\n")
  (sh-mode)
  (sh-set-shell "bash")
  (xah-clean-empty-lines)
  (forward-to-indentation)
  (evil-insert-state))

(defun my-tangle-init ()
  (interactive)
  (my-save-some-buffers)
  (start-process-shell-command "tangle init" nil "~/scripts/emacs_scripts/nt-init")
  (message " init tangled"))

(fset 'my-dup-inner-paragraph
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item '("vipy'>gop" 0 "%d") arg)))

;;;; REOPEN KILLED FILED ;;;;

(defvar killed-file-list nil
  "List of recently killed files.")

(defun add-file-to-killed-file-list ()
  "If buffer is associated with a file name, add that file to the
`killed-file-list' when killing the buffer."
  (when buffer-file-name
    (push buffer-file-name killed-file-list)))

(add-hook 'kill-buffer-hook #'add-file-to-killed-file-list)

(defun my-reopen-killed-file ()
  "Reopen the most recently killed file, if one exists."
  (interactive)
  (when killed-file-list
    (find-file (pop killed-file-list))))

(defun my-reload-file ()
  "Reopen the most recently killed file, if one exists."
  (interactive)
  (my-kill-this-buffer)
  (when killed-file-list
    (find-file (pop killed-file-list))))
