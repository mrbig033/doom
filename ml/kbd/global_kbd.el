;; GLOBALS

(map! "C-'"                       'org-cycle-agenda-files
      "M-/"                       'hippie-expand
      "C-x p"                     'check-parens
      "C-;"                       'helpful-at-point
      "M-RET"                     'my-indent-buffer
      "C-c B"                     'my-brain-commands
      "<f9>"                      'my-goto-brain-same-window
      "<f8>"                      'my-goto-brain
      "C-c v"                     'vlf
      "M-9"                       'delete-other-windows
      "M-0"                       'quit-window
      "M-n"                       'my-forward-paragraph-do-indentation
      "M-p"                       'my-backward-paragraph-do-indentation
      "C-c y"                     'kill-ring-save
      "C-c m"                     'define-mode-abbrev
      "C-c M"                     'define-global-abbrev
      "C-c u"                     'redraw-display
      "C-l"                       'recenter-top-bottom
      "M--"                       'winner-undo
      "M-="                       'winner-redo
      "C-c q"                     'quick-calc
      "C-c d"                     'ispell-change-dictionary
      "C-c o"                     'my-org-force-open-other-window
      "C-h M"                     'my-show-major-mode
      "C-c C-o"                   'org-open-at-point-global
      "C-c e"                     'my-force-evil-mode
      :desc "Caps Lock" "C-c SPC" 'caps-lock-mode
      :nvig "M-2"                 'evil-execute-macro
      :nvig "C-2"                 'evil-record-macro
      :nvg "C-h e"                'describe-package
      :nvg "C-h N"                'my-show-server-name)

(general-define-key
 :keymaps 'override
 :states  '(normal visual insert emacs)
 "M-k"    'windmove-up
 "M-j"    'windmove-down
 "M-h"    'windmove-left
 "M-l"    'windmove-right
 "C-j"    'treemacs-select-window
 "C-c b"  'org-brain-prefix-map
 "M-s"    'my-last-buffer
 "M-,"    'previous-buffer
 "M-."    'next-buffer
 "C-S-s"  'evil-switch-to-windows-last-buffer)

(general-define-key
 :keymaps 'override
 :states  '(normal visual)
 "L"      'projectile-next-project-buffer
 "H"      'projectile-previous-project-buffer)

(general-define-key
 :keymaps 'override
 :states  '(insert)
 "C-k"    'kill-line
 "C-d"    'delete-char
 "C-h"    'delete-backward-char
 "C-w"    'backward-kill-word
 )

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
