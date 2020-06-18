;; LOCAL KEYBINDINGS
(map! (:map pabbrev-mode-map
       :i "C-l" 'pabbrev-expand-maybe)

      (:map helpful-mode-map
       :nvig "C-r" 'helpful-update)

      (:map (evil-org-mode-map org-mode-map global-map)
       :nvig "M-k"   'windmove-up
       :nvig "M-j"   'windmove-down
       :nvig "M-h"   'windmove-left
       :nvig "M-l"   'windmove-right)

      (:map (minibuffer-local-map
             minibuffer-local-ns-map
             minibuffer-local-completion-map
             minibuffer-local-must-match-map
             minibuffer-local-isearch-map
             read-expression-map
             evil-ex-completion-map
             evil-ex-search-keymap)
       "C-y" 'kill-ring-save
       :nvig "<insert>" 'yank))
