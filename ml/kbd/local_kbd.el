;; LOCAL KEYBINDINGS
;; Add "after!" to "map!" blocks like so:
;; Source: https://bit.ly/2VJWrlf
;; (map! :after org-agenda
;;       :map org-agenda-mode-map)

(map! (:map (pabbrev-mode-map pabbrev-select-mode-map)
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

      (:map (org-mode-map evil-org-mode-map)
            :nvig "C-c C-s" 'org-emphasize
            :v "<insert>" 'org-insert-link)

      (:map (markdown-mode-map)
            "C-c ," 'my-engine-rhymit-pt
            "C-c ." 'my-engine-dic-informal-rimas)

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

      (:map (flyspell-mode-map)
            :n "z=" 'endless/ispell-word-then-abbrev
            :n "z-" 'flyspell-auto-correct-previous-word)

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
            :e "o"           'my-brain-goto-current-maximize
            :e "O"           'my-brain-goto-current-maximize-and-go
            :e "r"           'org-brain-rename-file
            :e "R"           'org-brain-open-resource
            :e "<f9>"        'quit-window
            :e "go"          'org-brain-goto
            :e "<f8>"        'quit-window
            :e "<f12>"       'my-brain-olivetti
            :e "<escape>"    'ignore
            :e "q"           'ignore
            :e ","           'avy-goto-char-2
            :e "."           'org-brain-visualize-mind-map
            :e "<backspace>" 'org-brain-visualize-mind-map
            :e "i"           'org-brain-switch-brain
            :e "C-r"         'org-brain-update-id-locations)

      (:map (messages-buffer-mode-map)
            :ng "<escape>" 'ignore
            :nveg "q"      'quit-window)

      (:map (fountain-mode-map)
            :nvi "TAB" 'fountain-dwim
            :nv "C-;"  'fountain-upcase-line-and-newline
            :nv "c-n"  'fountain-forward-character
            :nv "c-p"  'fountain-backward-character
            :nv "gh"   'fountain-forward-scene
            :nv "gj"   'fountain-outline-next
            :nv "gk"   'fountain-outline-previous
            :nv "gl"   'fountain-backward-scene
            :nv "m-n"  'fountain-forward-scene
            :nv "m-p"  'fountain-backward-scene
            :nv "zi"   'fountain-outline-show-all
            :nv "zm"   'fountain-outline-cycle-global)

      (:map (custom-mode-map compilation-mode-map)
            :n "<escape>" 'evil-force-normal-state))
