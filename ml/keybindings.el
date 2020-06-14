;;; ~/.doom.d/keybindings.el -*- lexical-binding: t; -*-

(define-key key-translation-map (kbd "<help>") (kbd "<insert>"))
;; (define-key key-translation-map (kbd "<f12>") (kbd "SPC"))

;; GLOBALS
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
      "M-]"   'evil-window-prev
      "M-["   'evil-window-next
      "M-k"   'windmove-up
      "M-j"   'windmove-down
      "M-h"   'windmove-left
      "M-l"   'windmove-right
      "C-'"   'org-cycle-agenda-files
      "C-c r" 'my-show-org-roam-commands
      "C-l"   'recenter-top-bottom
      "C-c o" 'my-org-force-open-other-window
      "C-h e" 'describe-package
      "C-c t" 'git-timemachine
      "C-c i" 'emacs-init-time)

;; INSERT STATE ;;
(map! :i "C-h" 'evil-delete-backward-char-and-join
      :i "C-k" 'kill-line
      :i "C-p" 'previous-line
      :i "C-n" 'next-line
      :i "M-d" 'kill-word
      :i "C-d" 'delete-char
      :i "M-e" 'yas-expand
      :i "C-ç f" 'org-roam-find-file
      :i "C-ç j" 'org-roam-jump-to-index
      :i "C-ç b" 'org-roam-switch-to-buffer
      :i "C-ç g" 'org-roam-graph
      :i "C-ç i" 'org-roam-insert
      :i "C-ç ç" 'org-roam
      :i "C-ç c" 'org-roam-db-build-cache
      :i "C-ç d" 'deft)

;; NORMAL STATE ;;
(map! :n "gr"  'my-evil-sel-to-end
      :n "go"  'cool-moves-open-line-below
      :n "gO"  'cool-moves-open-line-above
      :n "gsP" 'cool-moves-paragraph-backward
      :n "gsp" 'cool-moves-paragraph-forward
      :n "TAB" '+fold/toggle
      :n "zi"  '+fold/open-all
      :n "ge"  'evil-end-of-visual-line
      :n "Q"   'delete-frame
      :n "z="  'flyspell-correct-previous

      :n "H"   'projectile-previous-project-buffer
      :n "L"   'projectile-next-project-buffer

      :vn "çf" 'org-roam-find-file
      :vn "çl" 'org-roam-find-file
      :vn "çj" 'org-roam-jump-to-index
      :vn "çb" 'org-roam-switch-to-buffer
      :vn "çg" 'org-roam-graph
      :vn "çi" 'org-roam-insert
      :vn "çç" 'org-roam
      :vn "çc" 'org-roam-db-build-cache
      :vn "çd" 'deft
      :vn "çx" 'my-roam-indexes
      :vn "ço" 'my-roam-logic
      :vn "ça" 'my-roam-fallacies)

;; VISUAL AND MIXED STATES ;;
(map! :v "C-c a"  'align-regexp
      :nv "M-o"   'better-jumper-jump-backward
      :nv "M-i"   'better-jumper-jump-forward
      :nv "C-h M" 'my-show-major-mode
      :nv "." 'link-hint-open-link
      :nvg "C-S-j" 'cool-moves-line-forward
      :nvg "C-S-k" 'cool-moves-line-backward)

;; LOCAL KEYBINDINGS
(map! :map (wordnut-mode-map
            osx-dictionary-mode-map) ;; WORDNUT
      :nv "q" 'quit-window
      :n "<escape>" 'quit-window

      ;; DOOM DASHBORD ;;
      :map +doom-dashboard-mode-map
      :n "<escape>" 'quit-window
      :n "j"        'forward-button
      :n "k"        'backward-button
      :n "q"        'quit-window

      ;; SAVE BUFFER ;;
      :map (prog-mode-map text-mode-map conf-mode-map)
      :n "<escape>" 'my-quiet-save-buffer
      :map (lisp-interaction-mode-map)
      :n "<escape>" nil

      ;; ORG MODE ;;
      :map (org-mode-map evil-org-mode-map)
      :nvig "C-l"           'recenter-top-bottom
      :nvig "C-j"           'treemacs-select-window
      :nvig "C-c o"         'my-org-force-open-other-window
      :nvig "s-w"           'org-edit-special
      :i "C-h" 'evil-delete-backward-char-and-join
      :i "C-k" 'kill-line
      :i "C-p" 'previous-line
      :i "C-n" 'next-line
      :i "M-d" 'kill-word
      :i "C-d" 'delete-char
      :i "M-e" 'yas-expand
      :nvg "C-S-j" 'cool-moves-line-forward
      :nvg "C-S-k" 'cool-moves-line-backward
      :nvig "<C-tab>" 'org-shifttab
      :nvig "<S-tab>" 'org-next-link
      :n "zi"         '+fold/open-all
      :n "gr"         'my-evil-sel-to-end
      :nv "<insert>"  'org-insert-link

      :map org-src-mode-map
      "s-w" 'my-eval-buffer-and-leave-org-source

      :map org-roam-backlinks-mode-map
      :n "<M-return>" 'my-org-roam-open-link
      :n "q" 'quit-window
      :n "<escape>" 'quit-window
      :n "m" '+org/dwim-at-point

      ;; EVIL GOD STATE ;;
      :map global-map
      :v ","          'evil-exit-visual-state
      :n ","          'evil-execute-in-god-state
      :map god-local-mode-map
      :nig "<escape>" 'evil-god-state-bail
      :nig ","        'evil-god-state-bail

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
      :nvig "C-w"      'backward-kill-word)

;; LEADER KEY
(map! :leader "sw"  'wordnut-lookup-current-word
      :leader "sW"  'wordnut-search
      :leader "te"  'hl-sentence-mode
      :leader "th"  'hl-line-mode
      :leader "l"   'link-hint-open-link
      :leader "br"  '+popup/raise
      :leader "mgx" 'org-capture-goto-last-stored
      :leader "z"   'org-capture
      :leader "ww"  'doom/window-maximize-vertically
      :leader "k"   'kill-current-buffer
      :leader "x"   'eyebrowse-close-window-config
      :leader "r"   'deer
      :leader "0"   'delete-window
      :leader "pG"  'projectile-configure-project
      :leader "nn"  'recursive-narrow-or-widen-dwim
      :leader "nw"  'my-widen-to-center
      :leader "to"  'olivetti-mode
      :leader "cw"  'count-words

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
      :leader "tv"    'visible-mode
      :leader "tS"    'my-sort-lines-by-length
      :leader "g SPC" 'my-magit-stage-modified-and-commit
      :leader "meb"   'my-eval-buffer
      :leader "ba"    'my-goto-markdown

      :map (org-mode-map evil-org-mode-map)
      :leader "mwi"    'org-web-tools-insert-link-for-url
      :leader "mwe"    'org-web-tools-archive-view
      :leader "mwv"    'org-web-tools-archive-attach
      :leader "mwr"    'org-web-tools-read-url-as-org
      :leader "mwc"    'org-web-tools-convert-links-to-page-entries)
