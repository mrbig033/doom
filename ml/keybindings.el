;;; ~/.doom.d/keybindings.el -*- lexical-binding: t; -*-

(define-key key-translation-map (kbd "<help>") (kbd "<insert>"))
;; (define-key key-translation-map (kbd "<f12>") (kbd "SPC"))


(map! "M--"   'winner-undo
      "M-="   'winner-redo
      "M-/"   'hippie-expand
      "C-;"   'helpful-at-point
      "M-RET" 'my-indent-buffer
      "C-9"   'evilnc-comment-or-uncomment-lines
      "M-9"   'delete-other-windows
      "M-0"   'quit-window
      "M-n"   'evil-forward-paragraph
      "M-p"   'evil-backward-paragraph
      "M-k"   'windmove-up
      "M-j"   'windmove-down
      "M-h"   'windmove-left
      "M-l"   'windmove-right
      "C-'"   'org-cycle-agenda-files
      "C-h e" 'describe-package
      "C-S-j" 'cool-moves-line-forward
      "C-S-k" 'cool-moves-line-backward
      "C-c t" 'git-timemachine
      "C-c i" 'emacs-init-time

      ;; INSERT STATE ;;
      :i "C-h" 'evil-delete-backward-char-and-join
      :i "C-k" 'kill-line
      :i "C-p" 'previous-line
      :i "C-n" 'next-line
      :i "M-d" 'kill-word
      :i "C-d" 'delete-char
      :i "M-e" 'yas-expand

      ;; NORMAL STATE ;;
      :n "go"  'cool-moves-open-line-below
      :n "gO"  'cool-moves-open-line-above
      :n "gsP" 'cool-moves-paragraph-backward
      :n "gsp" 'cool-moves-paragraph-forward
      :n "TAB" '+fold/toggle
      :n "zi"  '+fold/open-all
      :n "ge"  'evil-end-of-visual-line
      :n "Q"   'delete-frame

      ;; VISUAL ;;
      :v "C-c a"  'align-regexp

      ;; NORMAL AND VISUAL ;;
      :nv "M-o"   'better-jumper-jump-backward
      :nv "M-i"   'better-jumper-jump-forward
      :nv "C-h M" 'my-show-major-mode

      ;; DOOM DASHBORD ;;
      :map +doom-dashboard-mode-map
      :n "<escape>" 'quit-window
      :n "j"        'forward-button
      :n "k"        'backward-button
      :n "q"        'quit-window

      ;; ORG MODE ;;
      :map (global-map org-mode-map evil-org-mode-map)
      "s-w"          'org-edit-special
      "C-l"          'recenter-top-bottom
      "C-c o"        'my-org-force-open-other-window
      :n "zi"        '+fold/open-all
      :n "gr"        'my-evil-sel-to-end
      :nv "<insert>" 'org-insert-link
      :map org-src-mode-map
      "s-w" 'my-eval-buffer-and-leave-org-source

      ;; EVIL GOD STATE ;;
      :map global-map
      :v ","          'evil-exit-visual-state
      :n ","          'evil-execute-in-god-state
      :map god-local-mode-map
      :nig "<escape>" 'evil-god-state-bail
      :nig ","        'evil-god-state-bail

      ;; SAVE BUFFER ;;
      :map (prog-mode-map text-mode-map conf-mode-map)
      :n "<escape>" 'my-quiet-save-buffer
      :map (lisp-interaction-mode-map)
      :n "<escape>" nil

      :map (minibuffer-local-map
            minibuffer-local-ns-map
            minibuffer-local-completion-map
            minibuffer-local-must-match-map
            minibuffer-local-isearch-map
            read-expression-map
            evil-ex-completion-map
            evil-ex-search-keymap)

      :nvig "<insert>" 'yank
      :nvig "C-k"      'kill-line
      :nvig "C-d"      'delete-char
      :nvig "C-h"      'delete-backward-char
      :nvig "C-w"      'backward-kill-word


      ;; LEADER KEY ;;

      ;; OTHER LEADER KEYS ;;
      :leader "r" 'deer
      :leader "0" 'delete-window
      :leader "pG" 'projectile-configure-project
      :leader "nn" 'recursive-narrow-or-widen-dwim
      :leader "nw" 'my-widen-to-center
      :leader "to" 'olivetti-mode

      ;; COPY DIRECTORY PATH ;;
      :leader "fY" (lambda () (interactive)
                     (message
                      (kill-new (abbreviate-file-name default-directory))))

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
      :leader "wk"    '+evil-window-split-a
      :leader "wh"    '+evil-window-vsplit-a
      :leader "td"    'my-dup-line
      :leader "T"     'my-reopen-killed-file
      :leader "tc"    'xah-clean-empty-lines
      :leader "ti"    'my-dup-par
      :leader "tS"    'my-sort-lines-by-length
      :leader "g SPC" 'my-magit-stage-modified-and-commit
      :leader "meb"   'my-eval-buffer
      :leader "ba"    'my-goto-markdown)
;; :leader "fo"    '+doom-dashboard/open
