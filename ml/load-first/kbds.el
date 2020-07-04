(define-key key-translation-map (kbd "ˆ") (kbd "^"))
(define-key key-translation-map (kbd "ˆ") (kbd "^"))
(define-key key-translation-map (kbd "º") (kbd "-"))
(define-key key-translation-map (kbd "s-8") (kbd "["))
(define-key key-translation-map (kbd "s-9") (kbd "]"))
(define-key key-translation-map (kbd "s-(") (kbd "{"))
(define-key key-translation-map (kbd "s-)") (kbd "}"))
(define-key key-translation-map (kbd "<help>") (kbd "<insert>"))

(map! :desc "Brain Visualize"      :leader "fv" 'org-brain-visualize
      :desc "Cleanup Recent Files" :leader "fc" 'recentf-cleanup
      :desc "Copy Directory"       :leader "fY" 'my-copy-directory
      :desc "Goto Agenda"          :leader "fa" 'my-goto-agenda
      :desc "Goto Brain"           :leader "fB" 'my-goto-brain
      :desc "Goto Lisp"            :leader "fl" 'my-deer-goto-my-lisp
      :desc "Goto Main Brain"      :leader "fb" 'my-goto-brain-main
      :desc "Goto My Packages"     :leader "fp" 'my-goto-my-packages
      :desc "Locate"               :leader "fo" 'counsel-locate
      :desc "Org Capture"          :leader "fc" 'org-capture
      :desc "Recent Files"         :leader "F"  'counsel-recentf
      :desc "Recent Files"         :leader "fr" 'counsel-recentf
      :desc "Rename File"          :leader "fR" 'my-rename-file-and-buffer
      :desc "Reopen File"          :leader "T"  'my-reopen-killed-file
      :desc "Scratch Markdown"     :leader "fm" 'my-goto-markdown
      ;; :desc "Search Keys"          :leader "fk" 'my-search-kbds
      :desc "Search Pkgs"          :leader "fp" 'my-search-packages
      :desc "Search Setts"         :leader "fs" 'my-search-settings
      :desc "Doom Dashboard"       :leader "fd" '+doom-dashboard/open)

;; MISC LEADER KEYS FILE

(general-unbind '(doom-leader-map)
  "SPC")

(general-unbind '(scratch-fundamental-mode-map scratch-lisp-mode-map)
  :with 'quit-window
  [remap my-goto-scratch-buffer]
  [remap doom/open-scratch-buffer])

;; LOCAL LEADER
(map! :map org-mode-map
      :desc "Org Clock" :localleader "j" 'hydra-org-clock/body)

;; OTHER LEADER KEYS
(map! :desc "Ag Brain"                :leader "d"     'my-search-ag-brain
      :desc "Jump to Register"        :leader "J"     'jump-to-register
      :desc "Save Window Config"      :leader "j"     'window-configuration-to-register
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
      :desc "Yasnippet Hydra"         :leader "y"     'hydra-yasnippet/body
      :desc "Windows Hydra"           :leader "z"     'hydra-window/body
      :desc "Restart Emacs"           :leader "qr"    'doom/restart
      :desc "Restart Emacs & Restore" :leader "qR"    'doom/restart-and-restore)

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
      :desc "Dup Paragraph"        :leader "tp" 'my-dup-par
      :desc "Dup Inner Paragraph"  :leader "ti" 'my-dup-inner-par
      :desc "Sort Lines by Length" :leader "tS" 'my-sort-lines-by-length
      :desc "Langtool Buffer"      :leader "tl" 'langtool-check-buffer
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
      :desc "Eval Paragraph" :leader "eP" 'my-eval-paragraph-macro
      :desc "Org Babel Tagle":leader "et" 'org-babel-tangle)

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

(map! :desc "Insert to Emacs"     :n "i"        'evil-emacs-state
      :desc "Append to Emacs"     :n "a"        'my-append-to-emacs-state
      :desc "Append Line Emacs"   :n "A"        'my-append-line-to-emacs-state
      :desc "Open Below to Emacs" :n "o"        'my-open-below-to-emacs-state
      :desc "Open Above to Emacs" :n "O"        'my-open-above-to-emacs-state
      :desc "Kill Line to Emacs"  :n "C-k"      'my-kill-line-to-emacs-state)

(map! :map (minibuffer-local-map
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

(map! "C-'"                       'org-cycle-agenda-files
      "M-/"                       'hippie-expand
      "C-x p"                     'check-parens
      "C-;"                       'helpful-at-point
      "M-RET"                     'my-indent-buffer
      "C-c B"                     'my-brain-commands
      "<f9>"                      'my-goto-brain-same-window
      "<f8>"                      'my-goto-brain
      "C-c v"                     'vlf
      "M-9"                       'delete-other-windows
      "M-0"                       'quit-window
      "M-n"                       'my-forward-paragraph-do-indentation
      "M-p"                       'my-backward-paragraph-do-indentation
      "C-c y"                     'kill-ring-save
      "C-c m"                     'define-mode-abbrev
      "C-c M"                     'define-global-abbrev
      "C-c u"                     'redraw-display
      "C-l"                       'recenter-top-bottom
      "M--"                       'winner-undo
      "M-="                       'winner-redo
      "C-c q"                     'quick-calc
      "C-c d"                     'ispell-change-dictionary
      "C-c o"                     'my-org-force-open-other-window
      "C-h M"                     'my-show-major-mode
      "C-c C-o"                   'org-open-at-point-global
      "C-c e"                     'my-force-evil-mode
      :desc "Caps Lock" "C-c SPC" 'caps-lock-mode
      :nvig "M-2"                 'evil-execute-macro
      :nvig "C-2"                 'evil-record-macro
      :nvg "C-h e"                'describe-package
      :nvg "C-h N"                'my-show-server-name)

(general-define-key
 :keymaps 'override
 :states  '(normal visual insert emacs)
 "M-k"    'windmove-up
 "M-j"    'windmove-down
 "M-h"    'windmove-left
 "M-l"    'windmove-right
 "C-j"    'treemacs-select-window
 "C-c b"  'org-brain-prefix-map
 "M-s"    'my-last-buffer
 "M-,"    'previous-buffer
 "M-."    'next-buffer)

(general-define-key
 :keymaps 'override
 :states  '(normal visual)
 "L"      'projectile-next-project-buffer
 "H"      'projectile-previous-project-buffer)

(general-define-key
 :keymaps 'override
 :states  '(insert)
 "C-k"    'kill-line
 "C-d"    'delete-char
 "C-h"    'delete-backward-char
 "C-w"    'backward-kill-word)

(general-define-key
 :keymaps 'override
 :states '(visual)
 "gr"    'my-eval-region)
