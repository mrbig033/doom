(org-capture-templates
   '(("t" "Personal todo" entry
      (file+headline +org-capture-todo-file "Inbox")
      "* [ ] %? %i\nFrom: %f" :prepend t)

     ("n" "Personal notes" entry
      (file+headline +org-capture-notes-file "Inbox")
      "* %u %? %i \nFrom: %f" :prepend t)

     ("j" "Journal" entry
      (file+olp+datetree +org-capture-journal-file)
      "* %U %? %i \nFrom: %f" :prepend t)

     ("p" "Project Templates")

     ("pt" "Project - local todo" entry
      (file+headline +org-capture-project-todo-file "Inbox")
      "* TODO %? %i \nFrom: %f" :prepend t)

     ("pn" "Project - local notes" entry
      (file+headline +org-capture-project-notes-file "Inbox")
      "* %U %? %i \nFrom: %f" :prepend t)

     ("pc" "Project - local changelog" entry
      (file+headline +org-capture-project-changelog-file "Unreleased")
      "* %U %? %i \nFrom: %f" :prepend t)

     ("ot" "Project todo" entry #'+org-capture-central-project-todo-file
      "* TODO %? %i \nFrom: %f" :heading "Tasks" :prepend nil)

     ("on" "Project notes" entry #'+org-capture-central-project-notes-file
      "* %U %? %i \nFrom: %f" :heading "Notes" :prepend t)

     ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file
      "* %U %? %i \nFrom: %f" :heading "Changelog" :prepend t)

     ("o" "Central Project Templates")))
