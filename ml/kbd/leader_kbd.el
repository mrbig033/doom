(general-unbind '(doom-leader-map)
  "SPC")

;; DOUBLE SPACES
(map! :desc "Artbollocka"         :leader "SPC ta" 'artbollocks-mode
      :desc "Beacon"              :leader "SPC tB" 'beacon-mode
      :desc "Company"             :leader "SPC pc" 'company-mode
      :desc "Hide Modeline"       :leader "SPC bh" 'hide-mode-line-mode
      :desc "Hl-Line"             :leader "SPC th" 'hl-line-mode
      :desc "Hl-Sentence"         :leader "SPC ts" 'hl-sentence-mode
      :desc "Lisp Interaction"    :leader "SPC pl" 'lisp-interaction-mode
      :desc "Olivetti"            :leader "SPC to" 'olivetti-mode
      :desc "Poetry"              :leader "SPC tP" 'poetry-mode
      :desc "Prose Brasil"        :leader "SPC tb" 'my-prose-enable-br
      :desc "Prose Disable"       :leader "SPC td" 'my-prose-disable
      :desc "Prose English"       :leader "SPC te" 'my-prose-enable-en
      :desc "Scratch Fundamental" :leader "SPC sf" 'scratch-fundamental-mode
      :desc "Scratch Lisp"        :leader "SPC sl" 'scratch-lisp-mode
      :desc "Typo"                :leader "SPC ty" 'typo-mode
      :desc "Unkillable Scratch"  :leader "SPC su" 'unkillable-scratch
      :desc "Visible"             :leader "SPC tv" 'visible-mode
      :desc "Writegood"           :leader "SPC tw" 'writegood-mode
      :desc "Emacs Init Time"     :leader "SPC be" 'emacs-init-time
      :desc "Doom Init Time"      :leader "SPC bd" 'my-doom-init-time)

;; LEADER KEY
(map! :desc "Insert " :leader "-"      'insert-char
      :desc "" :leader "."      'counsel-describe-variable
      :desc "" :leader "0"      'delete-window
      :desc "" :leader ";"      'helpful-at-point
      :desc "" :leader "cw"     'count-words
      :desc "" :leader "d"      'my-search-ag-brain
      :desc "" :leader "fK"     'my-search-kbds
      :desc "" :leader "fk"     'my-search-packages
      :desc "" :leader "fs"     'my-search-settings
      :desc "" :leader "g SPC"  'my-magit-stage-modified-and-commit
      :desc "" :leader "k"      'kill-current-buffer
      :desc "" :leader "mgx"    'org-capture-goto-last-stored
      :desc "" :leader "nn"     'my-narrow-or-widen-dwim
      :desc "" :leader "nw"     'my-widen-to-center
      :desc "" :leader "ww"     'doom/window-maximize-vertically
      :desc "" :leader "x"      'eyebrowse-close-window-config
      :desc "" :leader "z"      'hydra-window/body

      :desc "Counsel Ag" :leader "sg"     'counsel-ag

      :desc "Dic. Informal" :leader "si"     'engine/search-dic-informal
      :desc "Dic. Inf. Sinônimos" :leader "ss"     'engine/search-dic-informal-sinonimos

      ;; BUFFERS

      :desc "Goto Scratch"    :leader "bx" 'my-goto-scratch-buffer
      :desc "Pop-Up Scratch"  :leader "bX" 'doom/open-scratch-buffer
      :desc "Close Popups"    :leader "bc" '+popup/close-all
      :desc "Kill All"        :leader "bK" 'my-doom-kill-all-buffers
      :desc "Delete Server"   :leader "bd" 'server-force-delete
      :desc "Git Timemachine" :leader "bg" 'git-timemachine
      :desc "Raise Popup"     :leader "br" '+popup/raise
      :desc "Kill Matching"   :leader "bt" 'doom/kill-matching-buffers

      ;; FILES
      :desc "Org Capture"          :leader "fc" 'org-capture
      :desc "Goto Brain"           :leader "fB" 'my-goto-brain
      :desc "Goto Agenda"          :leader "fa" 'my-goto-agenda
      :desc "Copy Directory"       :leader "fY" 'my-copy-directory
      :desc "Locate"               :leader "fL" 'counsel-locate
      :desc "Goto Main Brain"      :leader "fb" 'my-goto-brain-main
      :desc "Goto My Packages"     :leader "fp" 'my-goto-my-packages
      :desc "Brain Visualize"      :leader "fv" 'org-brain-visualize
      :desc "Goto Lisp"            :leader "fl" 'my-deer-goto-my-lisp
      :desc "Cleanup Recent Files" :leader "fc" 'recentf-cleanup
      :desc "Scratch Markdown"     :leader "fm" 'my-goto-markdown
      :desc "Recent Files"         :leader "F"  'counsel-recentf
      :desc "Recent Files"         :leader "fr" 'counsel-recentf
      :desc "Rename File"          :leader "fR" 'my-rename-file-and-buffer

      ;; TEXT ;;

      :desc "Flyspell Buffer"      :leader "tB" 'flyspell-buffer
      :desc "Reload File"          :leader "tT" 'my-reload-file
      :desc "Duplicate Line"       :leader "tt" 'my-dup-line
      :desc "Google Translate"     :leader "tT" 'google-translate-smooth-translate
      :desc "Change Dictionary"    :leader "tD" 'ispell-change-dictionary
      :desc "Clean Lines"          :leader "tc" 'xah-clean-empty-lines
      :desc "Clean All Lines"      :leader "tC" 'my-clean-all-empty-lines
      :desc "Duplicate Paragraph"  :leader "ti" 'my-dup-par
      :desc "Sort Lines by Length" :leader "tS" 'my-sort-lines-by-length
      :desc "Langtool Buffer"      :leader "tl" 'langtool-check-buffer
      :desc "Langtool Done"        :leader "tL" 'langtool-check-done
      :desc "Org Hydra"            :leader "oo" 'hydra-org-mode/body


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

      ;; EVAL


      :desc "Eval Buffer" :leader "ee"    'my-eval-buffer
      :desc "Eval & Leave" :leader "el"    'my-eval-buffer-and-leave
      :desc "Eval & Quit" :leader "eq"    'my-eval-buffer-quit
      :desc "Eval & Kill" :leader "ek"    'my-eval-buffer-kill)
