(general-unbind '(doom-leader-map)
  "SPC")

(map! :leader "SPC sl" 'scratch-lisp-mode
      :leader "SPC su" 'unkillable-scratch
      :leader "SPC sf" 'scratch-fundamental-mode

      :leader "SPC ty" 'typo-mode
      :leader "SPC th" 'hl-line-mode
      :leader "SPC to" 'olivetti-mode
      :leader "SPC tw" 'writegood-mode
      :leader "SPC ta" 'artbollocks-mode
      :leader "SPC ts" 'hl-sentence-mode
      :leader "SPC tv" 'visible-mode
      :leader "SPC tb" 'beacon-mode

      :leader "SPC pc" 'company-mode
      :leader "SPC pl" 'lisp-interaction-mode

      :leader "SPC bh" 'hide-mode-line-mode

      :leader "fl" 'my-deer-goto-my-lisp
      :leader "fc" 'org-capture
      :leader "fL" 'counsel-locate
      :leader "fa" 'my-goto-agenda
      :leader "fb" 'my-goto-brain
      :leader "fv" 'org-brain-visualize
      :leader "fp" 'my-goto-my-packages
      :leader "bc" '+popup/close-all)

;; LEADER KEY
(map! :leader "he"     'my-goto-messages-buffer
      :leader "-"      'insert-char
      :leader "d"      'my-search-ag-brain
      :leader ";"      'helpful-at-point
      :leader "."      'counsel-describe-variable
      :leader "fk"     'my-search-packages
      :leader "fK"     'my-search-kbds
      :leader "fs"     'my-search-settings
      :leader "g SPC"  'my-magit-stage-modified-and-commit
      :leader "0"      'delete-window
      :leader "cw"     'count-words
      :leader "k"      'kill-current-buffer
      :leader "ba"     'my-goto-markdown
      :leader "br"     '+popup/raise
      :leader "bd"     'server-force-delete
      :leader "bt"     'doom/kill-matching-buffers
      :leader "bg"     'git-timemachine
      :leader "l"      'link-hint-open-link
      :leader "mgx"    'org-capture-goto-last-stored
      :leader "nn"     'my-narrow-or-widen-dwim
      :leader "nw"     'my-widen-to-center
      :leader "sg"     'counsel-ag
      :leader "ww"     'doom/window-maximize-vertically
      :leader "x"      'eyebrowse-close-window-config
      :leader "z"      'org-capture

      ;; TEXT ;;
      :leader "tT"  'my-reload-file
      :leader "tB"  'spelling-brasileiro
      :leader "tE"  'spelling-english
      :leader "tt"  'my-dup-line
      :leader "tT"  'google-translate-smooth-translate
      :leader "tD"  'ispell-change-dictionary
      :leader "tc"  'xah-clean-empty-lines
      :leader "tC"  'my-clean-all-empty-lines
      :leader "ti"  'my-dup-par
      :leader "tS"  'my-sort-lines-by-length
      :leader "tb"  'flyspell-buffer
      :leader "tl"  'langtool-check-buffer
      :leader "tL"  'langtool-check-done
      :leader "oo"  'hydra-org-mode/body


      ;; COPY DIRECTORY PATH ;;
      :leader "fY" 'my-copy-directory

      ;; SEARCH SETTINGS ;;
                                        ; :leader "fs" 'my-search-settings
                                        ; :leader "fk" 'my-search-packages
                                        ; :leader "fK" 'my-search-kbds

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
      :leader "T"     'my-reopen-killed-file
      :leader "meb"   'my-eval-buffer
      :leader "ee"    'my-eval-buffer
      :leader "el"    'my-eval-buffer-and-leave
      :leader "eq"    'my-eval-buffer-quit
      :leader "ek"    'my-eval-buffer-kill
      :leader "ek"    'my-eval-buffer-kill)
