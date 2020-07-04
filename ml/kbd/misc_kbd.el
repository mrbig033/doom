;; MISC LOCAL KEYBINDINGS
;; Add "after!" to "map!" blocks like so:
;; Source: https://bit.ly/2VJWrlf
;; (map! :after org-agenda
;;       :map org-agenda-mode-map)

(map! (:map (pabbrev-mode-map pabbrev-select-mode-map)
       :i "C-l" 'pabbrev-expand-maybe)

      (:map helpful-mode-map
       :nvig "C-r" 'helpful-update
       :n "<escape>" 'quit-window)

      (:map (org-mode-map evil-org-mode-map)
       :nvig "C-c C-s" 'org-emphasize
       :v "<insert>" 'org-insert-link)

      (:map (markdown-mode-map)
       "C-c ," 'my-engine-rhymit-pt
       "C-c ." 'my-engine-dic-informal-rimas)

      (:map (org-brain-prefix-map)
       "D" 'org-brain-add-entry
       "E" 'my-brain-erase-history)

      (:map (flyspell-mode-map)
       :n "-" 'endless/ispell-word-then-abbrev
       :n "z-" 'flyspell-correct-word)

      (:map (messages-buffer-mode-map)
       :ng "<escape>" 'ignore
       :nveg "q"      'quit-window)

      (:map (emacs-lisp-mode-map
             prog-mode-map
             text-mode-map
             conf-mode-map)
       :n "<escape>" 'my-quiet-save-buffer)

      (:map (snippet-mode-map)
       :n "<escape>" 'ignore
       :n "q" 'quit-window)

      (:after scratch-lisp-mode
       :map (scratch-lisp-mode-map)
       :n "<escape>" 'evil-ex-nohighlight
       :leader "k" 'quit-window
       :leader "bx" 'quit-window
       :leader "bX" 'quit-window)

      (:map (custom-mode-map compilation-mode-map)
       :n "<escape>" 'evil-normal-state))

(map! :after ranger
      :desc "Deer"                 :leader "r"     'deer
      :desc "Ranger"               :leader "R"     'ranger)

(map! :after evil-org
      :map (evil-org-mode-map)
            :desc "Insert to Emacs"     :n "i"        'evil-emacs-state
            :desc "Append to Emacs"     :n "a"        'my-append-to-emacs-state
            :desc "Append Line Emacs"   :n "A"        'my-append-line-to-emacs-state
            :desc "Open Below to Emacs" :n "o"        'my-open-below-to-emacs-state
            :desc "Open Above to Emacs" :n "O"        'my-open-above-to-emacs-state
            :desc "Kill Line to Emacs"  :n "C-k"      'my-kill-line-to-emacs-state)
