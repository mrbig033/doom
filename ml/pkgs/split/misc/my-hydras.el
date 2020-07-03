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

    _Ç_: go def   _a_: ag         _p_: scratch
    _ç_: go dumb  _s_: swiper     _s_: quickshell
    _l_: go back  _f_: flycheck
    _k_: look
"

  ("<escape>" nil)
  ("q" nil)

  ("Ç" elpy-goto-definition)
  ("ç" dumb-jump-go)
  ("<return>" elpy-goto-definition)
  ("l" dumb-jump-back)
  ("k" dumb-jump-quick-look)
  ;; ("l" better-jumper-jump-backward)

  ("a" hydra-python-ag/body)
  ("s" hydra-python-swiper/body)
  ("f" hydra-flycheck/body)

  ("p" my-goto-python-scratch)

  ("s" quickrun-shell))

(defhydra hydra-python-ag (:color blue :hint nil :foreign-keys run)

  "
    Python Ag
    -----------------
    _g_: ag at point
    _c_: ag classes
    _f_: ag functions"

  ("<escape>" hydra-python-mode/body)
  ("q" nil)

  ("g" counsel-ag-thing-at-point)
  ("c" my-search-python-classes)
  ("f" my-search-python-function))

(defhydra hydra-python-swiper (:color blue :hint nil :foreign-keys run)

  "

    Python Swiper
    ^---------------------
    _s_: swiper at point
    _c_: swiper classes
    _f_: swiper functions"

  ("<escape>" hydra-python-mode/body)
  ("q" nil)

  ("s" swiper-thing-at-point)
  ("c" my-swiper-python-classes)
  ("f" my-swiper-python-functions))

(defhydra hydra-flycheck (:color blue :hint nil :foreign-keys run)

  "

    Flycheck
    ^^----------------
    _f_: first error
    _c_: clear errors
    _s_: show error"

  ("<escape>" hydra-python-mode/body)
  ("q" nil)

  ("f" flycheck-first-error)
  ("c" flycheck-clear)
  ("s" flycheck-display-error-at-point))

(defhydra hydra-org-clock (:color blue :hint nil :exit nil :foreign-keys nil)
  "

    _i_: in      _d_: done  _p_: pomo
    _o_: out     _l_: last  _t_: todo
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
  ("t" org-todo "todos")
  ("b" org2blog--hydra-main/body "blogging"))

(defhydra hydra-yasnippet (:color blue :hint nil :exit nil :foreign-keys nil)
  "
^
    ^Yasnippet^
    ^^^^--------------------
    _n_: new    _l_: load
    _v_: visit  _c_: commit
    _r_: reload

"

  ("n" yas-new-snippet)
  ("v" yas-visit-snippet-file)
  ("r" yas-reload-all)

  ("l" yas-load-snippet-buffer)
  ("c" yas-load-snippet-buffer-and-close))

(defhydra hydra-cool-moves (:color amaranth :hint nil)
  "
^
    ^Cool Moves^
    ^^^----------------------
    _w_: word  _p_: paragraph
    _c_: char  _s_: setence
    _l_: line
"
  ("q" nil)
  ("gh" nil)
  ("<escape>" nil)

  ("W" cool-moves-word-backwards)
  ("w" cool-moves-word-forward)

  ("C" cool-moves-character-backward)
  ("c" cool-moves-character-forward)

  ("L" cool-moves-line-backward)
  ("l" cool-moves-line-forward)

  ("P" cool-moves-paragraph-backward)
  ("p" cool-moves-paragraph-forward)

  ("S" cool-moves-sentence-backward)
  ("s" cool-moves-sentence-forward))
