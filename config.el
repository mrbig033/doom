;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; * EVIL
(after! evil
  (setq! evil-emacs-state-cursor '(bar +evil-emacs-cursor-fn)))

;;; * HOOKS
(add-hook 'after-init-hook #'toggle-frame-maximized)

(add-hook 'doom-after-init-modules-hook (lambda ()
                                          (mapc 'load (file-expand-wildcards
                                                       "/Users/davi/.doom.d/ml/kbd/init/*.el"))
                                          (eyebrowse-mode t)))

(add-hook 'doom-first-file-hook (lambda ()
                                  (mapc 'load (file-expand-wildcards
                                               "/Users/davi/.doom.d/ml/kbd/*.el"))
                                  (mapc 'load (file-expand-wildcards
                                               "/Users/davi/.doom.d/ml/pkgs/all/*.el"))))
;;; * SETTINGS
(setq! my-lisp "~/.doom.d/ml"
       org-directory "~/org/"
       user-full-name "mrbig"
       confirm-kill-emacs nil
       persp-switch-to-added-buffer t
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
       doom-localleader-key "m")

(put 'narrow-to-region 'disabled nil)
(put 'customize-group 'disabled nil)
