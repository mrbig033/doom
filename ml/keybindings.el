;;; ~/.doom.d/keybindings.el -*- lexical-binding: t; -*-

(define-key key-translation-map (kbd "<help>") (kbd "<insert>"))
(define-key key-translation-map (kbd "<f12>") (kbd "C-c"))


(map! "M-s"         'evil-switch-to-windows-last-buffer ;; MISC KEYBINDINGS
      "M-/"         'hippie-expand
      "C-;"         'helpful-at-point
      "M-RET"       'my-indent-buffer
      "M-h"         'windmove-left
      "M-l"         'windmove-right
      "M-k"         'windmove-up
      "M-j"         'windmove-down
      "C-9"         'evilnc-comment-or-uncomment-lines
      "C-0"         'quit-window
      "C-j"         'treemacs-select-window
      "C-s"         'counsel-grep-or-swiper
      :n "TAB"      '+fold/toggle
      :n "zi"       '+fold/open-all
      :n "ge"       'evil-end-of-visual-line
      :n "gr"       'my-evil-sel-to-end
      :v "C-c a"    'align-regexp
      :nvig "M-,"    'nswbuff-switch-to-previous-buffer
      :nvig "M-."    'nswbuff-switch-to-next-buffer
      :map (prog-mode-map text-mode-map)
      :n "<escape>" 'my-quiet-save-buffer
      ;; AVY ;;
      :nv "g9" 'my-avy-goto-parens
      :nv "F"  'evil-avy-goto-char-2-above
      :nv "f"  'evil-avy-goto-char-2-below
      :nv ","  'evil-avy-goto-word-or-subword-1
      ;; TREEMACS ;;
      :map (treemacs-mode-map evil-treemacs-state-map)
      "tp"   'move-file-to-trash
      "zm"   'treemacs-collapse-all-projects
      ","    'link-hint-open-link
      "C-c pa"   'treemacs-add-project-to-workspace
      "C-c pa"   'treemacs-projectile
      "C-c pd"   'treemacs-remove-project-from-workspace
      "C-c D"    'treemacs-delete
      "C-p"      'treemacs-previous-project
      "C-n"      'treemacs-next-project
      "C-c t"    'my-show-treemacs-commands
      "çm"       'treemacs-create-dir
      "<insert>" 'treemacs-create-file
      "m"        'treemacs-visit-node-in-most-recently-used-window
      "C-j"      'my-treemacs-visit-node-and-hide
      "<escape>" 'treemacs-quit
      ;; RANGER ;;
      :map ranger-mode-map
      "çm"         'dired-create-directory
      "<insert>"   'dired-create-empty-file
      "i"          'my-ranger-go
      "M-9"        'delete-other-windows
      "tp"         'delete-file
      "<escape>"   'ranger-close
      "m"          'my-ranger-toggle-mark-and-advance
      "gg"         'ranger-goto-top
      "zp"         'ranger-preview-toggle
      "√ßcm"        'dired-create-directory
      "C-c l"      'counsel-find-file
      "d"          'dired-do-flagged-delete
      "x"          'diredp-delete-this-file
      "d"          'dired-flag-file-deletion
      "<c-return>" 'dired-do-find-marked-files
      :map (minibuffer-local-map
            minibuffer-local-ns-map
            minibuffer-local-completion-map
            minibuffer-local-must-match-map
            minibuffer-local-isearch-map
            read-expression-map
            ivy-minibuffer-map
            ivy-switch-buffer-map
            evil-ex-completion-map
            evil-ex-search-keymap)
      :nvig "<insert>" 'yank
      :nvig "C-k"      'kill-line
      :nvig "C-d"      'delete-char
      :nvig "C-h"      'delete-backward-char
      :nvig "C-w"      'backward-kill-word
      ;; LEADER KEY ;;
      :leader "r" 'deer
      :leader "0" 'delete-window
      :leader "fY" (lambda () (interactive) (message (kill-new (abbreviate-file-name default-directory))))
      :leader "fs" (lambda () (interactive) (counsel-ag nil "~/.doom.d/ml/"))
      :leader "su" (lambda () (interactive) (evil-ex "%s/"))
      :leader "tS" 'my-sort-lines-by-length
      :leader "wl" (lambda () (interactive) (+evil-window-vsplit-a) (other-window 1))
      :leader "wh" '+evil-window-vsplit-a
      :leader "wj" (lambda () (interactive) (+evil-window-split-a) (other-window 1))
      :leader "wk" '+evil-window-split-a)
