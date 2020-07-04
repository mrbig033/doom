(after! evil
  (setq! evil-emacs-state-cursor '(bar +evil-emacs-cursor-fn)))

(after! evil
  (evil-better-visual-line-on))

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

(after! apheleia
  (setf (alist-get 'black apheleia-formatters) '("black" "-l" "57" "-")))

(setq! my-lisp "~/.doom.d/ml"
       org-directory "~/org/"
       dumb-jump-aggressive t
       user-full-name "mrbig"
       confirm-kill-emacs nil
       windmove-wrap-around t
       persp-switch-to-added-buffer t
       auto-revert-verbose nil
       my-kbd "~/.doom.d/ml/kbd"
       trash-directory "~/.Trash"
       use-package-always-defer nil
       ns-option-modifier 'meta
       ns-right-option-modifier 'meta
       iedit-toggle-key-default "C-x ;"
       display-line-numbers-type nil
       initial-major-mode 'fundamental-mode
       initial-buffer-choice t
       +word-wrap-extra-indent 'single
       custom-file "~/.doom.d/.custom-file.el"
       abbrev-file-name "~/.doom.d/etc/abbrev.el"
       user-mail-address "mrbig033@protonmail.com"
       langtool-language-tool-jar "~/maps/langtool/langtooljar"
       doom-theme 'doom-one
       doom-font (font-spec :family "Menlo" :size 19)
       doom-big-font (font-spec :family "Menlo" :size 19)
       doom-unicode-font (font-spec :family "Menlo" :size 19)
       doom-variable-pitch-font (font-spec :family "Input Mono")
       doom-localleader-key "m")
(put 'narrow-to-region 'disabled nil)
(put 'customize-group 'disabled nil)

(load! "/Users/davi/.doom.d/custom-lisp/auto-capitalize.el")

(define-derived-mode scratch-lisp-mode
  lisp-interaction-mode "scratch-lisp")
(global-subword-mode +1)
;; (yas-global-mode -1)

(define-key key-translation-map (kbd "ˆ") (kbd "^"))
(define-key key-translation-map (kbd "<help>") (kbd "<insert>"))
;; (define-key key-translation-map (kbd "s-8") (kbd "["))
;; (define-key key-translation-map (kbd "s-9") (kbd "]"))
;; (define-key key-translation-map (kbd "s-(") (kbd "{"))
;; (define-key key-translation-map (kbd "s-)") (kbd "}"))

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
       "C-c o" 'counsel-outline
       :nv "<insert>" 'org-insert-link)

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

(map! :desc "Brain Visualize"      :leader "fv" 'org-brain-visualize
      :desc "Cleanup Recent Files" :leader "fc" 'recentf-cleanup
      :desc "Copy Directory"       :leader "fY" 'my-copy-directory
      :desc "Goto Agenda"          :leader "fa" 'my-goto-agenda
      :desc "Goto Brain"           :leader "fB" 'my-goto-brain
      :desc "Goto Lisp"            :leader "fl" 'my-deer-goto-my-lisp
      ;; :desc "Goto Main Brain"      :leader "fb" 'my-goto-brain-main
      :desc "Goto Main Brain"      :leader "fb" 'my-goto-elisp-src-buffer
      :desc "Goto My Packages"     :leader "fp" 'my-goto-my-packages
      :desc "Locate"               :leader "fo" 'counsel-locate
      :desc "Org Capture"          :leader "fc" 'org-capture
      :desc "Recent Files"         :leader "F"  'counsel-recentf
      :desc "Recent Files"         :leader "fr" 'counsel-recentf
      :desc "Rename File"          :leader "fR" 'my-rename-file-and-buffer
      :desc "Reopen File"          :leader "T"  'my-reopen-killed-file
      :desc "Scratch Markdown"     :leader "fm" 'my-goto-markdown
      :desc "Search Keys"          :leader "fk" 'my-search-kbds
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

(general-unbind '(org-src-mode-map)
  :with 'org-edit-src-exit
  [remap org-edit-special])

;; LOCAL LEADER
(map! :map org-mode-map
      :desc "Org Clock"   :localleader  "j" 'hydra-org-clock/body
      :desc "Edit Special" :localleader "m" 'org-edit-special)

;; LOCAL LEADER
(map! :map (prog-mode-map emacs-lisp-mode-map)
      :desc "Exit Org Src" :localleader "m" 'org-edit-src-exit)

;; OTHER LEADER KEYS
(map! :desc "Ag Brain"                :leader "d"     'my-search-ag-brain
      :desc "Jump to Register"        :leader "J"     'jump-to-register
      :desc "Save Window Config"      :leader "j"     'window-configuration-to-register
      :desc "Narrow to Defun"         :leader "nd"    'narrow-to-defun
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
      :desc "Aur√©lio"                 :leader "sA"    'engine/search-aurelio
      :desc "Aur√©lio AP"              :leader "sa"    'engine/search-aurelio-ap
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
 :states  '(normal)
 "gr"      'my-evil-sel-to-end)

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

;; NORMAL STATE
(map! :desc "Evil Noh"            :n "<escape>" 'evil-ex-nohighlight
      :desc "Back Word End"       :n "g3"       'evil-backward-word-end
      :desc "Cool Open Above"     :n "gO"       'cool-moves-open-line-above
      :desc "Cool Open Below"     :n "go"       'cool-moves-open-line-below
      :desc "Cool Par Backw"      :n "gsP"      'cool-moves-paragraph-backward
      :desc "Cool Par Forw"       :n "gsp"      'cool-moves-paragraph-forward
      :desc "Cool Word Backw"     :n "C-S-p"    'cool-moves-word-backwards
      :desc "Cool Word Forw"      :n "C-S-n"    'cool-moves-word-forward
      :desc "Fold Toggle"         :n "TAB"      '+fold/toggle
      :desc "Forw Word End"       :n "g#"       'evil-forward-word-end
      :desc "Delete Frame"        :n "Q"        'my-delete-frame
      :desc "Cool Moves"          :n "g."       'hydra-cool-moves/body
      :desc "Evil Set Marker"     :n "gm"       'evil-set-marker
      :desc "Evil Goto Mark"      :n "'"        'evil-goto-mark
      :desc "Delete Char"         :n "x"        'delete-char
      :desc "Delete Char Backw"   :n "X"        'delete-backward-char
      :desc "Match & Next"        :n "M-d"      'evil-multiedit-match-and-next)

;; INSERT STATE
(map! :desc "Del Backw"           :i "C-h" 'evil-delete-backward-char-and-join
      :desc "Deled Char Forw"     :i "C-d" 'delete-char
      :desc "Kill Line"           :i "C-k" 'kill-line
      :desc "Kill Word"           :i "M-d" 'kill-word
      :desc "Next Line"           :i "C-n" 'next-line
      :desc "Previous Line"       :i "C-p" 'previous-line
      :desc "Yas Expand"          :i "M-e" 'yas-expand
      "M-u" 'yas-insert-snippet
      "M-y" 'counsel-yank-pop
      "C-s" 'counsel-grep-or-swiper
      "C-." 'counsel-M-x
      :desc "Kill Line Backwards" :i "C-u" 'my-backward-kill-line)

;; EMACS STATE
(map! :desc "Force Normal State"   :e "<escape>" 'evil-normal-state
      :desc "Kill Line Backwards"  :e "C-u"      'my-backward-kill-line
      :desc "Kill Word Backwards"  :e "C-w"      'backward-kill-word
      :desc "Yas Expand"           :e "M-e"      'yas-expand
      :desc "Kill Char Backwards"  :e "C-h"      'delete-backward-char)

;; MULTIPLE STATES
(map! :desc "Align Regexp"         :v "C-c a"    'align-regexp
      :desc "Capitalize Region"    :v "gt"       'capitalize-region
      :desc "End of Visual Line"   :nv "ge"      'evil-end-of-visual-line
      :desc "Jump Backward"        :nv "M-o"     'better-jumper-jump-backward
      :desc "Jump Forward"         :nv "M-i"     'better-jumper-jump-forward
      :desc "Start of Visual Line" :nv "0"       'evil-beginning-of-visual-line
      :desc "Windmove Down"        :niv "M-j"    'windmove-down
      :desc "Windmove Left"        :niv "M-h"    'windmove-left
      :desc "Windmove Right"       :niv "M-l"    'windmove-right
      :desc "Windmove Up"          :niv "M-k"    'windmove-up
      :desc "Comment Line"         :nvg "C-9"    'evilnc-comment-or-uncomment-lines
      :desc "Cool Line Back"       :nvg "C-S-k"  'cool-moves-line-backward
      :desc "Cool Line Forw"       :nvg "C-S-j"  'cool-moves-line-forward
      :desc "Last Buffer"          :nvg "M-s"    'my-last-buffer
      :desc "Next Window"          :nvg "M-["    'evil-window-next
      :desc "Previous Window"      :nvg "M-]"    'evil-window-prev)

(defun my-emacs-init-time ()
  (interactive)
  (let ((str
         (format "%ss"
                 (float-time
                  (time-subtract after-init-time before-init-time)))))
    (if (called-interactively-p 'interactive)
        (message "%s" str)
      str)))

(defun my-show-major-mode ()
  (interactive)
  (message "Major Mode: %s" major-mode))

(defun my-show-server-name ()
  (interactive)
  (message "Server Name: %s" server-name))

(defun my-show-init-times ()
  (interactive)
  (message "Emacs: %s | Doom: %ss" (my-emacs-init-time) doom-init-time))

(defun my-search-ag-brain ()
  (interactive)
  (counsel-ag nil org-brain-path "--heading --filename --follow --smart-case --org"))

(defun my-search-settings ()
  (interactive)
  (counsel-ag nil "~/.doom.d/" "-f -G '.org'"))

(defun my-search-doom-help ()
  (interactive)
  (counsel-ag nil "~/.emacs.d/" "-G '.org'"))

(defun my-search-doom-package-config ()
  (interactive)
  (counsel-ag nil "~/.emacs.d/.local/straight/repos" "-G '.el'"))

(defun my-widen-to-center-with-excursion ()
  (interactive)
  (widen)
  (recenter))

(defun my-search-packages ()
  (interactive)
  (my-widen-to-center-with-excursion)
  (counsel-ag  "(use-package\\! "  "~/.doom.d/" "-G '.org'"))

(defun my-buffer-name ()
  (interactive)
  (message (buffer-name)))

(defun my-swiper-python-classes ()
  (interactive)
  (swiper  "class "))

(defun my-swiper-python-functions ()
  (interactive)
  (swiper  "def "))

(defun my-search-python-classes ()
  (interactive)
  (counsel-ag  "^class "))

(defun my-search-python-function ()
  (interactive)
  (counsel-ag  "def "))

(defun ivy-with-thing-at-point (cmd)
  (let ((ivy-initial-inputs-alist
         (list
          (cons cmd (thing-at-point 'symbol)))))
    (funcall cmd)))

(defun my-goto-markdown ()
  (interactive)
  (find-file "~/.doom.d/.tmp/md.md"))

(defun my-goto-scratch-buffer ()
  (interactive)
  (switch-to-buffer "*scratch*"))

(defun my-goto-elisp-src-buffer ()
  (interactive)
  (switch-to-buffer "*Org Src config.org[ emacs-lisp ]*"))

(defun my-goto-python-scratch ()
  (interactive)
  (find-file "~/.doom.d/.tmp/py.py"))

(defun my-goto-my-packages ()
  (interactive)
  (find-file "~/.doom.d/ml/my-packages.el")
  (my-recenter-window)
  (message nil))

(defun my-goto-agenda ()
  (interactive)
  (find-file org-agenda-file))

(defun my-goto-messages-buffer ()
  (interactive)
  (switch-to-buffer "*Messages*"))

(defun my-goto-brain-game ()
  (interactive)
  (org-brain-visualize "game"))

(defun my-last-buffer ()
  (interactive)
  (switch-to-buffer nil))

(defun my-append-to-emacs-state ()
  (interactive)
  (evil-append 1)
  (evil-emacs-state))

(defun my-open-below-to-emacs-state ()
  (interactive)
  (evil-open-below 1)
  (evil-emacs-state))

(defun my-open-above-to-emacs-state ()
  (interactive)
  (evil-open-above 1)
  (evil-emacs-state))

(defun my-append-line-to-emacs-state ()
  (interactive)
  (evil-last-non-blank)
  (evil-emacs-state)
  (forward-char))

(defun my-kill-line-to-emacs-state ()
  (interactive)
  (kill-line)
  (evil-emacs-state))

(defun my-evil-sel-to-end ()
  (interactive)
  (evil-visual-char)
  (evil-last-non-blank))

(defun my-quiet-save-buffer ()
  (interactive)
  (let ((inhibit-message t))
    (evil-ex-nohighlight)
    (save-buffer)))

(defun my-quiet-save-some-buffers ()
  (interactive)
  (let ((inhibit-message t))
    (evil-ex-nohighlight)
    (save-some-buffers t 0)))

(defun my-save-some-buffers ()
  (interactive)
  (save-some-buffers t 0))

(defun my-indent-buffer ()
  (interactive)
  (let ((inhibit-message t))
    (evil-indent
     (point-min)
     (point-max))))

;; https://stackoverflow.com/a/30697761
(defun my-sort-lines-by-length (reverse beg end)
  "sort lines by length."
  (interactive "p\nr")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ;; to make `end-of-line' and etc. to ignore fields.
          ((inhibit-field-text-motion t))
        (sort-subr reverse 'forward-line 'end-of-line nil nil
                   (lambda (l1 l2)
                     (apply #'< (mapcar (lambda (range) (- (cdr range) (car range)))
                                        (list l1 l2)))))
        (reverse-region beg end)))))

(defun my-recenter-window ()
  (interactive)
  (recenter-top-bottom
   `(4)))

;; https://stackoverflow.com/a/998472
(defun my-dup-line (arg)
  (interactive "*p")
  (setq buffer-undo-list (cons (point) buffer-undo-list))
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion
      (end-of-line)
      (setq eol (point))
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        (while (> count 0)
          (newline)
          (insert line)
          (setq count (1- count))))
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list))))
  (evil-next-line 1))

;; https://stackoverflow.com/a/998472
(defun my-comm-dup-line (arg)
  (interactive "*p")
  (setq buffer-undo-list (cons (point) buffer-undo-list))
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion
      (end-of-line)
      (setq eol (point))
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        (while (> count 0)
          (newline)
          (insert line)
          (setq count (1- count))))
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list))))
  (save-excursion
    (comment-line 1))
  (backward-char 3)
  (evil-next-line 1))

(defun my-backward-paragraph-do-indentation ()
  (interactive)
  (evil-backward-paragraph 2)
  (forward-to-indentation 1))

(defun my-forward-paragraph-do-indentation ()
  (interactive)
  (evil-forward-paragraph 1)
  (forward-to-indentation 1))

(defun my-backward-kill-line (arg)
  "kill arg lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(defun my-bash-shebang ()
  (interactive)
  (erase-buffer)
  (insert "#!/usr/bin/env bash\n\n")
  (sh-mode)
  (sh-set-shell "bash")
  (xah-clean-empty-lines)
  (forward-to-indentation)
  (evil-insert-state))

(fset 'my-dup-par
      (kmacro-lambda-form [?y ?a ?p ?\} escape ?p] 0 "%d"))

(fset 'my-dup-inner-par
      (kmacro-lambda-form [?y ?i ?p ?\} escape ?p] 0 "%d"))

(defun my-eval-buffer ()
  (interactive)
  (eval-buffer)
  (let ((inhibit-message t))
    (save-some-buffers t))
  (message " buffer evaluated"))

(defun my-eval-buffer-quit ()
  (interactive)
  (eval-buffer)
  (let ((inhibit-message t))
    (save-some-buffers t)
    (quit-window)))

(defun my-eval-buffer-and-leave ()
  (interactive)
  (eval-buffer)
  (let ((inhibit-message t))
    (save-some-buffers t)
    (my-last-buffer)))

(defun my-eval-buffer-kill ()
  (interactive)
  (eval-buffer)
  (let ((inhibit-message t))
    (save-some-buffers t)
    (kill-current-buffer)))

(fset 'my-eval-paren-macro
      (kmacro-lambda-form [?v ?a ?\( ?g ?r] 0 "%d"))

(fset 'my-eval-paragraph-macro
      (kmacro-lambda-form [?v ?i ?p ?g ?r] 0 "%d"))

(defvar killed-file-list nil
  "List of recently killed files.")

(defun add-file-to-killed-file-list ()
  "If buffer is associated with a file name, add that file to the
`killed-file-list' when killing the buffer."
  (when buffer-file-name
    (push buffer-file-name killed-file-list)))

(add-hook 'kill-buffer-hook #'add-file-to-killed-file-list)

(defun my-reopen-killed-file ()
  "Reopen the most recently killed file, if one exists."
  (interactive)
  (when killed-file-list
    (find-file (pop killed-file-list))))

(defun my-widen-to-center ()
  (interactive)
  (save-excursion
    (widen)
    (recenter)))

(defun my-save-some-buffers ()
  (interactive)
  (save-some-buffers t 0))
(defun my-copy-directory ()
  (interactive)
  (message (kill-new (abbreviate-file-name default-directory))))

(defun my-buffer-predicate (buffer)
  (if (string-match "\*" (buffer-name buffer)) nil t))

(set-frame-parameter nil 'buffer-predicate 'my-buffer-predicate)

(setq frame-title-format '("%n"))

(defun my-silent-winner-undo ()
  (interactive)
  (cond
   ((not winner-mode) (error "Winner mode is turned off"))
   (t (unless (and (eq last-command 'winner-undo)
                   (eq winner-undo-frame (selected-frame)))
        (winner-save-conditionally)     ; current configuration->stack
        (setq winner-undo-frame (selected-frame))
        (setq winner-point-alist (winner-make-point-alist))
        (setq winner-pending-undo-ring (winner-ring (selected-frame)))
        (setq winner-undo-counter 0)
        (setq winner-undone-data (list (winner-win-data))))
      (cl-incf winner-undo-counter)	; starting at 1
      (when (and (winner-undo-this)
                 (not (window-minibuffer-p)))))))

(defun my-rename-file-and-buffer ()
  "rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "buffer is not visiting a file!")
      (let ((new-name (read-file-name "new name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defun my-delete-frame ()
  (interactive)
  (delete-frame nil t))

(defun my-brain-commands ()
  (interactive)
  (counsel-M-x "^org-brain- "))

(defun my-erase-kill-ring ()
  (interactive)
  (setq kill-ring nil))

(defun my-doom-kill-all-buffers (&optional buffer-list interactive)
  (interactive
   (list (if current-prefix-arg
             (doom-project-buffer-list)
           (doom-buffer-list))
         t))
  (if (null buffer-list)
      (message "No buffers to kill")
    (my-save-some-buffers)
    (delete-other-windows)
    (when (memq (current-buffer) buffer-list)
      (switch-to-buffer (doom-fallback-buffer)))
    (mapc #'kill-buffer buffer-list)
    (doom--message-or-count
     interactive "Killed %d buffers"
     (- (length buffer-list)
        (length (cl-remove-if-not #'buffer-live-p buffer-list))))))

(defun my-force-evil-mode ()
  (interactive)
  (evil-mode +1)
  (evil-force-normal-state))

(defun my-artbollocks-count-words (&optional start end)
  "Count the number of words between START and END."
  (interactive)
  (let* ((s (or start (point-min)))
         (e (or end (point-max)))
         (result
          (if (fboundp 'count-words)
              (count-words s e)
            (how-many "\\w+" s e))))
    (if (called-interactively-p 'any)
        (message "%s words" result))
    result))

(use-package! evil
  :demand t
  :init
  (add-hook! 'evil-insert-state-exit-hook #'expand-abbrev)
  :custom
  (evil-move-cursor-back nil)
  (evil-jumps-cross-buffers t)
  (evil-visualstar/persistent t)
  (+evil-want-o/O-to-continue-comments nil)
  :config
  (defun my-open-two-lines ()
    (interactive)
    (end-of-line)
    (newline-and-indent 2)
    (evil-insert-state))

  (evil-define-operator my-eval-region (beg end)
    "Evaluate selection or sends it to the open REPL, if available."
    :move-point nil
    (interactive "<r>")
    (eval-region beg end)
    (my-save-some-buffers)
    (message "region evaluated"))

  (add-hook 'evil-jumps-post-jump-hook 'my-recenter-window))

(use-package! evil-swap-keys
  :config
  (defun evil-swap-keys-swap-dash-underscore ()
    "Swap the underscore and the dash."
    (interactive)
    (evil-swap-keys-add-pair "-" "_")))

(use-package! org
  :init
  (remove-hook 'org-mode-hook 'flyspell-mode)
  (remove-hook 'org-cycle-hook 'org-optimize-window-after-visibility-change)
  ;; (add-hook 'org-cycle-hook 'org-cycle-hide-drawers)
  (add-hook 'org-agenda-mode-hook 'hl-line-mode)
  (add-hook 'org-mode-hook (lambda () (org-indent-mode t)))

  (add-hook! 'org-cycle-hook
             #'org-cycle-hide-archived-subtrees
             #'org-cycle-hide-drawers
             #'org-cycle-show-empty-lines)

  :general
  (:keymaps   '(evil-org-mode-map org-mode-map)
   "C-c j"   'org-metadown
   "C-c k"   'org-metaup
   "C-j" 'treemacs-select-window)
  (:keymaps   '(doom-leader-map)
   ;; "aa"        'org-agenda
   "at"        'org-today-agenda
   "a3"        'org-3-days-agenda
   "a7"        'org-7-days-agenda
   "a0"        'org-30-days-agenda)

  :custom
  (+org-capture-todo-file "Agenda/todo.org")
  (+org-capture-notes-file "Agenda/notes.org")
  (+org-capture-journal-file "Agenda/journal.org")
  (+org-capture-projects-file "Agenda/projects.org")
  (org-ellipsis ".")
  (org-log-into-drawer t)
  ;; (org-tab-follows-link 't)
  (org-timer-format "%s ")
  (org-return-follows-link t)
  (org-hide-emphasis-markers t)
  (org-footnote-auto-adjust t)
  (calendar-date-style 'european)
  (org-confirm-babel-evaluate nil)
  (org-show-notification-handler nil)
  (org-link-file-path-type 'relative)
  (org-html-htmlize-output-type 'css)
  (org-babel-no-eval-on-ctrl-c-ctrl-c t)
  (org-archive-location ".%s::datetree/")
  (org-outline-path-complete-in-steps nil)
  (org-enforce-todo-checkbox-dependencies t)
  (org-allow-promoting-top-level-subtree nil)
  (org-drawers (quote ("properties" "logbook")))
  (org-todo-keywords '((sequence "TODO(t)" "WORK(s!)" "REVW(r!)" "|" "DONE(d!)")))
  (org-id-link-to-org-use-id nil)
  (org-agenda-show-all-dates nil)
  (org-agenda-hide-tags-regexp ".")
  (org-tags-column 0)
  (org-agenda-show-outline-path nil)
  (org-agenda-skip-deadline-if-done t)
  (org-agenda-files '("~/org/Agenda"))
  (org-agenda-file "~/org/Agenda/agenda.org")
  (org-agenda-skip-archived-trees nil)
  (org-agenda-skip-timestamp-if-done t)
  (org-agenda-skip-scheduled-if-done t)
  (org-agenda-skip-unavailable-files 't)
  (org-agenda-show-future-repeats 'next)
  (org-agenda-skip-timestamp-if-deadline-is-shown t)
  (org-agenda-skip-additional-timestamps-same-entry 't)
  (org-clock-persist t)
  (org-clock-in-resume t)
  (org-clock-into-drawer t)
  (org-clock-persist-query-resume t)
  (org-clock-clocked-in-display nil)
  (org-clock-auto-clock-resolution nil)
  (org-clock-sound "~/Sounds/cuckoo.au")
  (org-clock-out-remove-zero-time-clocks t)
  (org-clock-report-include-clocking-task t)
  (org-edit-src-content-indentation 1)
  (org-edit-src-persistent-message nil)
  (org-edit-src-auto-save-idle-delay 0)
  (org-export-with-toc nil)
  (org-export-with-tags nil)
  (org-export-preserve-breaks t)
  (org-export-html-postamble nil)
  (org-export-with-broken-links t)
  (org-export-time-stamp-file nil)
  (org-export-with-todo-keywords nil)
  (org-export-with-archived-trees nil)
  (org-refile-use-outline-path 'file)
  (org-refile-allow-creating-parent-nodes nil)
  ;; (org-refile-targets '((projectile-project-buffers :maxlevel . 3)))
  (org-refile-targets nil)
  (org-src-fontify-natively nil)
  (org-src-tab-acts-natively nil)
  (org-src-preserve-indentation t)
  (org-src-window-setup 'current-window)
  (org-src-ask-before-returning-to-edit-buffer nil)

  (org-capture-templates
   '(("t" "Todo" entry
      (file+headline org-agenda-file "Inbox")
      "* TODO %^{Title} %i\n[%<%Y-%m-%d>]\n%?")

     ("n" "Notes" entry
      (file+headline org-agenda-file "Notes")
      "* %? %i\n[%<%Y-%m-%d>]" :prepend t)
     ("j" "Journal" entry
      (file+olp+datetree org-agenda-file)
      "* %? %i" :prepend t)))

  :config

  (advice-add 'org-edit-special :after #'my-indent-buffer)
  (advice-add 'org-edit-special :after #'my-recenter-window)
  (advice-add 'org-edit-src-exit :before #'my-indent-buffer)
  (advice-add 'org-edit-src-exit :after #'my-recenter-window)

  (load "/Users/davi/.doom.d/org_defun.el")
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines)))

(use-package! org-pomodoro
  :after org
  :config
  (setq org-pomodoro-offset 1
        org-pomodoro-start-sound-args t
        org-pomodoro-length (* 25 org-pomodoro-offset)
        org-pomodoro-short-break-length (/ org-pomodoro-length 5)
        org-pomodoro-long-break-length (* org-pomodoro-length 0.8)
        org-pomodoro-long-break-frequency 4
        org-pomodoro-ask-upon-killing nil
        org-pomodoro-manual-break t
        org-pomodoro-keep-killed-pomodoro-time t
        org-pomodoro-time-format "%.2m"
        org-pomodoro-short-break-format "short: %s"
        org-pomodoro-long-break-format "long: %s"
        org-pomodoro-format "p: %s"))

(use-package! ranger
  :demand t
  :init
  (setq ranger-deer-show-details nil)
  :custom
  (ranger-max-tabs 0)
  (ranger-minimal nil)
  (ranger-parent-depth 1)
  (ranger-footer-delay nil)
  (ranger-preview-file nil)
  (ranger-override-dired t)
  (ranger-persistent-sort t)
  (ranger-cleanup-eagerly t)
  (ranger-dont-show-binary t)
  (ranger-width-preview 0.65)
  (ranger-width-parents 0.12)
  (ranger-max-preview-size 0.5)
  (ranger-cleanup-on-disable t)
  (ranger-return-to-ranger nil)
  (ranger-max-parent-width 0.42)
  (ranger-excluded-extensions '("mkv" "iso"
                                "mp4" "bin"
                                "exe" "msi"
                                "pdf" "doc"
                                "docx"))

  :general
  (:keymaps     'ranger-mode-map
   "çm"         'dired-create-directory
   "r"          'ranger-refresh
   "<insert>"   'dired-create-empty-file
   "i"          'my-ranger-go
   "M-9"        'delete-other-windows
   "tp"         'move-file-to-trash
   "C-c 0"      'move-file-to-trash
   "<escape>"   'ranger-close
   "m"          'my-ranger-toggle-mark-and-advance
   "gg"         'ranger-goto-top
   "zp"         'ranger-preview-toggle
   "çcm"        'dired-create-directory
   "C-c l"      'counsel-find-file
   "d"          'dired-do-flagged-delete
   "x"          'dired-do-flagged-delete
   "d"          'dired-flag-file-deletion
   "<c-return>" 'dired-do-find-marked-files)
  :config

  (advice-add 'dired-do-find-marked-files :after 'delete-other-windows)

  (defun my-ranger-olivetti ()
    (interactive)
    (setq-local olivetti-body-width '65)
    (olivetti-mode +1))

  (defun my-ranger-go (path)
    "Go subroutine"
    (interactive
     (list
      (read-char-choice
       "
    d: doom   n : downloads  s : scripts   D: dotfiles
    e: emacs  o : org        f: config     i: eclipse
    h: home   p: python      c: documents  q: quit
  > "
       '(?a ?d ?D ?e ?E ?h ?i ?n ?o ?p ?s ?f ?c ?m ?q))))
    (message nil)
    (let* ((c (char-to-string path))
           (new-path
            (cl-case (intern c)
              ('D "~/dotfiles")
              ('e "~/.emacs.d")
              ('E "~/.backup/.emacs.back/vanilla/2020_26_05/init.el")
              ('i "~/org/Creative/eclipse/pt")
              ('d "~/.doom.d")
              ('h "~")
              ('n "~/Downloads")
              ('o "~/org")
              ('p "~/Documents/Python")
              ('s "~/scripts")
              ('f "~/.config")
              ('c "~/Documents")
              ('q "quit")))
           (alt-option
            (cl-case (intern c)
              ;; Subdir Handlng
              ('j 'ranger-next-subdir)
              ('k 'ranger-prev-subdir)
              ;; Tab Handling
              ('n 'ranger-new-tab)
              ('T 'ranger-prev-tab)
              ('t 'ranger-next-tab)
              ('c 'ranger-close-tab)
              ('g 'ranger-goto-top))))
      (when (string-equal c "q")
        (keyboard-quit))
      (when (and new-path (file-directory-p new-path))
        (ranger-find-file new-path))
      (when (eq system-type 'windows-nt)
        (when (string-equal c "D")
          (ranger-show-drives)))
      (when alt-option
        (call-interactively alt-option))))

  (defun my-deer-goto-my-lisp ()
    (interactive)
    (deer "~/.doom.d/ml/"))

  (defun my-deer-goto-my-kdb ()
    (interactive)
    (deer "~/.doom.d/ml/kbd/"))

  '(lambda () (interactive)
     (find-file "~/.doom.d/ml/my-packages.el")
     (my-recenter-window)
     (message nil))

  (defun my-deer-goto-python ()
    (interactive)
    (deer "~/Documents/Python/"))

  (defun my-ranger-toggle-mark-and-advance ()
    (interactive)
    (ranger-toggle-mark)
    (ranger-next-file 1)))

(use-package! projectile
  :custom
  (projectile-track-known-projects-automatically nil)
  :config
  ;; PROJECTILE LEADER
  (map! :desc "Projectile Ag"           :leader "pg" #'counsel-projectile-ag
        :desc "Add to Treemacs"         :leader "pt" #'treemacs-add-and-display-current-project
        :desc "Add project"             :leader "pa" #'projectile-add-known-project
        :desc "Switch to buffer"        :leader "pb" #'projectile-switch-to-buffer
        :desc "Compile"                 :leader "pc" #'projectile-compile-project
        :desc "Repeat command"          :leader "pC" #'projectile-repeat-last-command
        :desc "Remove project"          :leader "pd" #'projectile-remove-known-project
        :desc "Discover"                :leader "pD" #'+default/discover-projects
        :desc "Edit .dir-locals"        :leader "pe" #'projectile-edit-dir-locals
        :desc "Find file"               :leader "pf" #'projectile-find-file
        :desc "Find file in other"      :leader "pF" #'doom/find-file-in-other-project
        :desc "Find file dwim"          :leader "pw" #'projectile-find-file-dwim
        :desc "Find file in dir"        :leader "py" #'projectile-find-file-in-directory
        :desc "Config project"          :leader "pg" #'projectile-configure-project
        :desc "Invalidate cache"        :leader "pi" #'projectile-invalidate-cache
        :desc "Kill buffers"            :leader "pk" #'projectile-kill-buffers
        :desc "Find other file"         :leader "po" #'projectile-find-other-file
        :desc "Switch project"          :leader "pp" #'projectile-switch-project
        :desc "Recent Files"            :leader "pr" #'projectile-recentf
        :desc "Replace"                 :leader "pR" #'projectile-replace
        :desc "Run project"             :leader "pu" #'projectile-run-project
        :desc "Save buffers"            :leader "ps" #'projectile-save-project-buffers
        :desc "Browse project"          :leader "pB" #'+default/browse-project
        :desc "Test project"            :leader "pT" nil
        :desc "Browse other"            :leader "p>" nil
        :desc "Run cmd in root"         :leader "p!" nil
        :desc "Scratch buffer"          :leader "px" nil
        :desc "Switch to scratch"       :leader "pX" nil
        :desc "Browse project"          :leader "p." nil))

(use-package! super-save
  :after-call after-find-file
  :custom
  (auto-save-default nil)
  (super-save-idle-duration 5)
  (super-save-auto-save-when-idle nil)
  (super-save-triggers
   '(quickrun
     quit-window
     eval-buffer
     my-last-buffer
     windmove-up
     windmove-down
     windmove-left
     windmove-right
     switch-to-buffer
     org-edit-src-exit
     org-edit-special
     delete-window
     projectile-next-project-buffer
     projectile-previous-project-buffer
     eyebrowse-close-window-config
     eyebrowse-create-window-config
     eyebrowse-prev-window-config))

  :config

  (defun super-save-command ()
    "Save the current buffer if needed."
    (when (and buffer-file-name
               (buffer-modified-p (current-buffer))
               (file-writable-p buffer-file-name)
               (if (file-remote-p buffer-file-name) super-save-remote-files t)
               (super-save-include-p buffer-file-name))
      (let ((inhibit-message t))
        (save-buffer))))

  (super-save-mode t))

(use-package! git-auto-commit-mode
  :custom
  (gac-debounce-interval (* 30 60))
  :config

  (defun gac-commit (buffer)
    "Commit the current buffer's file to git."
    (let ((inhibit-message t))
      (let* ((buffer-file (buffer-file-name buffer))
             (filename (convert-standard-filename
                        (file-name-nondirectory buffer-file)))
             (commit-msg (gac--commit-msg buffer-file))
             (default-directory (file-name-directory buffer-file)))
        (shell-command
         (concat "git add " gac-add-additional-flag " " (shell-quote-argument filename)
                 gac-shell-and
                 "git commit -m " (shell-quote-argument commit-msg)))))))

(use-package! avy

  :general
  (:states '(normal)
   "g9"      'my-avy-goto-open-paren
   "g0"      'my-avy-goto-close-paren
   ","       'avy-goto-subword-1
   "F"       'evil-avy-goto-char-2-above
   "f"       'evil-avy-goto-char-2-below)

  :custom
  (avy-case-fold-search 't)
  (avy-style 'at-full)
  (avy-timeout-seconds 0.3)
  (avy-highlight-first t)
  (avy-single-candidate-jump t)
  :custom-face
  (avy-background-face((t (:foreground "LightSkyBlue3"))))
  :config

  (add-to-list 'avy-orders-alist '(my-avy-goto-parens . avy-order-closest))

  (defun my-avy-goto-open-paren ()
    (interactive)
    (let ((avy-command this-command))   ; for look up in avy-orders-alist
      (avy-jump "(+")))

  (defun my-avy-goto-close-paren ()
    (interactive)
    (let ((avy-command this-command))   ; for look up in avy-orders-alist
      (avy-jump ")+")))
  (setq! avy-keys (nconc (number-sequence ?a ?z)
                         (number-sequence ?0 ?9))))

(use-package! ispell
  :custom
  (ispell-quietly t)

  :config

  ;; https://stackoverflow.com/a/19186801

  (defvar limit-ispell-choices-to 5
    "Number indicating the maximum number of choices to present")

  (setq! limit-ispell-choices-to 20)

  (defadvice ispell-parse-output (after limit-ispell-choices activate)
    (when (and (listp ad-return-value)
               ad-return-value)
      (let* ((miss-list-end (nthcdr (- limit-ispell-choices-to 1)
                                    (nth 2 ad-return-value)))
             (guess-list-end (nthcdr (- limit-ispell-choices-to 1)
                                     (nth 3 ad-return-value))))
        (when miss-list-end (setcdr miss-list-end nil))
        (when guess-list-end (setcdr guess-list-end nil)))))

  ;; DON'T SPELLCHECK ORG BLOCKS
  (pushnew! ispell-skip-region-alist
            '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:")
            '("#\\+BEGIN_SRC" . "#\\+END_SRC")
            '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))

  ;; SAVE CORRECTIONS TO ABBREV
  (defun endless/simple-get-word ()
    (car-safe (save-excursion (ispell-get-word nil))))

  (defun endless/ispell-word-then-abbrev (p)
    "call `ispell-word', then create an abbrev for it.
      with prefix p, create local abbrev. otherwise it will
      be global.
      if there's nothing wrong with the word at point, keep
      looking for a typo until the beginning of buffer. you can
      skip typos you don't want to fix with `spc', and you can
      abort completely with `c-g'."
    (interactive "p")
    (let (bef aft)
      (save-excursion
        (while (if (setq bef (endless/simple-get-word))
                   ;; word was corrected or used quit.
                   (if (ispell-word nil 'quiet)
                       nil ; end the loop.
                     ;; also end if we reach `bob'.
                     (not (bobp)))
                 ;; if there's no word at point, keep looking
                 ;; until `bob'.
                 (not (bobp)))
          (backward-word)
          (backward-char))
        (setq aft (endless/simple-get-word)))
      (if (and aft bef (not (equal aft bef)))
          (let ((aft (downcase aft))
                (bef (downcase bef)))
            (define-abbrev
              (if p local-abbrev-table global-abbrev-table)
              bef aft)
            (message "\"%s\" now expands to \"%s\" %sally"
                     bef aft (if p "loc" "glob")))
        (user-error "no typo at or before point")))))

(use-package! pdf-view
  :init

  (add-hook 'pdf-outline-buffer-mode-hook (lambda () (toggle-truncate-lines +1)))

  :general

  (:keymaps   'pdf-view-mode-map
   :states '(normal visual)
   "H"        'pdf-history-backward
   "L"        'pdf-history-forward
   "C-s"      'pdf-occur
   "<escape>" 'ignore
   "TAB"      'pdf-outline
   "o"      'pdf-outline
   "q"        'quit-window
   "w"        'pdf-view-fit-width-to-window
   "h"        'pdf-view-scroll-up-or-next-page
   "l"        'pdf-view-scroll-down-or-previous-page
   "j"        'pdf-view-next-page
   "k"        'pdf-view-previous-page
   "p"        'pdf-view-previous-line-or-previous-page
   "n"        'pdf-view-next-line-or-next-page
   "K"        'pdf-view-previous-line-or-previous-page
   "J"        'pdf-view-next-line-or-next-page
   "C-l"      'my-show-pdf-view-commands)

  (:keymaps   'pdf-outline-buffer-mode-map
   :states '(normal visual)
   "<escape>"  'quit-window)

  :custom

  (pdf-view-continuous t)
  (pdf-view-resize-factor 1.15)
  (pdf-misc-size-indication-minor-mode t)

  :config

  (defun my-show-pdf-view-commands ()
    (interactive)
    (counsel-M-x "^pdf-view- ")))

(use-package! text-mode
  :init
  (add-hook! 'text-mode-hook 'my-text-mode-hooks)
  (remove-hook 'text-mode-hook 'hl-line-mode)

  :config
  (defun my-text-mode-hooks ()
    (electric-operator-mode +1)
    (abbrev-mode +1)
    (auto-capitalize-mode +1))

  (defun my-prose-enable-br ()
    (interactive)
    (auto-capitalize-mode +1)
    (electric-operator-mode +1)
    (hl-sentence-mode +1)
    (olivetti-mode +1)
    (typo-mode +1)
    (writegood-mode -1)
    (ispell-change-dictionary "brasileiro")
    (flyspell-mode +1)
    (flyspell-buffer)
    (message "prose br"))

  (defun my-prose-enable-en ()
    (interactive)
    (auto-capitalize-mode +1)
    (electric-operator-mode +1)
    (hl-sentence-mode +1)
    (olivetti-mode +1)
    (typo-mode +1)
    (artbollocks-mode +1)
    (ispell-change-dictionary "english")
    (flyspell-mode +1)
    (flyspell-buffer)
    (message "prose en"))

  (defun my-prose-disable ()
    (interactive)
    (auto-capitalize-mode -1)
    (electric-operator-mode -1)
    (hl-sentence-mode +1)
    (olivetti-mode -1)
    (typo-mode -1)
    (artbollocks-mode -1)
    (flyspell-mode -1)
    (message "prose disabled")))

(use-package! hl-sentence
  :config
  (custom-set-faces
   '(hl-sentence ((t (:inherit hl-line))))))

(use-package! wordnut
  :init
  (add-hook! 'wordnut-mode-hook 'hide-mode-line-mode)
  :general
  (:keymaps '(doom-leader-map)
   "sW"  'wordnut-search
   "sw"  'wordnut-lookup-current-word)
  (:keymaps '(wordnut-mode-map)
   :states '(normal visual)
   "q" 'quit-window
   "Q" 'kill-this-buffer
   :states '(normal)
   "<escape>" 'quit-window))

(use-package! osx-dictionary
  :init
  (add-hook! 'osx-dictionary-mode-hook 'hide-mode-line-mode)
  :general
  (:keymaps '(osx-dictionary-mode-map)
   :states  '(normal)
   "<escape>" 'quit-window
   "q" 'quit-window))

(use-package! typo
  :config

  (define-typo-cycle typo-cycle-right-single-quotation-mark
    "Cycle through the right quotation mark and the typewriter apostrophe."
    ( "'" "’"))

  (define-typo-cycle typo-cycle-dashes
    "Cycle through various dashes."
    ("-"   ; hyphen-minus
     "—"   ; em dash
     "−"   ; minus sign
     "‐"   ; hyphen
     "–"   ; en dash
     "‑"   ; non-breaking hyphen
     )))

(use-package! google-translate
  :custom
  (google-translate-pop-up-buffer-set-focus t)
  (google-translate-default-source-language "pt")
  (google-translate-default-target-language "en")
  (google-translate-translation-directions-alist '(("pt" . "en") ("en" . "pt"))))

(use-package! markdown-mode
  :init
  (add-hook! 'markdown-mode-hook #'abbrev-mode #'typo-mode)
  :custom
  (markdown-hide-urls 't)
  (markdown-hide-markup nil)
  (markdown-enable-wiki-links t)
  :general
  (:keymaps     '(markdown-mode-map evil-markdown-mode-map)
   :states      '(insert)
   "<tab>"      'tab-to-tab-stop
   "C-h"        'markdown-outdent-or-delete
   :states      '(visual)
   "<insert>" 'markdown-insert-link
   :states      '(normal visual insert global)
   "M--"        'winner-undo
   "M-="        'winner-redo
   "<C-return>" 'my-open-two-lines
   "M-n"        'my-forward-paragraph-do-indentation
   "M-p"        'my-backward-paragraph-do-indentation))

(use-package! pabbrev
  :custom
  (pabbrev-scavenge-some-chunk-size 120)
  (pabbrev-marker-distance-before-scavenge 1000)
  (pabbrev-idle-timer-verbose nil))

(use-package! fountain-mode
  :init
  (add-to-list 'auto-mode-alist '("\\ft\\'" . fountain-mode))
  (add-hook 'fountain-mode-hook (lambda () (+word-wrap-mode -1)))
  (add-hook! 'fountain-mode-hook
             #'auto-capitalize-mode
             #'electric-operator-mode
             #'olivetti-mode)
  :config
  (map! :after fountain-mode
        :map (fountain-mode-map)
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
        :nv "zm"   'fountain-outline-cycle-global))

(use-package! flyspell
  :custom
  (flyspell-delayed-commands nil)
  (flyspell-correct-auto-delay 0.2)
  (flyspell-delay 0.2))

(use-package! company
  :custom
  (company-ispell-available t)
  (company-show-numbers t)
  (company-idle-delay 0.3)
  (company-tooltip-limit 10)
  (company-minimum-prefix-length 2)
  (company-dabbrev-other-buffers t)
  (company-selection-wrap-around t)
  (company-auto-complete nil)
  (company-dabbrev-ignore-case 'keep-prefix)
  (company-global-modes '(not erc-mode
                              ;; text-mode
                              ;; org-mode
                              ;; markdown-mode
                              message-mode
                              help-mode
                              gud-mode
                              eshell-mode))

  :general
  (:keymaps                    '(company-active-map)
   "M-e"                       'my-company-yasnippet
   "C-y"                       'company-yasnippet
   "<return>"                  nil
   "C-m"                       'company-complete-selection
   "M-q"                       'company-complete-selection
   "M-w"                       'my-company-comp-with-paren
   "M-."                       'my-company-comp-with-dot
   "M-j"                       'my-company-comp-space
   "C-u"                       'my-backward-kill-line
   "C-h"                       'delete-backward-char
   "M-0"                       'company-complete-number
   "M-1"                       'company-complete-number
   "M-2"                       'company-complete-number
   "M-3"                       'company-complete-number
   "M-4"                       'company-complete-number
   "M-5"                       'company-complete-number
   "M-6"                       'company-complete-number
   "M-7"                       'company-complete-number
   "M-8"                       'company-complete-number
   "M-9"                       'company-complete-number)

  :config

  (defun my-company-yasnippet ()
    (interactive)
    (company-abort)
    (yas-expand))

  (defun my-company-comp-with-paren ()
    (interactive)
    (company-complete-selection)
    (insert "()")
    (backward-char))

  (defun my-company-comp-with-dot ()
    (interactive)
    (company-complete-selection)
    (insert ".")
    (company-complete))

  (defun my-company-comp-space ()
    (interactive)
    (company-complete-selection)
    (insert " ")))

(use-package! conf-mode
  :config
  :general
  (:keymaps   '(conf-mode-map)
   :states    '(normal)))

(use-package! elisp-mode
  :init
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  :general
  (:keymaps   '(lisp-interaction-mode-map)
   :states    '(normal)
   "<escape>" 'evil-ex-nohighlight))

(use-package! flycheck
  :custom
  (flycheck-global-modes '(not lisp-interaction-mode
                               emacs-lisp-mode)))

(use-package! eldoc
  :custom
  (eldoc-idle-delay 2)
  :config
  (global-eldoc-mode -1))

(use-package! doom-modeline
  :custom
  (doom-modeline-persp-icon t)
  (doom-modeline-persp-name t)
  (doom-modeline-display-default-persp-name t)
  (doom-modeline-vcs-max-length 12)
  (doom-modeline-env-version nil)
  (doom-modeline-env-enable-go nil)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-buffer-state-icon nil)
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-enable-word-count nil)
  (doom-modeline-env-enable-ruby nil)
  (doom-modeline-env-enable-perl nil)
  (doom-modeline-env-enable-rust nil)
  (doom-modeline-env-enable-python nil)
  (doom-modeline-lsp nil)
  (doom-modeline-env-enable-elixir nil)
  (doom-modeline-env-load-string ".")
  (doom-modeline-buffer-modification-icon nil)
  (doom-modeline-irc nil)
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-checker-simple-format t)
  (doom-modeline-bar-width 2)
  (doom-modeline-percent-position '(-3 "%p"))
  (doom-modeline-enable-word-count t)
  (doom-modeline-buffer-file-name-style 'buffer-name)
  :config
  (column-number-mode -1)
  (size-indication-mode -1))

(use-package! delight
  :after-call after-find-file
  :config
  (delight '((org-mode "[o]")
             (vimrc-mode "[vim]" "Vimrc")
             (scratch-fundamental-mode "[scf]" "scratch-fundamental")
             (org-brain-visualize-mode "[brain]" "Org-brain Visualize")
             (messages-buffer-mode "[msg]" "Messages")
             (scratch-lisp-mode "[scl]" "scratch-lisp")
             (fountain-mode "[foun]" "Fountain")
             (markdown-mode "[md]" "markdown")
             (sh-mode "" "Shell-script [bash]")
             (special-mode "[spe]" "special")
             (message-mode "[msg]" "messages")
             (fundamental-mode "[fun]" "fundamental")
             (python-mode "[py]" " python")
             (emacs-lisp-mode "[el]" "emacs-lisp")
             (lisp-interaction-mode "[lin]" "lisp interaction"))))

(use-package! which-key
  :custom
  (which-key-allow-evil-operators nil)
  (which-key-idle-delay 0.2)
  (which-key-idle-secondary-delay 0.1)
  :config
  (which-key-add-key-based-replacements

    "SPC bt" "Kill Matching Buffers"

    "SPC SPC tp" "Prose"
    "SPC SPC b" "Buffers"

    "SPC SPC r"   "Roam"

    "SPC SPC t"   "Text"

    "SPC SPC p"   "Programming"

    "SPC SPC s"   "Scratch"

    "SPC mwi"  "OW Insert"
    "SPC mwe"  "OW Archive"
    "SPC mwv"  "OW Attach"
    "SPC mwr"  "OW Read As Org"
    "SPC mwc"  "OW Links to Entries"

    "SPC SPC x"  "Org Capture")

  (which-key-mode +1))

(use-package! hydra
  :config

  (defhydra hydra-help (:color blue :hint nil :exit t :foreign-keys nil)
    "

    ^^Help
    ----------------------------------------
    _f_: callable  _k_: key       _i_: info
    _v_: variable  _l_: key long
    _e_: package   _w_: where is
    _p_: at point  _a_: apropos
    _m_: major     _d_: docs
    _o_: modes     _c_: command
   "

    ("<escape>" nil)
    ("C-h" helpful-variable)
    ("C-f" helpful-callable)

    ("f" helpful-callable)
    ("F" helpful-function)
    ("e" describe-package)
    ("v" helpful-variable)
    ("p" helpful-at-point)
    ("m" my-show-major-mode)
    ("o" describe-mode)

    ("k" describe-key-briefly)
    ("l" helpful-key)

    ("w" where-is)

    ("a" counsel-apropos)
    ("c" helpful-command)
    ("d" apropos-documentation)
    ("i" info))

  (defhydra hydra-window (:color pink :hint nil :exit nil :foreign-keys nil)
    "

  _H_: -w  _h_: sp ←  _b_: bal
  _J_: +h  _j_: sp ↓
  _K_: -h  _k_: sp ↑
  _L_: +w  _l_: sp →

"
    ("<escape>" nil)
    ("L" evil-window-increase-width)
    ("H" evil-window-decrease-width)
    ("J" evil-window-decrease-height)
    ("K" evil-window-increase-height)
    ("h" +evil-window-vsplit-a :exit t)
    ("j" my-window-split-below :exit t)
    ("k" +evil-window-split-a  :exit t)
    ("l" my-window-split-right :exit t)
    ("b" balance-windows :exit t))

  (defun my-window-split-right ()
    (interactive)
    (+evil-window-vsplit-a)
    (other-window 1))

  (defun my-window-split-below ()
    (interactive)
    (+evil-window-split-a)
    (other-window 1))

  (defhydra hydra-python-mode (:color blue :hint nil :foreign-keys run)
    "

    _Ç_: go def   _a_: ag         _p_: scratch
    _ç_: go dumb  _s_: swiper     _s_: quickshell
    _l_: go back  _f_: flycheck
    _k_: look
"

    ("<escape>" nil)
    ("q" nil)

    ("Ç" elpy-goto-definition)
    ("ç" dumb-jump-go)
    ("<return>" elpy-goto-definition)
    ("l" dumb-jump-back)
    ("k" dumb-jump-quick-look)
    ;; ("l" better-jumper-jump-backward)

    ("a" hydra-python-ag/body)
    ("s" hydra-python-swiper/body)
    ("f" hydra-flycheck/body)

    ("p" my-goto-python-scratch)

    ("s" quickrun-shell))

  (defhydra hydra-python-ag (:color blue :hint nil :foreign-keys run)

    "
    Python Ag
    -----------------
    _g_: ag at point
    _c_: ag classes
    _f_: ag functions"

    ("<escape>" hydra-python-mode/body)
    ("q" nil)

    ("g" counsel-ag-thing-at-point)
    ("c" my-search-python-classes)
    ("f" my-search-python-function))

  (defhydra hydra-python-swiper (:color blue :hint nil :foreign-keys run)

    "

    Python Swiper
    ^---------------------
    _s_: swiper at point
    _c_: swiper classes
    _f_: swiper functions"

    ("<escape>" hydra-python-mode/body)
    ("q" nil)

    ("s" swiper-thing-at-point)
    ("c" my-swiper-python-classes)
    ("f" my-swiper-python-functions))

  (defhydra hydra-flycheck (:color blue :hint nil :foreign-keys run)

    "

    Flycheck
    ^^----------------
    _f_: first error
    _c_: clear errors
    _s_: show error"

    ("<escape>" hydra-python-mode/body)
    ("q" nil)

    ("f" flycheck-first-error)
    ("c" flycheck-clear)
    ("s" flycheck-display-error-at-point))

  (defhydra hydra-org-clock (:color blue :hint nil :exit nil :foreign-keys nil)
    "

    _i_: in      _d_: done  _p_: pomo
    _o_: out     _l_: last  _t_: todo
    _c_: cancel  _g_: goto
    _s_: start   _h_: show"

    ("q" nil)
    ("<escape>" nil)

    ("i" org-clock-in)
    ("o" org-clock-out)
    ("c" org-clock-cancel)
    ("s" my-org-started-with-clock)

    ("d" my-org-todo-done)
    ("l" org-clock-in-last)
    ("g" org-clock-goto)
    ("h" org-clock-display)

    ("t" my-org-todo)
    ("p" hydra-org-pomodoro/body))

  (defhydra hydra-org-pomodoro (:color blue :hint nil :exit nil :foreign-keys nil)
    ("q" nil)
    ("<escape>" nil)

    ("s" my-org-started-with-pomodoro "task + pomo")
    ("g" my-org-goto-clock-and-start-pomodoro "goto + start")
    ("d" my-org-todo-done-pomodoro "done all")
    ("p" org-pomodoro "pomo"))

  (defhydra hydra-org-mode (:color blue :hint nil :exit nil :foreign-keys nil)
    ("<escape>" nil)
    ("q" nil)

    ("a" org-archive-subtree-default "archive")
    ("p" org-capture-goto-last-stored "last capt.")
    ("d" org-deadline "deadline")
    ("l" org-store-link "link")
    ("g" counsel-org-tag "tags")
    ("t" org-todo "todos")
    ("b" org2blog--hydra-main/body "blogging"))

  (defhydra hydra-yasnippet (:color blue :hint nil :exit nil :foreign-keys nil)
    "
^
    ^Yasnippet^
    ^^^^--------------------
    _n_: new     _l_: load
    _v_: visit   _c_: commit
    _r_: reload

"

    ("n" yas-new-snippet)
    ("v" yas-visit-snippet-file)
    ("r" yas-reload-all)

    ("l" yas-load-snippet-buffer)
    ("c" yas-load-snippet-buffer-and-close))

  (defhydra hydra-cool-moves (:color amaranth :hint nil)
    "
^
    ^Cool Moves^
    ^^^----------------------
    _w_: word  _p_: paragraph
    _c_: char  _s_: setence
    _l_: line
"
    ("q" nil)
    ("gh" nil)
    ("<escape>" nil)

    ("W" cool-moves-word-backwards)
    ("w" cool-moves-word-forward)

    ("C" cool-moves-character-backward)
    ("c" cool-moves-character-forward)

    ("L" cool-moves-line-backward)
    ("l" cool-moves-line-forward)

    ("P" cool-moves-paragraph-backward)
    ("p" cool-moves-paragraph-forward)

    ("S" cool-moves-sentence-backward)
    ("s" cool-moves-sentence-forward)))

(use-package! ivy
  :custom
  (ivy-height 15)
  (counsel-grep-swiper-limit 300000)
  (ivy-extra-directories nil)
  (counsel-outline-display-style 'title)
  (counsel-find-file-at-point t)
  (counsel-bookmark-avoid-dired t)
  (ivy-count-format "")

  (ivy-ignore-buffers '("^#.*#$"
                        "^\\*.*\\*"
                        "^agenda.org$"
                        "magit"
                        "*org-src-fontification.\\*"))

  ;; (counsel-ag-base-command "ag --filename --nocolor --nogroup --smart-case --skip-vcs-ignores --silent --ignore '*.elc' %s")

  :general
  (:states '(normal visual insert)
   "C-s" 'counsel-grep-or-swiper
   "M-y" 'counsel-yank-pop
   "C-," 'counsel-projectile-switch-to-buffer
   "C-<" 'ivy-switch-buffer
   "C-." 'counsel-M-x
   "M-u" 'yas-insert-snippet)

  (:keymaps 'doom-leader-map
   "sg"  'counsel-ag)
  (:keymaps 'counsel-describe-map
   "C-." 'ivy-next-line
   "C-," 'counsel-find-symbol)
  (:keymaps '(ivy-minibuffer-map ivy-switch-buffer-map)
   "M-y"      'ivy-next-line
   "M-r"      'ivy-next-line
   "C-,"      'ivy-next-line
   "C-."      'ivy-next-line
   "C-/"      'ivy-next-line
   "C-j"      'ivy-immediate-done
   "M-q"      'ivy-done
   "C-k"      'kill-line
   "C-d"      'delete-char
   "C-h"      'delete-backward-char
   "C-w"      'backward-kill-word
   "<insert>" 'yank)

  :config

  ;; https://github.com/abo-abo/swiper/issues/2588#issuecomment-637042732
  (setq swiper-use-visual-line-p #'ignore)

  (defun counsel-ag-thing-at-point ()
    (interactive)
    (ivy-with-thing-at-point 'counsel-ag)))

(use-package! eyebrowse
  :custom
  (eyebrowse-wrap-around t)
  (eyebrowse-new-workspace t)
  (eyebrowse-mode-line-style 'smart)
  (eyebrowse-switch-back-and-forth t)
  (eyebrowse-mode-line-left-delimiter " [ ")
  (eyebrowse-mode-line-right-delimiter " ]  ")
  (eyebrowse-mode-line-separator " | ")
  :config
  (map! "M-q" 'eyebrowse-prev-window-config
        "M-w" 'eyebrowse-next-window-config
        :desc "1"                :leader "1"     'eyebrowse-switch-to-window-config-1
        :desc "2"                :leader "2"     'eyebrowse-switch-to-window-config-2
        :desc "3"                :leader "3"     'eyebrowse-switch-to-window-config-3
        :desc "4"                :leader "4"     'eyebrowse-switch-to-window-config-4
        :desc "New Workspace"    :leader "v"     'eyebrowse-create-window-config
        :desc "Rename Workspace" :leader "cr"    'eyebrowse-rename-window-config
        :desc "Close Workspace"  :leader "x"     'eyebrowse-close-window-config))

(use-package! avoid
  :after-call after-find-file
  :config
  (mouse-avoidance-mode 'banish))

(use-package! recursive-narrow
  :init
  (require 'recursive-narrow))

(use-package! engine-mode
  :config

  (defun engine/search-aurelio-ap ()
    (interactive)
    (engine/search-aurelio (current-word)))

  (defengine aurelio "https://www.dicio.com.br/%s")

  (defun engine/search-wikitionary-pt-ap ()
    (interactive)
    (engine/search-wikitionary-pt (current-word)))
  (defengine wikitionary-pt "https://pt.wiktionary.org/wiki/%s")

  (defun engine/free-dic-pt-ap ()
    (interactive)
    (engine/search-free-dic-pt (current-word)))
  (defengine free-dic-pt "https://pt.thefreedictionary.com/%s")

  (defun engine/search-dic-infor-ap ()
    (interactive)
    (engine/search-dic-infor (current-word)))
  (defengine dic-infor "https://www.dicionarioinformal.com.br/%s")

  (defun engine/search-dic-infor-sin-ap ()
    (interactive)
    (engine/search-dic-infor-sin (current-word)))
  (defengine dic-infor-sin "https://www.dicionarioinformal.com.br/sinonimos/%s")

  (defun my-engine-dic-infor-rimas-ap ()
    (interactive)
    (engine/search-dic-infor-rimas (current-word)))
  (defengine dic-infor-rimas "https://www.dicionarioinformal.com.br/rimas/%s")

  (defun my-engine-search-michaealis-ap ()
    (interactive)
    (engine/search-michaelis (current-word)))
  (defengine michaelis "https://michaelis.uol.com.br/moderno-portugues/busca/portugues-brasileiro/%s")

  (defun my-engine-rhymit-pt-ap ()
    (interactive)
    (engine/search-rhymit-pt (current-word)))
  (defengine rhymit-pt "https://www.rhymit.com/pt/palavras-que-rimam-com-%s?")

  (engine-mode t))

(use-package! prog-mode
  :init
  (remove-hook! 'prog-mode-hook 'display-line-numbers-mode 'highlight-numbers-mode)
  (add-hook! '(prog-mode-hook)
             #'electric-pair-local-mode
             #'hl-line-mode
             #'abbrev-mode)

  :general
  (:keymaps   '(prog-mode-map)
   :states    '(normal)
   "çç"        'dumb-jump-go
   "çb"        'dumb-jump-back
   "çl"        'dumb-jump-quick-look
   "çe"        'dumb-jump-go-prefer-external))

(use-package! recentf
  :custom
  (recentf-auto-cleanup 'mode)
  (recentf-max-saved-items 20)
  :config
  (add-to-list 'recentf-exclude "/\\.emacs\\.d/.local/straight/"))

(use-package! midnight
  :after-call after-find-file
  :custom
  (midnight-period (* 1 60 60))
  (clean-buffer-list-delay-general 1)
  (clean-buffer-list-delay-special 1800)
  (clean-buffer-list-kill-regexps '("\\`\\*Man " "^#.*#$" "^\\*.*\\*"))
  :config
  (midnight-mode +1))

(use-package! files
  :init
  (add-hook 'after-save-hook (lambda () (executable-make-buffer-file-executable-if-script-p))))
