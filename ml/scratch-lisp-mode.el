;;; SCRATCH LISP MODE ;;;;
(define-derived-mode scratch-lisp-mode
  lisp-interaction-mode "scratch-lisp")
(general-unbind 'scratch-lisp-mode-map
  :with 'evil-ex-nohighlight
  [remap my-quiet-save-buffer]
  [remap save-buffer])

(general-unbind '(scratch-lisp-mode-map)
  :with 'evil-ex-nohighlight
  [remap my-quiet-save-buffer]
  [remap save-buffer])

(general-unbind '(scratch-lisp-mode-map)
  :with 'quit-window
  [remap kill-current-buffer])

(general-unbind '(scratch-lisp-mode-map)
  :with 'quit-window
  [remap my-goto-scratch-buffer]
  [remap doom/open-scratch-buffer])
