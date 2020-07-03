(map! :map (deft-mode-map)
      :e "<escape>" 'quit-window
      :e "C-u"      'deft-filter-clear
      :e "C-k"      'deft-filter-clear
      :e "C-h"      'deft-filter-decrement
      :e "C-w"      'deft-filter-decrement-word
      :e "C-r"      'deft-refresh-filter)
