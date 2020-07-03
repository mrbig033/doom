;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; * DASHBOARD WIDGET
(defun doom-dashboard-widget-banner ()
  (let ((point (point)))
    (mapc (lambda (line)
            (insert (propertize (+doom-dashboard--center +doom-dashboard--width line)
                                'face 'doom-dashboard-banner) " ")
            (insert "\n"))
          '("================== DOOM EMACS =================="))
    (when (and (display-graphic-p)
               (stringp fancy-splash-image)
               (file-readable-p fancy-splash-image))
      (let ((image (create-image (fancy-splash-image-file))))
        (add-text-properties
         point (point) `(display ,image rear-nonsticky (display)))
        (save-excursion
          (goto-char point)
          (insert (make-string
                   (truncate
                    (max 0 (+ 1 (/ (- +doom-dashboard--width
                                      (car (image-size image nil)))
                                   2))))
                   ? ))))
      (insert (make-string (or (cdr +doom-dashboard-banner-padding) 0)
                           ?\n)))))

;;; * DOOM DASHBOARD
(defun name ()
  (define-key! +doom-dashboard-mode-map
    [remap forward-button]  nil
    [remap backward-button] nil))

(map! (:map (+doom-dashboard-mode-map)
       :nge "<escape>"    'quit-window
       :n "q"             'quit-window
       :n "m"             'push-button
       :n "k"             'backward-button
       :n "j"             'forward-button
       :n "l"             'doom/quickload-session
       :n "A"             'org-agenda
       :n "F"             'counsel-recentf
       :n "p"             'counsel-projectile-switch-project
       :n "M"             'counsel-bookmark
       :n "P"             'doom/open-private-config
       :n "h"             'doom/help
       :leader "k"        'quit-window))

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
       +word-wrap-extra-indent 'single
       custom-file "~/.doom.d/.custom-file.el"
       abbrev-file-name "~/.doom.d/etc/abbrev.el"
       user-mail-address "mrbig033@protonmail.com"
       langtool-language-tool-jar "~/maps/langtool/langtooljar"
       doom-theme 'doom-dracula
       ;; doom-font (font-spec :family "Input Mono" :size 19)
       ;; doom-big-font (font-spec :family "Input Mono" :size 19)
       ;; doom-unicode-font (font-spec :family "Input Mono" :size 19)
       doom-localleader-key "m"
       +workspaces-main "#0"
       doom-variable-pitch-font (font-spec :family "Input Mono"))

;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(put 'narrow-to-region 'disabled nil)
(put 'customize-group 'disabled nil)
