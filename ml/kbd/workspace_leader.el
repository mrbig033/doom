;; WORKSPACE LEADER
(map! :leader "TAB `" nil
      :desc "Del Buffer"  :leader "TAB I"   'persp-remove-buffer
      :desc "Del Session" :leader "TAB x"   '+workspace/kill-session
      :desc "Del WS"      :leader "TAB d"   '+workspace/delete
      :desc "Display"     :leader "TAB TAB" '+workspace/display
      :desc "Last WS"     :leader "TAB l"   '+workspace/other
      :desc "Load WS"     :leader "TAB L"   '+workspace/load
      :desc "New WS"      :leader "TAB n"   '+workspace/new
      :desc "Next WS"     :leader "TAB ]"   '+workspace/switch-right
      :desc "Prev WS"     :leader "TAB ["   '+workspace/switch-left
      :desc "Rename WS"   :leader "TAB r"   '+workspace/rename
      :desc "Restore"     :leader "TAB R"   '+workspace/restore-last-session
      :desc "Save WS"     :leader "TAB s"   '+workspace/save
      :desc "Switch"      :leader "TAB ."   '+workspace/switch-to
      :desc "WS 0"        :leader "TAB 0"   '+workspace/switch-to-0
      :desc "WS 1"        :leader "TAB 1"   '+workspace/switch-to-1
      :desc "WS 2"        :leader "TAB 2"   '+workspace/switch-to-2
      :desc "WS 3"        :leader "TAB 3"   '+workspace/switch-to-3
      :desc "WS 4"        :leader "TAB 4"   '+workspace/switch-to-4
      :desc "WS 5"        :leader "TAB 5"   '+workspace/switch-to-5
      :desc "WS 6"        :leader "TAB 6"   '+workspace/switch-to-6
      :desc "WS 7"        :leader "TAB 7"   '+workspace/switch-to-7
      :desc "WS 8"        :leader "TAB 8"   '+workspace/switch-to-8
      :desc "WS 9"        :leader "TAB 9"   '+workspace/switch-to-9)