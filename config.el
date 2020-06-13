;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "mrbig"
      user-mail-address "mrbig033@protonmail.com")

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

(setq doom-font (font-spec :family "Input Mono" :size 20)
      doom-variable-pitch-font (font-spec :family "Input Mono") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "Input Mono" :size 20)
      doom-big-font (font-spec :family "Input Mono" :size 20))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(put 'narrow-to-region 'disabled nil)
(put 'customize-group 'disabled nil)
(setq-hook! 'eww-mode-hook display-buffer-alist nil)

(setq-default recentf-max-saved-items 20)

(setq! my-lisp "~/.doom.d/ml"
       use-package-always-defer t
       recentf-auto-cleanup "11:59pm"
       +word-wrap-extra-indent 'single
       confirm-kill-emacs nil
       auto-revert-verbose nil
       trash-directory "~/.Trash")

(global-flycheck-mode -1)
;; (auto-save-visited-mode +1)

(load! "functions.el" my-lisp)
(load! "keybindings.el" my-lisp)
(load! "keybindings.el" my-lisp)
(load! "my-packages.el" my-lisp)
(load! "my-hydras.el" my-lisp)
(load! "cool-moves.el" my-lisp)
(load! "auto-capitalize.el" my-lisp)
