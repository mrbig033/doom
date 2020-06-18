(defun sb/disable-all-themes ()
  (interactive)
  (mapc #'disable-theme custom-enabled-themes))

(defun sb/load-theme (theme)
  "Enhance `load-theme' by first disabling enabled themes."
  (sb/disable-all-themes)
  (load-theme theme))

(setq sb/hydra-selectors
      "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ")

(defun sb/sort-themes (themes)
  (sort themes
        (lambda (a b)
          (string<
           (symbol-name a)
           (symbol-name b)))))

(defun sb/hydra-load-theme-heads (themes)
  (mapcar* (lambda (a b)
             (list (char-to-string a)
                   `(sb/load-theme ',b)
                   (symbol-name b)))
           sb/hydra-selectors themes))

(bind-keys ("C-c w t" .
            (lambda ()
              (interactive)
              (call-interactively
               (eval `(defhydra sb/hydra-select-themes
                        (:hint nil :color pink)
                        "Select Theme"
                        ,@(sb/hydra-load-theme-heads
                           (sb/sort-themes
                            (custom-available-themes)))
                        ("DEL" (sb/disable-all-themes))
                        ("RET" nil "done" :color blue)))))))
