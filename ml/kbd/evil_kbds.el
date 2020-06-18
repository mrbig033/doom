;; INSERT STATE ;;
(map! :i "C-h" 'evil-delete-backward-char-and-join
      :i "C-k" 'kill-line
      :i "C-p" 'previous-line
      :i "C-n" 'next-line
      :i "M-d" 'kill-word
      :i "C-d" 'delete-char
      :i "M-e" 'yas-expand
      :i "C-ç d" 'deft)

;; NORMAL STATE ;;
(map! :n "gr"  'my-evil-sel-to-end
      :n "go"  'cool-moves-open-line-below
      :n "g,"  'goto-last-change
      :n "g;"  'goto-last-change-reverse
      :n "C-k" 'evil-change-line
      :n "gO"  'cool-moves-open-line-above
      :n "gsP" 'cool-moves-paragraph-backward
      :n "gsp" 'cool-moves-paragraph-forward
      :n "TAB" '+fold/toggle
      :n "zi"  '+fold/open-all
      :n "ge"  'evil-end-of-visual-line
      :n "Q"   'my-delete-frame
      :n "0"   'evil-beginning-of-visual-line
      :n "g3"  'evil-backward-word-end
      :n "g#"  'evil-forward-word-end
      :n "-"   'insert-char
      :n "H"   'projectile-previous-project-buffer
      :n "L"   'projectile-next-project-buffer

      :n "z0"  'endless/ispell-word-then-abbrev
      :n "z="  'flyspell-correct-previous

      :vn "çd" 'deft

      )

;; VISUAL AND MIXED STATES ;;
(map! :v "C-c a"  'align-regexp
      :nv "M-o"   'better-jumper-jump-backward
      :nv "M-i"   'better-jumper-jump-forward
      :nv "C-h M" 'my-show-major-mode
      :nv ";"     'link-hint-open-link
      :nvg "C-S-j" 'cool-moves-line-forward
      :nvg "C-S-k" 'cool-moves-line-backward)
