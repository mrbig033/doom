;; LEADER KEY
(map! :leader "sw"  'wordnut-lookup-current-word
      :leader "sW"  'wordnut-search
      :leader "sg"  'counsel-ag
      :leader "l"   'link-hint-open-link
      :leader "br"  '+popup/raise
      :leader "mgx" 'org-capture-goto-last-stored
      :leader "z"   'org-capture
      :leader "ww"  'doom/window-maximize-vertically
      :leader "k"   'kill-current-buffer
      :leader "x"   'eyebrowse-close-window-config
      :leader "r"   'deer
      :leader "0"   'delete-window
      :leader "nn"  'recursive-narrow-or-widen-dwim
      :leader "nw"  'my-widen-to-center
      :leader "to"  'olivetti-mode
      :leader "cw"  'count-words
      :leader "hdS" 'my-search-doom-help
      :leader "SPC" nil
      :leader "k"   'kill-current-buffer
      :leader "SPC k"  'my-deer-goto-my-kdb
      :leader "SPC l"   'my-deer-goto-my-lisp
      :leader "SPC p" 'my-goto-my-packages
      :leader "SPC x" 'org-capture
      ;; TEXT ;;
      :leader "tT"  'my-reload-file
      :leader "tB"  'spelling-brasileiro
      :leader "tE"  'spelling-english
      :leader "td"  'my-dup-line
      :leader "te"  'hl-sentence-mode
      :leader "th"  'hl-line-mode
      :leader "tD"  'ispell-change-dictionary
      :leader "tc"  'xah-clean-empty-lines
      :leader "ti"  'my-dup-par
      :leader "tv"  'visible-mode
      :leader "tS"  'my-sort-lines-by-length
      :leader "ta"  'artbollocks-mode
      :leader "tg"  'writegood-mode
      :leader "tb"  'flyspell-buffer
      :leader "tl"  'langtool-check-buffer
      :leader "tL"  'langtool-check-done
      :leader "tt"  'google-translate-smooth-translate
      :leader "tC"  'company-mode
      :leader "oo"  'hydra-org-mode/body
      :leader "mm"  'lisp-interaction-mode

      ;; COPY DIRECTORY PATH ;;
      :leader "fY" 'my-copy-directory

      ;; SEARCH SETTINGS ;;
      :leader "fs" 'my-search-settings
      :leader "fk" 'my-search-packages
      :leader "fK" 'my-search-kbds

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
      :leader "g SPC" 'my-magit-stage-modified-and-commit
      :leader "meb"   'my-eval-buffer
      :leader "ee"    'my-eval-buffer
      :leader "el"    'my-eval-buffer-and-leave
      :leader "eq"    'my-eval-buffer-quit
      :leader "ek"    'my-eval-buffer-kill
      :leader "ek"    'my-eval-buffer-kill
      :leader "ba"    'my-goto-markdown
      :leader "bd"    'server-force-delete
      :leader "mwi"    'org-web-tools-insert-link-for-url
      :leader "mwe"    'org-web-tools-archive-view
      :leader "mwv"    'org-web-tools-archive-attach
      :leader "mwr"    'org-web-tools-read-url-as-org
      :leader "mwc"    'org-web-tools-convert-links-to-page-entries)
