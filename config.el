;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
                                        ; (setq user-full-name "John Doe"
                                        ;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
                                        ; (setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
                                        ; (setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;

(add-hook 'after-save-hook #'my-after-save-hooks)
(add-hook 'after-init-hook #'toggle-frame-maximized)

(setq flycheck-global-modes '(not lisp-interaction-mode
                                  emacs-lisp-mode))

(setq-hook! 'eww-mode-hook display-buffer-alist nil)

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
       flyspell-correct-auto-delay 2
       iedit-toggle-key-default "C-x ;"
       display-line-numbers-type nil
       initial-major-mode 'scratch-lisp-mode
       +word-wrap-extra-indent 'single
       custom-file "~/.doom.d/.custom-file.el"
       abbrev-file-name "~/.doom.d/etc/abbrev.el"
       user-mail-address "mrbig033@protonmail.com"
       langtool-language-tool-jar "~/maps/langtool/langtooljar"
       doom-theme 'doom-dracula
       doom-font (font-spec :family "Input Mono" :size 19)
       doom-big-font (font-spec :family "Input Mono" :size 19)
       doom-unicode-font (font-spec :family "Input Mono" :size 19)
       doom-localleader-key "m"
       +workspaces-main 0
       doom-variable-pitch-font (font-spec :family "Input Mono"))


(defun my-after-save-hooks ()
  (interactive)
  (executable-make-buffer-file-executable-if-script-p))

(put 'narrow-to-region 'disabled nil)
(put 'customize-group 'disabled nil)

(mapc 'load (file-expand-wildcards "/Users/davi/.doom.d/ml/kbd/*.el"))
(mapc 'load (file-expand-wildcards "/Users/davi/.doom.d/ml/*.el"))

(yas-global-mode +1)
