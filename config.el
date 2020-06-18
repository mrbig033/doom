;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "mrbig"
      user-mail-address "mrbig033@protonmail.com")

(setq doom-font (font-spec :family "Input Mono" :size 20)
      doom-variable-pitch-font (font-spec :family "Input Mono") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "Input Mono" :size 20)
      doom-big-font (font-spec :family "Input Mono" :size 20))

(setq doom-theme 'doom-solarized-light)

(setq org-directory "~/org/")

(setq display-line-numbers-type nil)

(put 'narrow-to-region 'disabled nil)
(put 'customize-group 'disabled nil)

(setq-hook! 'eww-mode-hook display-buffer-alist nil)

(setq-default recentf-max-saved-items 20)

(setq! my-lisp "~/.doom.d/ml"
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
       langtool-language-tool-jar "~/maps/langtool/langtooljar")

(global-flycheck-mode -1)
(global-subword-mode +1)
(mouse-avoidance-mode 'jump)

(defun my-buffer-predicate (buffer)
  (if (string-match "\*" (buffer-name buffer)) nil t))

(set-frame-parameter nil 'buffer-predicate 'my-buffer-predicate)

(mapc 'load (file-expand-wildcards "/Users/davi/.doom.d/ml/kbd/*.el"))
(mapc 'load (file-expand-wildcards "/Users/davi/.doom.d/ml/*.el"))
