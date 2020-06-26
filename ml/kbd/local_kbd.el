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
       "E" 'my-brain-erase-history)

      (:map (deft-mode-map)
       :e "<escape>" 'quit-window
       :e "C-u"      'deft-filter-clear
       :e "C-k"      'deft-filter-clear
       :e "C-h"      'deft-filter-decrement
       :e "C-w"      'deft-filter-decrement-word
       :e "C-r"      'deft-refresh-filter)

      (:map (org-brain-visualize-mode-map)
       :e "<C-return>"  'my-brain-push-and-open
       :e "SPC d"       'my-search-ag-brain
       :e "D"           'org-brain-add-entry
       :e "m"           'push-button
       :e "C-."         'counsel-brain
       :e "G"           'end-of-buffer
       :e "C-x b"       'my-brain-commands
       :e "C-l"         'link-hint-open-link
       :e "gg"          'beginning-of-buffer
       :e "ç"           'org-brain-prefix-map
       :e "O"           'org-brain-goto-current
       :e "r"           'org-brain-rename-file
       :e "R"           'org-brain-open-resource
       :e "<f9>"        'org-brain-visualize-quit
       :e "<f8>"        'org-brain-visualize-quit
       :e "<escape>"    'ignore
       :e "q"           'ignore
       :e ","           'avy-goto-char-2
       :e "."           'org-brain-visualize-mind-map
       :e "<backspace>" 'org-brain-visualize-mind-map
       :e "i"           'org-brain-switch-brain
       :e "C-r"         'org-brain-update-id-locations
       :e "o"           'my-brain-goto-current-maximize)

      (:map (messages-buffer-mode-map)
       :ng "<escape>" 'ignore
       :nveg "q"      'quit-window)

      (:map (custom-mode-map compilation-mode-map)
       :n "<escape>" 'evil-force-normal-state))
