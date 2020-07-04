(use-package! evil
  :init
  (add-hook! 'evil-insert-state-exit-hook #'expand-abbrev)
  :custom
  (evil-move-cursor-back nil)
  (evil-jumps-cross-buffers t)
  (evil-visualstar/persistent t)
  (+evil-want-o/O-to-continue-comments nil)
  :config
  ;; NORMAL STATE
  (map! :after evil
        :desc "Evil Noh"            :n "<escape>" 'evil-ex-nohighlight
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
        :desc "Cool Moves"          :n "gh"       'hydra-cool-moves/body
        :desc "Evil Set Marker"     :n "gm"       'evil-set-marker
        :desc "Evil Goto Mark"      :n "'"        'evil-goto-mark
        :desc "Delete Char"         :n "x"        'delete-char
        :desc "Delete Char Backw"   :n "X"        'delete-backward-char
        :desc "Match & Next"        :n "M-d"      'evil-multiedit-match-and-next)

  ;; INSERT STATE
  (map! :after evil
        :desc "Del Backw"           :i "C-h" 'evil-delete-backward-char-and-join
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
  (map! :after evil
        :desc "Force Normal State"   :e "<escape>" 'evil-normal-state
        :desc "Kill Line Backwards"  :e "C-u"      'my-backward-kill-line
        :desc "Kill Word Backwards"  :e "C-w"      'backward-kill-word
        :desc "Yas Expand"           :e "M-e"      'yas-expand
        :desc "Kill Char Backwards"  :e "C-h"      'delete-backward-char)

  ;; MULTIPLE STATES
  (map! :after evil

        :desc "Align Regexp"         :v "C-c a"    'align-regexp
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

(use-package! evil-smartparens
  :config
  (general-unbind 'evil-smartparens-mode-map
    :with 'exchange-point-and-mark
    [remap evil-sp-override]))

(use-package! evil-swap-keys
  :config
  (defun evil-swap-keys-swap-dash-underscore ()
    "Swap the underscore and the dash."
    (interactive)
    (evil-swap-keys-add-pair "-" "_")))

(use-package! evil-god-state
  :after evil
  :general

  (:keymaps '(god-local-mode-map)
   :states  '(normal insert global)
   "."        'evil-god-state-bail
   "<escape>" 'evil-god-state-bail)

  (:keymaps '(evil-normal-state-map)
   "."        'evil-execute-in-god-state)

  :config

  (defun evil-swap-keys-swap-dash-underscore ()
    "Swap the underscore and the dash."
    (interactive)
    (evil-swap-keys-add-pair "-" "_")))

(after! evil
  (evil-better-visual-line-on))

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))
