;; LOCAL KEYBINDINGS
(map! (:map pabbrev-mode-map
       :i "C-l" 'pabbrev-expand-maybe)

      (:map helpful-mode-map
       :nvig "C-r" 'helpful-update
       :n "<escape>" 'quit-window)

      (:map (minibuffer-local-map
             minibuffer-local-ns-map
             minibuffer-local-completion-map
             minibuffer-local-must-match-map
             minibuffer-local-isearch-map
             read-expression-map
             evil-ex-completion-map
             evil-ex-search-keymap)

       "C-y" 'kill-ring-save
       :ig "<insert>" 'yank
       :ig "C-k"      'kill-line
       :ig "C-d"      'delete-char
       :ig "C-h"      'delete-backward-char
       :ig "C-w"      'backward-kill-word)

      (:map (pabbrev-mode-map)
       :i "C-l" 'pabbrev-expand-maybe)

      (:map (flyspell-mode-map)
       :n "-" 'endless/ispell-word-then-abbrev)

      (:map (custom-mode-map compilation-mode-map)
       :n "<escape>" 'quit-window))
