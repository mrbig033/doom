;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "mrblack"
      user-mail-address "mrbig@protonmail.com")

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
; (setq doom-font (font-spec :family "monospace" :size 18 :weight 'semi-light)
;       doom-variable-pitch-font (font-spec :family "sans" :size 19.5))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.

(setq display-line-numbers-type nil
      doom-font (font-spec :family "Menlo" :size 19)
      doom-big-font (font-spec :family "Menlo" :size 19)
      doom-unicode-font (font-spec :family "Menlo" :size 19)
      doom-variable-pitch-font (font-spec :family "Input Mono")
      doom-localleader-key "m")

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

;; (use-package! evil
;;   :config
;;   (map! )

(defun my-last-buffer ()
(interactive)
(switch-to-buffer nil))
(map! :desc "Last Buffer" :nvg "M-s" 'my-last-buffer)

(use-package! ivy
  :custom
  (ivy-height 15)
  (counsel-grep-swiper-limit 300000)
  (ivy-extra-directories nil)
  (counsel-outline-display-style 'title)
  (counsel-find-file-at-point t)
  (counsel-bookmark-avoid-dired t)
  (ivy-count-format "")

  (ivy-ignore-buffers '("^#.*#$"
                        "^\\*.*\\*"
                        "^agenda.org$"
                        "magit"
                        "*org-src-fontification.\\*"))

  (counsel-ag nil "~/.emacs.d/" "-G '.org'")

  ;; Original:
  ;; (setq counsel-ag-base-command "ag --vimgrep %s")


  ;; (counsel-ag-base-command "ag
  ;; --filename
  ;; --nocolor
  ;; --nogroup
  ;; --smart-case
  ;; --skip-vcs-ignores
  ;; --silent
  ;; --ignore
  ;; '*.elc'
  ;; %s")

  :config

  (map! :nvi "C-s" 'counsel-grep-or-swiper
        :nvi "M-y" 'counsel-yank-pop
        :nvi "C-," 'counsel-projectile-switch-to-buffer
        :nvi "C-<" 'ivy-switch-buffer
        :nvi "C-." 'counsel-M-x
        :nvi "M-u" 'yas-insert-snippet
        :nvi "C-s" 'counsel-grep-or-swiper
        :nvi "C-." 'ivy-next-line
        :nvi "C-," 'counsel-find-symbol
        :desc "Counsel Ag" :leader "sg"  'counsel-ag)


  (map! :map (ivy-minibuffer-map ivy-switch-buffer-map)
        "M-y"      'ivy-next-line
        "M-r"      'ivy-next-line
        "C-,"      'ivy-next-line
        "C-."      'ivy-next-line
        "C-/"      'ivy-next-line
        "C-j"      'ivy-immediate-done
        "M-q"      'ivy-done
        "C-k"      'kill-line
        "C-d"      'delete-char
        "C-h"      'delete-backward-char
        "C-w"      'backward-kill-word
        "<insert>" 'yank))

;; https://github.com/abo-abo/swiper/issues/2588#issuecomment-637042732
(setq swiper-use-visual-line-p #'ignore)

(defun counsel-ag-thing-at-point ()
  (interactive)
  (ivy-with-thing-at-point 'counsel-ag))

(map! :leader "fO" 'counsel-locate
      :leader "fp" 'search-packages
      :leader "fs" 'search-settings)

(use-package! helpful
  :demand t
  :config
  (map! (:map helpful-mode-map
         :nvig "C-r" 'helpful-update
         :nvig "C-;" 'helpful-at-point
         :n "<escape>" 'quit-window)))

(use-package! prog-mode 
  :config

(defun my-indent-buffer ()
    (interactive)
    (let ((inhibit-message t))
      (evil-indent
       (point-min)
       (point-max))))

  (map!  "M-RET"          'my-indent-buffer
         :n "<backspace>" 'org-edit-src-exit
         (:map (prog-mode-map
                   emacs-lisp-mode-map
                   lisp-mode-map))
  ; (defun my-evil-sel-to-end ()
  ;   (interactive)
  ;   (evil-visual-char)
  ;   (evil-last-non-blank))


  ))

(use-package! files
  :custom
  (confirm-kill-emacs nil)
  :config

  (defun quiet-save-buffer ()
    (interactive)
    (let ((inhibit-message t))
      (evil-ex-nohighlight)
      (save-buffer)))

(defun my-sel-to-end ()
  (interactive)
  (evil-visual-char)
  (evil-last-non-blank))

  (map! (:map prog-mode-map tex-main-file)
        :n "<escape>" 'quiet-save-buffer)

  (defun goto-python-scratch ()
    (interactive)
    (find-file "~/.doom.d/.tmp/py.py"))

  (defun my-search-settings ()
    (interactive)
    (counsel-ag nil "~/.doom.d/.searches/" "-f -G '.org'"))

  (defun my-recenter-window ()
    (interactive)
    (recenter-top-bottom
     `(4)))

  (defun goto-packages ()
    (interactive)
    (counsel-ag "(use-package! " "~/.doom.d" "-f -G '.org'")
    (my-recenter-window))

  (defun goto-agenda ()
    (interactive)
    (find-file org-agenda-file))

  (defun goto-org ()
    (interactive)
    (find-file "~/.doom.d/.tmp/org.org"))

  (defun deer-goto-lisp ()
    (interactive)
    (deer "~/.doom.d"))

  (map! :leader "fa" 'goto-agenda
        :leader "fl" 'deer-goto-lisp
        :leader "fp" 'goto-packages
        :leader "fm" 'goto-markdown
        :leader "fo" 'goto-org)
  )

(defun my-sort-lines-by-length (reverse beg end)
  "sort lines by length."
  (interactive "p\nr")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ;; to make `end-of-line' and etc. to ignore fields.
          ((inhibit-field-text-motion t))
        (sort-subr reverse 'forward-line 'end-of-line nil nil
                   (lambda (l1 l2)
                     (apply #'< (mapcar (lambda (range) (- (cdr range) (car range)))
                                        (list l1 l2)))))
        (reverse-region beg end)))))

(general-define-key
:states  '(global normal visual insert)
:keymaps 'override
"M-9" 'quit-window
"M-s" 'my-last-buffer)

(map! :i      "M-e" 'yas-expand
      :leader "0"   'delete-window
      :leader "k"   'kill-this-buffer)

(use-package! org
  :after-call after-find-file
  :init
  (remove-hook! 'org-mode-hook 'writegood-mode 'flyspell-mode)
  (remove-hook! 'org-cycle-hook 'org-optimize-window-after-visibility-change)
  (add-hook! 'org-agenda-mode-hook 'hl-line-mode)
  (add-hook 'org-mode-hook (lambda () (org-indent-mode t)))
  (add-hook! 'org-cycle-hook
             #'org-cycle-hide-archived-subtrees
             #'org-cycle-hide-drawers
             #'org-cycle-show-empty-lines)
  :config

  (load "~/.doom.d/extras/org_func.el")
  (load "~/.doom.d/extras/org_kbd.el")
  (load "~/.doom.d/extras/org_settings.el")

  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines)))

(use-package! markdown-mode
  :init
  (add-hook!          'markdown-mode-hook
                      #'abbrev-mode
                      #'typo-mode)
  :custom
  (markdown-hide-urls 't)
  (markdown-hide-markup nil)
  (markdown-enable-wiki-links t)
  :config
  (map! (:map (markdown-mode-map evil-markdown-mode-map)
         :i    "<tab>"      'tab-to-tab-stop
         :i    "C-h"        'markdown-outdent-or-delete
         :v    "<insert>"   'markdown-insert-link
         :nvi  "M--"        'winner-undo
         :nvi  "M-="        'winner-redo
         :nvi  "<C-return>" 'my-open-two-lines
         :nvi  "M-n"        'my-forward-paragraph-do-indentation
         :nvi  "M-p"        'my-backward-paragraph-do-indentation)))

(defun xah-clean-empty-lines ()
  "replace repeated blank lines to just 1."
  (interactive)
  (let ($begin $end)
    (if (region-active-p)
        (setq $begin (region-beginning) $end (region-end))
      (setq $begin (point-min) $end (point-max)))
    (save-excursion
      (save-restriction
        (narrow-to-region $begin $end)
        (progn
          (goto-char (point-min))
          (while (re-search-forward "\n\n\n+" nil "move")
            (replace-match "\n\n")))))))

(use-package! company
  :custom
  (company-ispell-available t)
  (company-show-numbers t)
  (company-idle-delay 0.2)
  (company-tooltip-limit 10)
  (company-minimum-prefix-length 1)
  (company-dabbrev-other-buffers t)
  (company-selection-wrap-around t)
  (company-auto-complete nil)
  (company-dabbrev-ignore-case 'keep-prefix)
  (company-global-modes '(not erc-mode
                              ;; text-mode
                              ;; org-mode
                              ;; markdown-mode
                              message-mode
                              help-mode
                              gud-mode
                              eshell-mode))

  :general
  (:keymaps '(company-active-map)
   "<return>" nil
   "C-h"    'backward-delete-char
   "M-e"    'my-company-yasnippet
   "M-q"    'company-complete-selection
   "C-d"    'counsel-company
   "M-w"    'my-company-comp-with-paren
   "M-."    'my-company-comp-with-dot
   "M-j"    'my-company-comp-space
   "C-u"    'my-backward-kill-line
   "M-0"    'company-complete-number
   "M-1"    'company-complete-number
   "M-2"    'company-complete-number
   "M-3"    'company-complete-number
   "M-4"    'company-complete-number
   "M-5"    'company-complete-number
   "M-6"    'company-complete-number
   "M-7"    'company-complete-number
   "M-8"    'company-complete-number
   "M-9"    'company-complete-number)

  :config

  (defun my-company-yasnippet ()
    (interactive)
    (company-abort)
    (yas-expand))

  (defun my-company-comp-with-paren ()
    (interactive)
    (company-complete-selection)
    (insert "()")
    (backward-char))

  (defun my-company-comp-with-dot ()
    (interactive)
    (company-complete-selection)
    (insert ".")
    (company-complete))

  (defun my-company-comp-space ()
    (interactive)
    (company-complete-selection)
    (insert " ")))

(use-package unkillable-scratch
  :config
  (setq unkillable-scratch-behavior 'bury
        unkillable-buffers '("^\\*scratch\\*$"
                             "~/.doom.d/config.org"))
  (unkillable-scratch))
