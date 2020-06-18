;; GLOBALS
(map!
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
      "C-c h" 'previous-buffer
      "C-c y" 'kill-ring-save
      "C-c l" 'next-buffer
      "C-c m" 'define-mode-abbrev
      "C-c M" 'define-global-abbrev
      "C-'"   'org-cycle-agenda-files
      "C-c u" 'redraw-display
      "C-c a" 'my-goto-agenda
      "C-l"   'recenter-top-bottom
      "s-2"   'evil-execute-macro
      "C-c d" 'ispell-change-dictionary
      "C-c o" 'my-org-force-open-other-window
      "C-h e" 'describe-package
      "C-h N" 'my-show-server-name
      "C-c t" 'git-timemachine
      "C-c -" 'insert-char
      "C-c i" 'emacs-init-time)

(map! :nvig "M-k"   'windmove-up
      :nvig "M-j"   'windmove-down
      :nvig "M-h"   'windmove-left
      :nvig "M-l"   'windmove-right)
