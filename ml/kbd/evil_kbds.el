;; NORMAL STATE
(map! :after evil
      :desc "Ignore"          :n "C-z"         'ignore
      :desc "Match & Next"    :n "M-d"         'evil-multiedit-match-and-next
      :desc "Emacs State"     :n "C-c z"       'evil-emacs-state
      :desc "Back Word End"   :n "g3"          'evil-backward-word-end
      :desc "Forw Word End"   :n "g#"          'evil-forward-word-end
      :desc "Cool Open Below" :n "go"          'cool-moves-open-line-below
      :desc "Cool Open Above" :n "gO"          'cool-moves-open-line-above
      :desc "Cool Par Backw"  :n "gsP"         'cool-moves-paragraph-backward
      :desc "Cool Par Forw"   :n "gsp"         'cool-moves-paragraph-forward
      :desc "Cool Word Backw" :n "C-S-p"       'cool-moves-word-backwards
      :desc "Cool Word Forw"  :n "C-S-n"       'cool-moves-word-forward
      :desc "Fold Toggle"     :n "TAB"         '+fold/toggle)

;; INSERT STATE
(map! :after evil
      :desc "Del Backw"       :i "C-h"         'evil-delete-backward-char-and-join
      :desc "Yas Expand"      :i "M-e"         'yas-expand
      :desc "Kill Line"       :i "C-k"         'kill-line
      :desc "Previous Line"   :i "C-p"         'previous-line
      :desc "Next Line"       :i "C-n"         'next-line
      :desc "Kill Word"       :i "M-d"         'kill-word
      :desc "Deled Char Forw" :i "C-d"         'delete-char)

;; MULTIPLE STATES
(map! :after evil
      :desc "Force Normal State" :e "<escape>" 'evil-force-normal-state
      :desc "Capitalize Region"  :v "gt"       'capitalize-region
      :desc "Align Regexp"       :v "C-c a"    'align-regexp
      :desc "Windmove Up" :niv "M-k"           'windmove-up
      :desc "Windmove Down" :niv "M-j"         'windmove-down
      :desc "Windmove Left" :niv "M-h"         'windmove-left
      :desc "Windmove Right" :niv "M-l"        'windmove-right
      :desc "Last Buffer" :nvg "M-s"           'my-last-buffer
      ;; :desc "Previous Window" :nvg "M-]"    'evil-window-prev
      ;; :desc "Next Window" :nvg "M-["        'evil-window-next
      :desc "Cool Line Forw" :nvg "C-S-j"      'cool-moves-line-forward
      :desc "Cool Line Back" :nvg "C-S-k"      'cool-moves-line-backward
      :desc "Start of Visual Line" :nv "0"     'evil-beginning-of-visual-line
      :desc "Comment Line" :nvg "C-9"          'evilnc-comment-or-uncomment-lines
      :desc "End of Visual Line" :nv "ge"      'evil-end-of-visual-line
      :desc "Jump Backward" :nv "M-o"          'better-jumper-jump-backward
      :desc "Jump Forward" :nv "M-i"           'better-jumper-jump-forward

      )
