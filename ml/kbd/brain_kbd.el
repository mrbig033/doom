(map! :after org-brain
      :map (org-brain-visualize-mode-map)
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
