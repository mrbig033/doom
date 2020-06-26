;; GLOBALS
(map! "M-/"    'hippie-expand
      "C-x p"  'check-parens
      "C-;"    'helpful-at-point
      "M-RET"  'my-indent-buffer
      "C-c B"  'my-brain-commands
      "<M-f8>"   'my-goto-brain
      "<f8>" 'my-goto-brain-same-window
      "C-c v"  'vlf
      "M-9"    'delete-other-windows
      "M-0"    'quit-window
      "M-n"    'my-forward-paragraph-do-indentation
      "M-p"    'my-backward-paragraph-do-indentation
      "C-c h"  'previous-buffer
      "C-c y"  'kill-ring-save
      "C-c l"  'next-buffer
      "C-c m"  'define-mode-abbrev
      "C-c M"  'define-global-abbrev
      "C-'"    'org-cycle-agenda-files
      "C-c u"  'redraw-display
      "C-l"    'recenter-top-bottom
      "M--"    'winner-undo
      "M-="    'winner-redo
      "C-c q"  'quick-calc
      "C-c d"  'ispell-change-dictionary
      "C-c o"  'my-org-force-open-other-window
      "C-h e"  'describe-package
      "C-h N"  'my-show-server-name
      "C-c t"  'git-timemachine
      "C-c i"  'emacs-init-time
      "C-c I"  'my-doom-init-time)

(general-define-key
 :keymaps 'override
 :states '(normal visual insert emacs)
 "M-k"    'windmove-up
 "M-j"    'windmove-down
 "M-h"    'windmove-left
 "M-l"    'windmove-right
 "C-j"    'treemacs-select-window
 "C-c b" 'org-brain-prefix-map
 "M-s"    'my-last-buffer)

(general-define-key
 :keymaps 'override
 :states '(insert)
 "C-k"      'kill-line
 "C-d"      'delete-char
 "C-h"      'delete-backward-char
 "C-w"      'backward-kill-word)

(general-define-key
 :keymaps  'override
 :states '(normal)
 "zi"       '+fold/open-all
 "C-k"      'kill-line
 "gr"       'my-evil-sel-to-end)
