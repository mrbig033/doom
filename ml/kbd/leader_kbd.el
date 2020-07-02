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
(map!

 :leader "-"      'insert-char
 :leader "."      'counsel-describe-variable
 :leader "0"      'delete-window
 :leader ";"      'helpful-at-point
 :leader "cw"     'count-words
 :leader "d"      'my-search-ag-brain
 :leader "fK"     'my-search-kbds
 :leader "fk"     'my-search-packages
 :leader "fs"     'my-search-settings
 :leader "g SPC"  'my-magit-stage-modified-and-commit
 :leader "k"      'kill-current-buffer

 :leader "mgx"    'org-capture-goto-last-stored
 :leader "nn"     'my-narrow-or-widen-dwim
 :leader "nw"     'my-widen-to-center
 :leader "ww"     'doom/window-maximize-vertically
 :leader "x"      'eyebrowse-close-window-config
 :leader "z"      'hydra-window/body

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
 :leader "tB"  'flyspell-buffer
 :leader "tT"  'my-reload-file
 :leader "tt"  'my-dup-line
 :leader "tT"  'google-translate-smooth-translate
 :leader "tD"  'ispell-change-dictionary
 :leader "tc"  'xah-clean-empty-lines
 :leader "tC"  'my-clean-all-empty-lines
 :leader "ti"  'my-dup-par
 :leader "tS"  'my-sort-lines-by-length
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
