;; FILES
(map! :desc "Brain Visualize"      :leader "fv" 'org-brain-visualize
      :desc "Cleanup Recent Files" :leader "fc" 'recentf-cleanup
      :desc "Copy Directory"       :leader "fY" 'my-copy-directory
      :desc "Goto Agenda"          :leader "fa" 'my-goto-agenda
      :desc "Goto Brain"           :leader "fB" 'my-goto-brain
      :desc "Goto Lisp"            :leader "fl" 'my-deer-goto-my-lisp
      :desc "Goto Main Brain"      :leader "fb" 'my-goto-brain-main
      :desc "Goto My Packages"     :leader "fp" 'my-goto-my-packages
      :desc "Locate"               :leader "fo" 'counsel-locate
      :desc "Org Capture"          :leader "fc" 'org-capture
      :desc "Recent Files"         :leader "F"  'counsel-recentf
      :desc "Recent Files"         :leader "fr" 'counsel-recentf
      :desc "Rename File"          :leader "fR" 'my-rename-file-and-buffer
      :desc "Reopen File"          :leader "T"  'my-reopen-killed-file
      :desc "Scratch Markdown"     :leader "fm" 'my-goto-markdown
      :desc "Search Keys"          :leader "fk" 'my-search-kbds
      :desc "Search Pkgs"          :leader "fp" 'my-search-packages
      :desc "Search Setts"         :leader "fs" 'my-search-settings
      :desc "Doom Dashboard"       :leader "fd" '+doom-dashboard/open)
