;; MISC LEADER KEYS FILE

(general-unbind '(doom-leader-map)
  "SPC")

(general-unbind '(scratch-fundamental-mode-map scratch-lisp-mode-map)
  :with 'quit-window
  [remap my-goto-scratch-buffer]
  [remap doom/open-scratch-buffer])

;; OTHER LEADER KEYS
(map! :desc "Ag Brain"                :leader "d"     'my-search-ag-brain
      :desc "Counsel Ag"              :leader "sg"    'counsel-ag
      :desc "Count Words"             :leader "cw"    'my-artbollocks-count-words
      :desc "Delete Window"           :leader "0"     'delete-window
      :desc "Describe Variable"       :leader "."     'counsel-describe-variable
      :desc "Dic. Info. AP"           :leader "si"    'engine/search-dic-infor-ap
      :desc "Dic. Info. Sin. AP"      :leader "ss"    'engine/search-dic-infor-sin-ap
      :desc "Dic. Info."              :leader "sI"    'engine/search-dic-infor
      :desc "Dic. Inf. Sin."          :leader "sS"    'engine/search-dic-infor-sin
      :desc "Michaelis"               :leader "sC"    'engine/search-michaelis
      :desc "Michaelis AP"            :leader "sc"    'my-engine-search-michaealis-ap
      :desc "Free Dict Pt"            :leader "sF"    'engine/search-free-dic-pt
      :desc "Free Dict Pt AP"         :leader "sf"    'engine/free-dic-pt-ap
      :desc "Aurélio"                 :leader "sA"    'engine/search-aurelio
      :desc "Aurélio AP"              :leader "sa"    'engine/search-aurelio-ap
      :desc "Counsel Bookmark"        :leader "sM"    'counsel-bookmark
      :desc "Counsel Marks"           :leader "sm"    'counsel-evil-marks
      :desc "Doom Package Configs"    :leader "hdpc"  'my-search-doom-package-config
      :desc "Helpful at Point"        :leader ";"     'helpful-at-point
      :desc "Insert Char"             :leader "-"     'insert-char
      :desc "Kill Buffer"             :leader "k"     'kill-current-buffer
      :desc "Kill Both"               :leader "K"     'kill-buffer-and-window
      :desc "Magit Stage & Commit"    :leader "g SPC" 'my-magit-stage-modified-and-commit
      :desc "Maximize Vertically"     :leader "ww"    'doom/window-maximize-vertically
      :desc "Narrow Dwin"             :leader "nn"    'my-narrow-or-widen-dwim
      :desc "Widen to Center"         :leader "nw"    'my-widen-to-center
      :desc "Default Brwoser"         :leader "oB"    'browse-url-of-file
      :desc "org2blog"                :leader "ob"    'org2blog--hydra-main/body
      :desc "Def. Yank Pop"           :leader "iY"    '+default/yank-pop
      :desc "Yasnippet Hydra"         :leader "iy"    'hydra-yasnippet/body
      :desc "Windows Hydra"           :leader "z"     'hydra-window/body
      :desc "Restart Emacs"           :leader "qr"     'doom/restart
      :desc "Restart Emacs & Restore" :leader "qR"     'doom/restart-and-restore
      :desc "New Workspace"           :leader "v"     '+workspace/new
      :desc "Close Workspace"         :leader "x"     '+workspace/close-window-or-workspace)

;; DOUBLE SPACES
(map! :desc "Beacon"              :leader "SPC tB" 'beacon-mode
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
      :desc "Insert Only"         :leader "SPC ti" 'only-insert-mode
      :desc "Unkillable Scratch"  :leader "SPC su" 'unkillable-scratch
      :desc "Visible"             :leader "SPC tv" 'visible-mode
      :desc "Writegood"           :leader "SPC tw" 'writegood-mode
      :desc "Artbollocks"         :leader "SPC ta" 'artbollocks-mode)

;; BUFFERS
(map! :desc "Goto Scratch"    :leader "bX"  'my-goto-scratch-buffer
      :desc "Pop-Up Scratch"  :leader "bx"  'doom/open-scratch-buffer
      :desc "Close Popups"    :leader "bc"  'clone-indirect-buffer-other-window
      :desc "Kill All"        :leader "bK"  'my-doom-kill-all-buffers
      :desc "Delete Server"   :leader "bd"  'server-force-delete
      :desc "Git Timemachine" :leader "bg"  'git-timemachine
      :desc "Ibuffer"         :leader "bI"  'ibuffer
      :desc "Show Init Times" :leader "bi"  'my-show-init-times
      :desc "Raise Popup"     :leader "br"  '+popup/raise
      :desc "Kill Matching"   :leader "bt"  'doom/kill-matching-buffers
      :desc "Show Major Mode" :leader "h M" 'my-show-major-mode)

;; TEXT ;;
(map! :desc "Flyspell Buffer"      :leader "tB" 'flyspell-buffer
      :desc "Reload File"          :leader "tT" 'my-reload-file
      :desc "Duplicate Line"       :leader "tt" 'my-dup-line
      :desc "Google Translate"     :leader "tT" 'google-translate-smooth-translate
      :desc "Change Dictionary"    :leader "tD" 'ispell-change-dictionary
      :desc "Clean Lines"          :leader "tc" 'xah-clean-empty-lines
      :desc "Clean All Lines"      :leader "tC" 'my-clean-all-empty-lines
      :desc "Duplicate Paragraph"  :leader "ti" 'my-dup-par
      :desc "Sort Lines by Length" :leader "tS" 'my-sort-lines-by-length
      :desc "Langtool Buffer"      :leader "tl" 'langtool-check-buffer
      :desc "Zen Mode"             :leader "tz" 'my-zen-mode
      :desc "Langtool Done"        :leader "tL" 'langtool-check-done
      :desc "Org Hydra"            :leader "oo" 'hydra-org-mode/body)

;; EVIL SUBSTITUTE ;;
(map! :desc "Evil Substitute" :leader "su" (lambda ()
                                             (interactive)
                                             (evil-ex "%s/")))

;; WINDOWS ;;
(map! :desc "Split Right" :leader "wl" (lambda ()
                                         (interactive)
                                         (+evil-window-vsplit-a)
                                         (other-window 1))
      :desc "Split Down"  :leader "wj" (lambda ()
                                         (interactive)
                                         (+evil-window-split-a)
                                         (other-window 1))
      :desc "Split Up"    :leader "wk"    '+evil-window-split-a
      :desc "Split Left"  :leader "wh"    '+evil-window-vsplit-a)

;; EVAL
(map! :desc "Eval Buffer"    :leader "ee" 'my-eval-buffer
      :desc "Eval & Leave"   :leader "el" 'my-eval-buffer-and-leave
      :desc "Eval & Quit"    :leader "eq" 'my-eval-buffer-quit
      :desc "Eval & Kill"    :leader "ek" 'my-eval-buffer-kill
      :desc "Eval Paren"     :leader "ep" 'my-eval-paren-macro
      :desc "Eval Paragraph" :leader "eP" 'my-eval-paragraph-macro)
