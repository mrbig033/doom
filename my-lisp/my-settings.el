(define-key key-translation-map (kbd "<help>") (kbd "<insert>"))
(define-key key-translation-map (kbd "<f12>") (kbd "C-c"))

(map! :map evil-multiedit-state-map
      "n" 'evil-multiedit-match-symbol-and-next
      "N"   'evil-multiedit-match-symbol-and-prev
      "m" 'evil-multiedit-match-symbol-and-next
      "M"   'evil-multiedit-match-symbol-and-prev)

(general-define-key
 :states  '(global normal visual insert)
 :keymaps 'override
 "M-," 'nswbuff-switch-to-previous-buffer
 "M-." 'nswbuff-switch-to-next-buffer
 "C-j"    'treemacs-select-window
 "M-h"    'windmove-left
 "M-l"    'windmove-right
 "M-k"    'windmove-up
 "M-j"    'windmove-down)

(map! :map (org-mode-map evil-org-mode-map global)
      :n "zi"       '+fold/open-all
      :nv "gr"      'my-evil-sel-to-end
      "C-l" 'recenter-top-bottom
      "s-S" 'org-edit-special)

(map! :map (global evil-org-mode-map treemacs-mode-map text-mode-map prog-mode-map)
      "M-h"      'windmove-left
      "M-l"      'windmove-right
      "M-k"      'windmove-up
      "M-j"      'windmove-down
      "C-x M" 'evil-multiedit-match-symbol-and-prev
      "C-x m" 'evil-multiedit-match-symbol-and-next
      "C-j" 'treemacs-visit-node-in-most-recently-used-window
      "<C-return>" 'my-treemacs-visit-node-and-hide
      "<escape>" 'treemacs-quit)

(map! "M-s"      'my-last-buffer
      "s-t"      '+default/new-buffer
      "s-w"      'quit-window
      "M-RET"    'my-indent-buffer
      "M-9"      'delete-other-windows
      "M-0"      'quit-window
      "M-/"      'hippie-expand
      "C-c w"    'my-window-to-register-one
      "C-c W"    'my-jump-to-register-one
      "C-c r"    'jump-to-register
      "C-c C-x r" 'doom/restart
      "C-c e"    'eval-buffer
      "C-9"      'evilnc-comment-or-uncomment-lines
      "C-c g"    'dumb-jump-go
      "M-t"      'pop-tag-mark
      "C-c R"    'redraw-display
      "C-c i"    'git-timemachine
      "C-c p"    'my-goto-python-scratch
      "C-c t"    'my-reload-file
      "C-S-j"    'cool-moves-line-forward
      "C-S-k"    'cool-moves-line-backward
      :nv "tp"   'move-file-to-trash
      :n "gsP"   'cool-moves-paragraph-backward
      :n "gsp"   'cool-moves-paragraph-forward
      :n "zi"       '+fold/open-all
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
      :leader "gs" 'magit-stage-modified
      :leader "g SPC" 'my-magit-stage-modified-and-commit
      :leader "gp" 'magit-push
      :leader "gd" 'magit-dispatch
      :leader "gcd" 'magit-commit
      :leader "oo" 'hydra-org-mode/body
      :leader "oO" '+macos/reveal-in-finder
      :leader "oO" '+macos/reveal-in-finder
      :leader "pR" 'projectile-replace
      :leader "bu" 'unkillable-scratch
      :leader "T" 'my-reopen-killed-file
      :leader "k" '+popup/close-all
      :leader "ft" 'my-tangle-init
      :leader "fs" 'my-search-settings
      :leader "fk" 'my-search-packages
      :leader "td" 'my-comm-dup-line
      :leader "tc" 'xah-clean-empty-lines
      :leader "ti" 'my-dup-inner-paragraph
      :leader "d" 'my-dup-line
      :leader "bM" 'bookmark-delete
      :leader "fY" 'my-yank-dir
      :leader "bI" 'my-insert-dir
      :leader "bi" 'ibuffer
      :leader "," 'olivetti-mode
      :leader "r" 'deer
      :leader "z" 'hydra-window/body
      :leader "a" 'counsel-M-x
      :leader "q" 'my-kill-this-buffer
      :leader "hh" 'hydra-help/body
      :leader "0"'delete-window)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(remove-hook 'quickrun-after-run-hook '+eval-quickrun-scroll-to-bof-h)
(add-hook 'quickrun--mode-hook 'hl-line-mode)
(advice-add 'dumb-jump-go :after #'my-recenter-window)

(after! dumb-jump
  (setq! dumb-jump-aggressive t))

(after! projectile
  (setq! projectile-track-known-projects-automatically nil))

(mouse-avoidance-mode 'banish)
(setq! frame-title-format " %n")

(setq my-load! "~/.doom.d/my-lisp/load!")

(setq doom-font (font-spec :family "monospace" :size 20)
      doom-variable-pitch-font (font-spec :family "monospace") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "monospace" :size 20)
      doom-big-font (font-spec :family "monospace" :size 20))

(global-eldoc-mode -1)

(setq!  eldoc-idle-delay 10
        confirm-kill-emacs nil
        trash-directory "~/.Trash"
        undo-fu-session-compression nil
        undo-fu-session-linear nil
        undo-fu-session-file-limit nil
        personal-keybindings nil
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

(defun my-magit-stage-modified-and-commit ()
  (interactive)
  (progn
    (let ((current-prefix-arg '(4))) (magit-stage-modified))
    (magit-commit-create)))

(defun my-delete-file-and-buffer ()
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "deleted file %s" filename)
          (kill-buffer))))))

(defun my-goto-python-scratch ()
  (interactive)
  (find-file "~/.doom.d/temp/sct.py"))

(defun my-quiet-save-buffer ()
  (interactive)
  (let ((inhibit-message t))
    (evil-ex-nohighlight)
    (save-buffer)))

(defun my-save-some-buffers ()
  (interactive)
  (save-some-buffers t 0))

;; (defun my-save-some-buffers ()
;;   (interactive)
;;   (let ((current-prefix-arg 4))
;;     (call-interactively 'save-some-buffers)))

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

(defun my-kill-all-buffers-except-treemacs ()
  "kill all buffers."
  (interactive)
  (progn
    (my-save-all)
    (mapc 'kill-buffer (delq (treemacs-get-local-buffer) (buffer-list)))
    (message " all killed expect treemacs")))
(current-buffer)

(general-unbind
  :keymaps 'scratch-mode-map
  :with 'quit-window
  [remap my-kill-this-buffer])

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

(defun my-window-to-register-one ()
  (interactive)
  (window-configuration-to-register 49 nil))

(defun my-jump-to-register-one ()
  (interactive)
  (jump-to-register 49 nil))

(defun my-show-buffer-name ()
  (interactive)
  (message (buffer-name)))

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

;; https://stackoverflow.com/a/998472
(defun my-comm-dup-line (arg)
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
  (save-excursion
    (comment-line 1))
  (backward-char 3)
  (forward-line 1))

(defun my-yank-dir ()
  "Yank curent dir name"
  (interactive)
  (message (kill-new (abbreviate-file-name default-directory))))

(defun my-insert-dir ()
  "Insert current dir name"
  (interactive)
  (setq dir (kill-new (abbreviate-file-name default-directory)))
  (insert dir))

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
