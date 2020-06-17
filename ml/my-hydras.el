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
"

  _H_: -w  _h_: sp ←  _b_: bal
  _J_: +h  _j_: sp ↓
  _K_: -h  _k_: sp ↑
  _L_: +w  _l_: sp →

"
  ("<escape>" nil)
  ("L" evil-window-increase-width)
  ("H" evil-window-decrease-width)
  ("J" evil-window-decrease-height)
  ("K" evil-window-increase-height)
  ("h" +evil-window-vsplit-a :exit t)
  ("j" my-window-split-below :exit t)
  ("k" +evil-window-split-a  :exit t)
  ("l" my-window-split-right :exit t)
  ("b" balance-windows :exit t))

(defun my-window-split-right ()
  (interactive)
  (+evil-window-vsplit-a)
  (other-window 1))

(defun my-window-split-below ()
  (interactive)
  (+evil-window-split-a)
  (other-window 1))

(defhydra hydra-python-mode (:color blue :hint nil :foreign-keys run)
  "

    _d_: goto def    _s_: quickshell     _c_: classes ag
    _a_: go at point _l_: clear errors   _f_: functions ager
    _g_: goto dumb   _C_: classes swiper
    _b_: go back     _F_: functions swip
"

  ("<escape>" nil)
  ("q" nil)

  ("d" elpy-goto-definition)
  ("ç" elpy-goto-definition)
  ("<return>" elpy-goto-definition)
  ("a" counsel-ag-thing-at-point)

  ("g" dumb-jump-go)
  ("b" better-jumper-jump-backward)
  ("C-ç" better-jumper-jump-backward)
  ("<C-return>" better-jumper-jump-backward)
  ("s" quickrun-shell)
  ("l" flycheck-clear)

  ("C" my-swiper-python-classes)
  ("F" my-swiper-python-functions)

  ("c" my-search-python-classes)
  ("f" my-search-python-function))

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