;;; ~/.doom.d/my-lisp/my-hydras.el -*- lexical-binding: t; -*-

(defhydra hydra-help (:color blue :hint nil :exit t :foreign-keys nil)
  "

    ^^Help
    ----------------------------------------
    _f_: callable  _k_: key       _i_: info
    _v_: variable  _l_: key long
    _e_: package   _w_: where is
    _p_: at point  _a_: apropos
    _m_: major     _d_: docs
    _o_: modes     _c_: command
   "

  ("<escape>" nil)
  ("C-h" helpful-variable)
  ("C-f" helpful-callable)

  ("f" helpful-callable)
  ("F" helpful-function)
  ("e" describe-package)
  ("v" helpful-variable)
  ("p" helpful-at-point)
  ("m" my-show-major-mode)
  ("o" describe-mode)

  ("k" describe-key-briefly)
  ("l" helpful-key)

  ("w" where-is)

  ("a" counsel-apropos)
  ("c" helpful-command)
  ("d" apropos-documentation)
  ("i" info))

(defhydra hydra-window (:color pink :hint nil :exit nil :foreign-keys nil)
  ("<escape>" nil)
  ("L" evil-window-increase-width "+w")
  ("H" evil-window-decrease-width "+-w")
  ("J" evil-window-decrease-height "+h")
  ("K" evil-window-increase-height "-h")
  ("j" +evil-window-split-a "sp" :exit t)
  ("l" +evil-window-vsplit-a "vs" :exit t)
  ("b" balance-windows "bal" :exit t))

(defhydra hydra-python-mode (:color blue :hint nil :foreign-keys run)
  "
    ^
    ^Python^
    ^^^^^-------------------------------------------
    _r_: run term    _g_: goto dumb  _RET_: flycheck
    _s_: quickshell  _d_: goto def
    _P_: prev error  _a_: goto assig
    _n_: next error  _b_: go back

"
  ("<escape>" nil)
  ("q" nil)

  ("r" my-run-on-terminal)
  ("s" quickrun-shell)
  ("P" flymake-goto-prev-error)
  ("n" flymake-goto-next-error)
  ("a" elpy-goto-assignment)
  ("g" dumb-jump-go)
  ("d" elpy-goto-definition)
  ("b" pop-tag-mark)
  ("<C-return>" dumb-jump-back)
  ("RET" hydra-flycheck-mode/body))

(defhydra hydra-flycheck-mode (:color blue :hint nil :foreign-keys run)
  "
^
    ^Flycheck^
    ^^^--------------------------------------
    _a_: check buffer    _e_: error at point
    _b_: first error     _f_: clear errors
    _c_: previous error  _h_: flycheck mode

"
  ("q" nil)
  ("<escape>" nil)
  ("M-m" nil)
  ("RET" flycheck-list-errors)

  ("a" flycheck-buffer)
  ("b" flycheck-first-error)
  ("c" flycheck-previous-error)
  ("d" flycheck-next-error)
  ("e" flycheck-display-error-at-point)
  ("f" flycheck-clear)
  ("h" flycheck-mode))

(defhydra hydra-org-clock (:color blue :hint nil :exit nil :foreign-keys nil)
  "

    _i_: in      _d_: done  _p_: pomo
    _o_: out     _l_: last
    _c_: cancel  _g_: goto
    _s_: start   _h_: show"

  ("q" nil)
  ("<escape>" nil)

  ("i" org-clock-in)
  ("o" org-clock-out)
  ("c" org-clock-cancel)
  ("s" my-org-started-with-clock)

  ("d" my-org-todo-done)
  ("l" org-clock-in-last)
  ("g" org-clock-goto)
  ("h" org-clock-display)

  ("t" my-org-todo)
  ("p" hydra-org-pomodoro/body))

(defhydra hydra-org-pomodoro (:color blue :hint nil :exit nil :foreign-keys nil)
  ("q" nil)
  ("<escape>" nil)

  ("s" my-org-started-with-pomodoro "task + pomo")
  ("g" my-org-goto-clock-and-start-pomodoro "goto + start")
  ("d" my-org-todo-done-pomodoro "done all")
  ("p" org-pomodoro "pomo"))

(defhydra hydra-org-mode (:color blue :hint nil :exit nil :foreign-keys nil)
  ("<escape>" nil)
  ("q" nil)

  ("a" org-archive-subtree-default "archive")
  ("p" org-capture-goto-last-stored "last capt.")
  ("d" org-deadline "deadline")
  ("l" org-store-link "link")
  ("g" counsel-org-tag "tags")
  ("t" org-todo "todos"))
