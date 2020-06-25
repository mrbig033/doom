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
       :nig "<insert>" 'yank
       :nig "C-k"      'kill-line
       :nig "C-d"      'delete-char
       :nig "C-h"      'delete-backward-char
       :nig "C-w"      'backward-kill-word)

      (:map (pabbrev-select-mode-map evil-org-mode-map)
       :i "C-l" 'pabbrev-expand-maybe)

      (:map (org-brain-prefix-map)
       "D" 'org-brain-add-entry
       "E" 'my-erase-brain-history)

      (:map (deft-mode-map)
       :e "<escape>" 'quit-window
       :e "C-u"      'deft-filter-clear
       :e "C-k"      'deft-filter-clear)

      (:map (org-brain-visualize-mode-map)
       :e "SPC"      'push-button
       :e "gg"       'beginning-of-buffer
       :e "G"        'end-of-buffer
       :e ","        'avy-goto-word-or-subword-1
       :e "C-."      'counsel-brain
       :e "ç"        'org-brain-prefix-map
       :e "C-r"      'org-brain-update-id-locations
       :e "o"        'my-brain-goto-current-maximize
       :e "C-l"      #'link-hint-open-link
       :e "<escape>" 'ignore)

      (:map (flyspell-mode-map)
       :n "-" 'endless/ispell-word-then-abbrev)

      (:map (custom-mode-map compilation-mode-map)
       :n "<escape>" 'evil-force-normal-state))
