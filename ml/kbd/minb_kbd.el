(map! :map (minibuffer-local-map
            minibuffer-local-ns-map
            minibuffer-local-completion-map
            minibuffer-local-must-match-map
            minibuffer-local-isearch-map
            read-expression-map
            evil-ex-completion-map
            evil-ex-search-keymap)
      "C-y" 'kill-ring-save
      :nig "<insert>" 'yank
      :nig "C-k"      'kill-line
      :nig "C-d"      'delete-char
      :nig "C-h"      'delete-backward-char
      :nig "C-w"      'backward-kill-word)
