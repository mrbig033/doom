(define-key key-translation-map (kbd "C-0") (kbd "-"))
(define-key key-translation-map (kbd "-") (kbd "C-0"))
(define-key key-translation-map (kbd "s-8") (kbd"["))
(define-key key-translation-map (kbd "s-9") (kbd"]"))
(define-key key-translation-map (kbd "s-(") (kbd"{"))
(define-key key-translation-map (kbd "s-)") (kbd"}"))

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

      :n "z0"  'endless/ispell-word-then-abbrev
      :n "z="  'flyspell-correct-previous

      :vn "çd" 'deft

      )

;; VISUAL AND MIXED STATES ;;
(map! :v "C-c a"      'align-regexp
      :nv "M-o"       'better-jumper-jump-backward
      :nv "M-i"       'better-jumper-jump-forward
      :nv "C-h M"     'my-show-major-mode
      :nv ";"         'link-hint-open-link
      :nvg "C-S-j"    'cool-moves-line-forward
      :nvg "C-S-k"    'cool-moves-line-backward
      :nvg "C-S-n"    'cool-moves-word-forward
      :nvg "C-S-p"    'cool-moves-word-backwards
      )
;; GLOBALS
(map!

 "C-'"   'org-cycle-agenda-files
 "C-9"           'evilnc-comment-or-uncomment-lines
 "C-;"           'helpful-at-point
 "C-c -"         'insert-char
 "C-c M"         'define-global-abbrev
 "C-c a"         'my-goto-agenda
 "C-c d"         'ispell-change-dictionary
 "C-c h"         'previous-buffer
 "C-c i"         'emacs-init-time
 "C-c l"         'next-buffer
 "C-c m"         'define-mode-abbrev
 "C-c o"         'my-org-force-open-other-window
 "C-c t"         'git-timemachine
 "C-c u"         'redraw-display
 "C-c v"         'vlf
 "C-c y"         'kill-ring-save
 "C-h N"         'my-show-server-name
 "C-h e"         'describe-package
 "C-l"           'recenter-top-bottom
 "C-x p"         'check-parens
 "M-+"           'winner-redo
 "M--"           'winner-undo
 "M-/"           'hippie-expand
 "M-0"           'quit-window
 "M-9"           'delete-other-windows
 "M-="           'winner-redo
 "M-RET"         'my-indent-buffer
 "M-["           'evil-window-next
 "M-]"           'evil-window-prev
 "M-n"           'my-forward-paragraph-do-indentation
 "M-p"           'my-backward-paragraph-do-indentation
 )
;; LEADER KEY
(map! :leader "sw"    'wordnut-lookup-current-word
      :leader "sW"    'wordnut-search
      :leader "sg"    'counsel-ag
      :leader "l"     'link-hint-open-link
      :leader "br"    '+popup/raise
      :leader "mgx"   'org-capture-goto-last-stored
      :leader "z"     'org-capture
      :leader "ww"    'doom/window-maximize-vertically
      :leader "k"     'kill-current-buffer
      :leader "x"     'eyebrowse-close-window-config
      :leader "0"     'delete-window
      :leader "nn"    'recursive-narrow-or-widen-dwim
      :leader "nw"    'my-widen-to-center
      :leader "to"    'olivetti-mode
      :leader "cw"    'count-words
      :leader "hdS"   'my-search-doom-help
      :leader "SPC" nil
      :leader "k"     'kill-current-buffer
      :leader "SPC p" 'my-goto-my-packages
      :leader "SPC x" 'org-capture
      ;; TEXT ;;
      :leader "tT"    'my-reload-file
      :leader "tB"    'spelling-brasileiro
      :leader "tE"    'spelling-english
      :leader "td"    'my-dup-line
      :leader "te"    'hl-sentence-mode
      :leader "th"    'hl-line-mode
      :leader "tD"    'ispell-change-dictionary
      :leader "tc"    'xah-clean-empty-lines
      :leader "ti"    'my-dup-par
      :leader "tv"    'visible-mode
      :leader "tS"    'my-sort-lines-by-length
      :leader "ta"    'artbollocks-mode
      :leader "tg"    'writegood-mode
      :leader "tb"    'flyspell-buffer
      :leader "tl"    'langtool-check-buffer
      :leader "tL"    'langtool-check-done
      :leader "tt"    'google-translate-smooth-translate
      :leader "tC"    'company-mode
      :leader "oo"    'hydra-org-mode/body
      :leader "mm"    'lisp-interaction-mode

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
;; LOCAL KEYBINDINGS
(map! (:map pabbrev-mode-map
       :i "C-l" 'pabbrev-expand-maybe)

      (:map helpful-mode-map
       :nvig "C-r" 'helpful-update)

      (:map (minibuffer-local-map
             minibuffer-local-ns-map
             minibuffer-local-completion-map
             minibuffer-local-must-match-map
             minibuffer-local-isearch-map
             read-expression-map
             evil-ex-completion-map
             evil-ex-search-keymap)

       "C-y" 'kill-ring-save
       :nvig "<insert>" 'yank
       :nvig "C-k"      'kill-line
       :nvig "C-d"      'delete-char
       :nvig "C-h"      'delete-backward-char
       :nvig "C-w"      'backward-kill-word))
