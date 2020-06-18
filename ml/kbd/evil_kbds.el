;; INSERT STATE ;;
(map! :i "M-e"   'yas-expand
      :i "C-ç d" 'deft)

;; NORMAL STATE ;;
(map!

 ;; :n "gr"  'my-evil-sel-to-end
 :n "go"  'cool-moves-open-line-below
 :n "g,"  'goto-last-change
 :n "g;"  'goto-last-change-reverse
 :n "gO"  'cool-moves-open-line-above
 :n "gsP" 'cool-moves-paragraph-backward
 :n "gsp" 'cool-moves-paragraph-forward
 :n "TAB" '+fold/toggle
 :n "zi"  '+fold/open-all
 :n "Q"   'my-delete-frame
 :n "-"   'insert-char
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
