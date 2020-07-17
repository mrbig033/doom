(map! :map (org-mode-map
            evil-org-mode-map
            prog-mode-map
            text-mode-map
            special-mode-map)
      :n    "<backspace>" 'org-edit-special
      :n    "C-k"         'evil-change-line
      :n    "C-o"         'counsel-outline
      :n    "zi"          'org-show-all
      :n    "zm"          'my-org-hide-all-function
      :n    "gr"          'my-evil-sel-to-end
      :n    "gr"          'my-evil-sel-to-end
      :nv   "ge"          'end-of-visual-line
      :nv   "<insert>"    'org-insert-link
      :nvieg "C-c C-s"    'org-emphasize
      :nvieg "M-k"        'windmove-up
      :nvieg "M-j"        'windmove-down
      :nvieg "M-h"        'windmove-left
      :nvieg "M-l"        'windmove-right
      :nvieg "C-c j"      'org-metadown
      :nvieg "C-c k"      'org-metaup)

(map! :map (evil-org-mode-map org-mode-map)
      :localleader "gt" 'org-today-agenda
      :localleader "g3" 'org-3-days-agenda
      :localleader "g7" 'org-7-days-agenda
      :localleader "g0" 'org-30-days-agenda)

(general-unbind
  :keymaps 'org-src-mode-map
  :with 'org-edit-src-exit
  [remap org-edit-special])
