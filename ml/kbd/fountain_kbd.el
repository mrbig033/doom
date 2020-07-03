(map! :after fountain-mode
      :map (fountain-mode-map)
      :nvi "TAB" 'fountain-dwim
      :nv "C-;"  'fountain-upcase-line-and-newline
      :nv "c-n"  'fountain-forward-character
      :nv "c-p"  'fountain-backward-character
      :nv "gh"   'fountain-forward-scene
      :nv "gj"   'fountain-outline-next
      :nv "gk"   'fountain-outline-previous
      :nv "gl"   'fountain-backward-scene
      :nv "m-n"  'fountain-forward-scene
      :nv "m-p"  'fountain-backward-scene
      :nv "zi"   'fountain-outline-show-all
      :nv "zm"   'fountain-outline-cycle-global)
