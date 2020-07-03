;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; * HOOKS
(add-hook 'after-init-hook #'toggle-frame-maximized)

(add-hook '+doom-dashboard-mode-hook (lambda () (hl-line-mode -1)))

(add-hook 'doom-first-buffer-hook (lambda ()
                                    (mapc 'load (file-expand-wildcards
                                                 "/Users/davi/.doom.d/ml/kbd/*.el"))
                                    (mapc 'load (file-expand-wildcards
                                                 "/Users/davi/.doom.d/ml/*.el"))))

(setq-hook! 'eww-mode-hook display-buffer-alist nil)
;;; * SETTINGS
(setq! my-lisp "~/.doom.d/ml"
       org-directory "~/org/"
       user-full-name "mrbig"
       confirm-kill-emacs nil
       auto-revert-verbose nil
       my-kbd "~/.doom.d/ml/kbd"
       trash-directory "~/.Trash"
       use-package-always-defer t
       ns-option-modifier 'meta
       ns-right-option-modifier 'meta
       iedit-toggle-key-default "C-x ;"
       display-line-numbers-type nil
       initial-major-mode 'fundamental-mode
       initial-buffer-choice t
       +word-wrap-extra-indent 'single
       custom-file "~/.doom.d/.custom-file.el"
       abbrev-file-name "~/.doom.d/etc/abbrev.el"
       user-mail-address "mrbig033@protonmail.com"
       langtool-language-tool-jar "~/maps/langtool/langtooljar"
       doom-theme 'doom-dracula
       doom-font (font-spec :family "Menlo" :size 19)
       doom-big-font (font-spec :family "Menlo" :size 19)
       doom-unicode-font (font-spec :family "Menlo" :size 19)
       doom-variable-pitch-font (font-spec :family "Input Mono")
       doom-localleader-key "m"
       +workspaces-main "#0")

(put 'narrow-to-region 'disabled nil)
(put 'customize-group 'disabled nil)
