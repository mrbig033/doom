;;;;;;;;;; INITIAL SETTINGS ;;;;;;;;;;

(setq user-full-name "mrbig"
      user-mail-address "mrbig033@protonmail.com"
      doom-font (font-spec :family "Input Mono" :size 20)
      doom-variable-pitch-font (font-spec :family "Input Mono") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "Input Mono" :size 20)
      doom-big-font (font-spec :family "Input Mono" :size 20)
      doom-theme 'doom-solarized-light
      org-directory "~/org/"
      display-line-numbers-type nil
      my-lisp "~/.doom.d/ml"
      my-kbd "~/.doom.d/ml/kbd"
      use-package-always-defer t
      recentf-auto-cleanup "11:59pm"
      +word-wrap-extra-indent 'single
      confirm-kill-emacs nil
      auto-revert-verbose nil
      eldoc-idle-delay 2
      trash-directory "~/.Trash"
      flyspell-correct-auto-delay 1
      custom-file "~/.doom.d/.custom-file.el"
      abbrev-file-name "~/.doom.d/etc/abbrev.el"
      flycheck-global-modes '(not emacs-lisp-mode)
      recentf-max-saved-items 20
      langtool-language-tool-jar "~/maps/langtool/langtooljar")

(setq-hook! 'eww-mode-hook display-buffer-alist nil)

(defun my-buffer-predicate (buffer)
  (if (string-match "\*" (buffer-name buffer)) nil t))
(set-frame-parameter nil 'buffer-predicate 'my-buffer-predicate)

(put 'narrow-to-region 'disabled nil)
(put 'customize-group 'disabled nil)

(map! :map (org-mode-map evil-org-mode-map)
      :n "gr"       'my-evil-sel-to-end)

;;;;;;;;;;  ;;;;;;;;;;



(global-flycheck-mode -1)
(global-subword-mode +1)
(mouse-avoidance-mode 'jump)
