;; GLOBALS
(map! "M-/"    'hippie-expand
      "C-x p"  'check-parens
      "C-;"    'helpful-at-point
      "M-RET"  'my-indent-buffer
      "C-c B"  'my-brain-commands
      "<f9>"    'my-goto-brain-same-window
      "<f8>"  'my-goto-brain
      "C-c v"  'vlf
      "M-9"    'delete-other-windows
      "M-0"    'quit-window
      "M-n"    'my-forward-paragraph-do-indentation
      "M-p"    'my-backward-paragraph-do-indentation
      "C-c y"  'kill-ring-save
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
      :nvg "C-h e"  'describe-package
      :nvg "C-h N"  'my-show-server-name
      "C-c i"  'emacs-init-time
      "C-c I"  'my-doom-init-time)

(general-define-key
 :keymaps 'override
 :states '(normal visual insert emacs)
 "M-k"    'windmove-up
 "M-j"    'windmove-down
 "M-h"    'windmove-left
 "M-l"    'windmove-right
 "M-,"    'bs-cycle-next
 "M-."    'bs-cycle-previous
 "C-j"    'treemacs-select-window
 "C-c b" 'org-brain-prefix-map
 "M-s"    'my-last-buffer
 "C-S-s"    'evil-switch-to-windows-last-buffer)

(general-define-key
 :keymaps 'override
 :states '(insert)
 "C-k"      'kill-line
 "C-d"      'delete-char
 "C-h"      'delete-backward-char
 "C-w"      'backward-kill-word)

(general-define-key
 :keymaps 'override
 :states '(visual)
 "gr"    'my-eval-region)

(general-define-key
 :keymaps  'override
 :states '(normal)
 "çc"       '+popup/close-all
 "zi"       '+fold/open-all
 "C-k"      'kill-line
 "gr"       'my-evil-sel-to-end)
