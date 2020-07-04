(map! :after eyebrowse
      :desc "1"               :leader "1"     'eyebrowse-switch-to-window-config-1
      :desc "2"               :leader "2"     'eyebrowse-switch-to-window-config-2
      :desc "3"               :leader "3"     'eyebrowse-switch-to-window-config-3
      :desc "4"               :leader "4"     'eyebrowse-switch-to-window-config-4
      :desc "New Workspace"   :leader "v"     'eyebrowse-create-window-config
      :desc "Close Workspace" :leader "x"     'eyebrowse-close-window-config)




;; PROJECTILE LEADER
(map! :desc "Projectile Ag"           :leader "pg" #'counsel-projectile-ag
      :desc "Add to Treemacs"         :leader "pA" #'treemacs-add-and-display-current-project
      :desc "Browse project"          :leader "p." #'+default/browse-project
      :desc "Browse other"            :leader "p>" #'doom/browse-in-other-project
      :desc "Run cmd in root"         :leader "p!" #'projectile-run-shell-command-in-root
      :desc "Add project"             :leader "pa" #'projectile-add-known-project
      :desc "Switch to buffer"        :leader "pb" #'projectile-switch-to-buffer
      :desc "Compile"                 :leader "pc" #'projectile-compile-project
      :desc "Repeat command"          :leader "pC" #'projectile-repeat-last-command
      :desc "Remove project"          :leader "pd" #'projectile-remove-known-project
      :desc "Discover"                :leader "pD" #'+default/discover-projects
      :desc "Edit .dir-locals"        :leader "pe" #'projectile-edit-dir-locals
      :desc "Find file"               :leader "pf" #'projectile-find-file
      :desc "Find file in other"      :leader "pF" #'doom/find-file-in-other-project
      :desc "Config project"          :leader "pg" #'projectile-configure-project
      :desc "Invalidate cache"        :leader "pi" #'projectile-invalidate-cache
      :desc "Kill buffers"            :leader "pk" #'projectile-kill-buffers
      :desc "Find other file"         :leader "po" #'projectile-find-other-file
      :desc "Switch project"          :leader "pp" #'projectile-switch-project
      :desc "Recent Files"            :leader "pr" #'projectile-recentf
      :desc "Run project"             :leader "pR" #'projectile-run-project
      :desc "Save buffers"            :leader "ps" #'projectile-save-project-buffers
      :desc "List todos"              :leader "pt" #'magit-todos-list
      :desc "Test project"            :leader "pT" #'projectile-test-project
      :desc "Scratch buffer"          :leader "px" #'doom/open-project-scratch-buffer
      :desc "Switch to scratch"       :leader "pX" #'doom/switch-to-project-scratch-buffer)
