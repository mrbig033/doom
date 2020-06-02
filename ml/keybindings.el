;;; ~/.doom.d/keybindings.el -*- lexical-binding: t; -*-

(define-key key-translation-map (kbd "<help>") (kbd "<insert>"))
(define-key key-translation-map (kbd "<f12>") (kbd "C-c"))

(map! "M-s"         'evil-switch-to-windows-last-buffer
      "M-/"         'hippie-expand
      "C-;"         'helpful-at-point
      "M-RET"       'my-indent-buffer
      "M-h"         'windmove-left
      "M-l"         'windmove-right
      "M-k"         'windmove-up
      "M-j"         'windmove-down
      "C-9"         'evilnc-comment-or-uncomment-lines
      "M-9"         'delete-other-windows
      "M-0"         'quit-window
      "C-s"         'counsel-grep-or-swiper
      "M-y"         'counsel-yank-pop
      "M-n"         'evil-forward-paragraph
      "M-p"         'evil-backward-paragraph
      "C-S-j"       'cool-moves-line-forward
      "C-S-k"       'cool-moves-line-backward
      :n "gsP"      'cool-moves-paragraph-backward
      :n "gsp"      'cool-moves-paragraph-forward
      :n "TAB"      '+fold/toggle
      :n "zi"       '+fold/open-all
      :n "ge"       'evil-end-of-visual-line
      :n "gr"       'my-evil-sel-to-end
      :v "C-c a"    'align-regexp
      :nvig "M-,"   'nswbuff-switch-to-previous-buffer
      :nvig "M-."   'nswbuff-switch-to-next-buffer
      ;; SAVE BUFFER ;;
      :map (prog-mode-map text-mode-map conf-mode-map)
      :n "<escape>" 'my-quiet-save-buffer
      :map (lisp-interaction-mode-map)
      :n "<escape>" nil
      ;; AVY ;;
      :nv "g9"      'my-avy-goto-parens
      :nv "F"       'evil-avy-goto-char-2-above
      :nv "f"       'evil-avy-goto-char-2-below
      :nv ","       'evil-avy-goto-word-or-subword-1
      ;; TREEMACS ;;
      :map global
      "C-0"         'my-treemacs-quit
      "C-j"         'treemacs-select-window
      :map (treemacs-mode-map evil-treemacs-state-map)
      "tp"          'move-file-to-trash
      "zm"          'treemacs-collapse-all-projects
      ","           'link-hint-open-link
      "C-c pa"      'treemacs-add-project-to-workspace
      "C-c pa"      'treemacs-projectile
      "C-c pd"      'treemacs-remove-project-from-workspace
      "C-c D"       'treemacs-delete
      "C-p"         'treemacs-previous-project
      "C-n"         'treemacs-next-project
      "C-c t"       'my-show-treemacs-commands
      "çm"          'treemacs-create-dir
      "<insert>"    'treemacs-create-file
      "m"           'treemacs-visit-node-in-most-recently-used-window
      "C-j"         'my-treemacs-visit-node-and-hide
      "<escape>"    'treemacs-quit
      ;; RANGER ;;
      :map ranger-mode-map
      "çm"          'dired-create-directory
      "<insert>"    'dired-create-empty-file
      "i"           'my-ranger-go
      "M-9"         'delete-other-windows
      "tp"          'delete-file
      "<escape>"    'ranger-close
      "m"           'my-ranger-toggle-mark-and-advance
      "gg"          'ranger-goto-top
      "zp"          'ranger-preview-toggle
      "çcm"        'dired-create-directory
      "C-c l"       'counsel-find-file
      "d"           'dired-do-flagged-delete
      "x"           'diredp-delete-this-file
      "d"           'dired-flag-file-deletion
      "<c-return>"  'dired-do-find-marked-files
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
      ;; IVY KEYBINDINGS ;;
      :map ivy-minibuffer-map
      :g "M-y"      'ivy-next-line
      :g "M-r"      'ivy-next-line
      :g "C-,"      'ivy-next-line
      :g "C-."      'ivy-next-line
      :g "C-/"      'ivy-next-line
      :g "M-q"      'ivy-done
      :g "<insert>" 'yank
      ;; LEADER KEY ;;
      :map global-map
      "M-q"       'eyebrowse-prev-window-config
      "M-w"       'eyebrowse-next-window-config
      ;; WORKSPACES ;;
      ;; EYEBROWSE ;;
      :leader "1" 'eyebrowse-switch-to-window-config-1
      :leader "2" 'eyebrowse-switch-to-window-config-2
      :leader "3" 'eyebrowse-switch-to-window-config-3
      :leader "4" 'eyebrowse-switch-to-window-config-4
      :leader "v" 'eyebrowse-create-window-config
      :leader "x" 'eyebrowse-close-window-config
      :map global-map
      :leader "r" 'deer
      :leader "0" 'delete-window
      :leader "pg" 'counsel-projectile-ag
      :leader "pG" 'projectile-configure-project
      ;; COPY DIRECTORY PATH ;;
      :leader "fY" (lambda () (interactive)
                     (message (kill-new (abbreviate-file-name default-directory))))
      ;; SEARCH SETTINGS ;;
      :leader "fs" 'my-search-settings
      :leader "fk" 'my-search-packages
      ;; EVIL SUBSTITUTE ;;
      :leader "su" (lambda () (interactive)
                     (evil-ex "%s/"))
      ;; WINDOWS ;;
      :leader "wl" (lambda () (interactive)
                     (+evil-window-vsplit-a) (other-window 1))
      :leader "wj" (lambda () (interactive)
                     (+evil-window-split-a) (other-window 1))
      :leader "wk" '+evil-window-split-a
      :leader "wh" '+evil-window-vsplit-a
      :leader "td" 'my-dup-line
      :leader "T" 'my-reopen-killed-file
      :leader "tc" 'xah-clean-empty-lines
      :leader "ti" 'my-dup-par
      :leader "tS" 'my-sort-lines-by-length
      :leader "g SPC" 'my-magit-stage-modified-and-commit
      :leader "meb" 'my-eval-buffer)
