;; GLOBALS
(map! "M-/"   'hippie-expand
      "C-x p" 'check-parens
      "C-;"   'helpful-at-point
      "M-RET" 'my-indent-buffer
      "C-c v" 'vlf
      "M-9"   'delete-other-windows
      "M-0"   'quit-window
      "M-n"   'my-forward-paragraph-do-indentation
      "M-p"   'my-backward-paragraph-do-indentation
      "C-c h" 'previous-buffer
      "C-c y" 'kill-ring-save
      "C-c l" 'next-buffer
      "C-c m" 'define-mode-abbrev
      "C-c M" 'define-global-abbrev
      "C-'"   'org-cycle-agenda-files
      "C-c u" 'redraw-display
      "C-l"   'recenter-top-bottom
      "M--"   'winner-undo
      "M-="   'winner-redo
      "C-c q" 'quick-calc
      "C-c d" 'ispell-change-dictionary
      "C-c o" 'my-org-force-open-other-window
      "C-h e" 'describe-package
      "C-h N" 'my-show-server-name
      "C-c t" 'git-timemachine
      "C-c -" 'insert-char
      "C-c i" 'emacs-init-time)

(general-define-key
 :keymaps 'override
 :states '(normal visual insert)
 "M-k"    'windmove-up
 "M-j"    'windmove-down
 "M-h"    'windmove-left
 "M-l"    'windmove-right
 "C-j"    'treemacs-select-window
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
 "gr"       'my-evil-sel-to-end)

