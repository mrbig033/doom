;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq! eldoc-idle-delay 2
       my-lisp "~/.doom.d/ml"
       org-directory "~/org/"
       user-full-name "mrbig"
       confirm-kill-emacs nil
       auto-revert-verbose nil
       my-kbd "~/.doom.d/ml/kbd"
       trash-directory "~/.Trash"
       use-package-always-defer t
       flyspell-correct-auto-delay 1
       display-line-numbers-type nil
       recentf-auto-cleanup "11:59pm"
       +word-wrap-extra-indent 'single
       custom-file "~/.doom.d/.custom-file.el"
       abbrev-file-name "~/.doom.d/etc/abbrev.el"
       user-mail-address "mrbig033@protonmail.com"
       flycheck-global-modes '(not emacs-lisp-mode)
       langtool-language-tool-jar "~/maps/langtool/langtooljar"
       doom-theme 'doom-solarized-light
       doom-font (font-spec :family "Input Mono" :size 20)
       doom-big-font (font-spec :family "Input Mono" :size 20)
       doom-unicode-font (font-spec :family "Input Mono" :size 20)
       doom-variable-pitch-font (font-spec :family "Input Mono"))

(setq-default recentf-max-saved-items 20)
(setq-hook! 'eww-mode-hook display-buffer-alist nil)

(put 'narrow-to-region 'disabled nil)
(put 'customize-group 'disabled nil)


(mapc 'load (file-expand-wildcards "/Users/davi/.doom.d/ml/kbd/*.el"))
(mapc 'load (file-expand-wildcards "/Users/davi/.doom.d/ml/*.el"))

(global-flycheck-mode -1)
(global-subword-mode +1)
(mouse-avoidance-mode 'jump)
