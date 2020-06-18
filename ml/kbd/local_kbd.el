;; LOCAL KEYBINDINGS
(map! (:map pabbrev-mode-map
       :i "C-l" 'pabbrev-expand-maybe)

      (:map helpful-mode-map
       :nvig "C-r" 'helpful-update)

      (:map (minibuffer-local-map
             minibuffer-local-ns-map
             minibuffer-local-completion-map
             minibuffer-local-must-match-map
             minibuffer-local-isearch-map
             read-expression-map
             evil-ex-completion-map
             evil-ex-search-keymap)

       "C-y" 'kill-ring-save
       :nvig "<insert>" 'yank
       :nvig "C-k"      'kill-line
       :nvig "C-d"      'delete-char
       :nvig "C-h"      'delete-backward-char
       :nvig "C-w"      'backward-kill-word))

(map! :map (org-mode-map evil-org-mode-map)
      :n "gr"       'my-evil-sel-to-end)
