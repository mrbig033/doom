(general-unbind '(doom-leader-map)
  "SPC")

(map! :leader "SPC msl" 'scratch-lisp-mode
      :leader "SPC msu" 'unkillable-scratch
      :leader "SPC msf" 'scratch-fundamental-mode
      :leader "SPC mpl" 'lisp-interaction-mode
      :leader "SPC mty" 'typo-mode
      :leader "SPC mth" 'hl-line-mode
      :leader "SPC mto" 'olivetti-mode
      :leader "SPC mtw" 'writegood-mode
      :leader "SPC mta" 'artbollocks-mode
      :leader "SPC mts" 'hl-sentence-mode
      :leader "SPC mtv" 'visible-mode
      :leader "SPC mpc" 'company-mode
      :leader "SPC p"   'my-goto-my-packages
      :leader "SPC x"   'org-capture
      :leader "SPC k"   'my-deer-goto-my-kdb
      :leader "SPC l"   'my-deer-goto-my-lisp
      :leader "SPC p"   'my-goto-my-packages
      :leader "SPC a"   'my-goto-agenda
      :leader "SPC c"   '+popup/close-all)

;; LEADER KEY
(map!

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

 :leader "l"      'link-hint-open-link
 :leader "mgx"    'org-capture-goto-last-stored
 :leader "nn"     'recursive-narrow-or-widen-dwim
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
 :leader "ek"    'my-eval-buffer-kill
 )
