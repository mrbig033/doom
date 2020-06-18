;; GLOBALS
(map! "M--"   'winner-undo
      "M-'"   'winner-undo
      "M-="   'winner-redo
      "M-+"   'winner-redo
      "M-/"   'hippie-expand
      "C-x p" 'check-parens
      "C-;"   'helpful-at-point
      "M-RET" 'my-indent-buffer
      "C-9"   'evilnc-comment-or-uncomment-lines
      "C-c v" 'vlf
      "M-9"   'delete-other-windows
      "M-0"   'quit-window
      "M-n"   'my-forward-paragraph-do-indentation
      "M-p"   'my-backward-paragraph-do-indentation
      "M-]"   'evil-window-prev
      "M-["   'evil-window-next
      "M-k"   'windmove-up
      "M-j"   'windmove-down
      "M-h"   'windmove-left
      "M-l"   'windmove-right
      "C-c h" 'previous-buffer
      "C-c y" 'kill-ring-save
      "C-c l" 'next-buffer
      "C-c m" 'define-mode-abbrev
      "C-c M" 'define-global-abbrev
      "C-'"   'org-cycle-agenda-files
      "C-c r" 'my-show-org-roam-commands
      "C-c u" 'redraw-display
      "C-l"   'recenter-top-bottom
      "C-c d" 'ispell-change-dictionary
      "C-c o" 'my-org-force-open-other-window
      "C-h e" 'describe-package
      "C-h N" 'my-show-server-name
      "C-c t" 'git-timemachine
      "C-c -" 'insert-char
      "C-c i" 'emacs-init-time)