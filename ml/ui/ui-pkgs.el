(use-package! which-key
  :custom
  (which-key-allow-evil-operators nil)
  (which-key-idle-delay 0.4)
  (which-key-idle-secondary-delay 0.1)
  :config
  (which-key-add-key-based-replacements

    "SPC bt" "Kill Matching Buffers"

    "SPC SPC tp" "Prose"
    "SPC SPC b" "Buffers"

    "SPC SPC r"   "Roam"

    "SPC SPC t"   "Text"

    "SPC SPC p"   "Programming"

    "SPC SPC s"   "Scratch"

    "SPC mwi"  "OW Insert"
    "SPC mwe"  "OW Archive"
    "SPC mwv"  "OW Attach"
    "SPC mwr"  "OW Read As Org"
    "SPC mwc"  "OW Links to Entries"

    "SPC SPC x"  "Org Capture")

  (which-key-mode +1))

(use-package! hydra
  :general
  (:keymaps '(doom-leader-map)
   "j"     'hydra-org-clock/body))

(use-package! ivy
  :custom
  (ivy-height 12)
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

  ;; (counsel-ag-base-command "ag --filename --nocolor --nogroup --smart-case --skip-vcs-ignores --silent --ignore '*.elc' %s")

  :general
  (:states '(normal visual insert)
   "C-s" 'counsel-grep-or-swiper
   "M-y" 'counsel-yank-pop
   "C-," '+ivy/switch-workspace-buffer
   "C-<" 'ivy-switch-buffer
   "C-." 'counsel-M-x
   "M-u" 'ivy-yasnippet)

  (:keymaps 'doom-leader-map
   "sg"  'counsel-ag
   "sp"  'counsel-projectile-ag)
  (:keymaps 'counsel-describe-map
   "C-." 'ivy-next-line
   "C-," 'counsel-find-symbol)
  (:keymaps '(ivy-minibuffer-map ivy-switch-buffer-map)
   "M-y"      'ivy-next-line
   "M-r"      'ivy-next-line
   "C-,"      'ivy-next-line
   "C-."      'ivy-next-line
   "C-/"      'ivy-next-line
   "C-j" 'ivy-immediate-done
   "M-q"      'ivy-done
   "C-k"      'kill-line
   "C-d"      'delete-char
   "C-h"      'delete-backward-char
   "C-w"      'backward-kill-word
   "<insert>" 'yank)

  :config

  ;; https://github.com/abo-abo/swiper/issues/2588#issuecomment-637042732
  (setq swiper-use-visual-line-p #'ignore)

  (defun my-search-ag-brain ()
    (interactive)
    (counsel-ag nil org-brain-path "--heading --filename --follow --smart-case --org"))

  (defun my-search-settings ()
    (interactive)
    (counsel-ag nil "~/.doom.d/" "-G '.el'"))

  (defun my-search-kbds ()
    (interactive)
    (counsel-ag nil "~/.doom.d/ml/kbd/" "-G '.el'"))

  (defun my-search-doom-help ()
    (interactive)
    (counsel-ag nil "~/.emacs.d/" "-G '.org'"))

  (defun my-search-doom-package-config ()
    (interactive)
    (counsel-ag nil "~/.emacs.d/.local/straight/repos" "-G '.el'"))

  (defun my-search-packages ()
    (interactive)
    (my-widen-to-center-with-excursion)
    (counsel-ag  "(use-package\\! "  "~/.doom.d/ml/" "-G '.el'"))

  (defun my-swiper-python-classes ()
    (interactive)
    (swiper  "class "))

  (defun my-swiper-python-functions ()
    (interactive)
    (swiper  "def "))

  (defun my-search-python-classes ()
    (interactive)
    (counsel-ag  "^class "))

  (defun my-search-python-function ()
    (interactive)
    (counsel-ag  "def "))

  (defun ivy-with-thing-at-point (cmd)
    (let ((ivy-initial-inputs-alist
           (list
            (cons cmd (thing-at-point 'symbol)))))
      (funcall cmd)))

  (defun counsel-ag-thing-at-point ()
    (interactive)
    (ivy-with-thing-at-point 'counsel-ag)))

(use-package! ivy-yasnippet
  :after (ivy yasnippet)
  :custom
  (ivy-yasnippet-expand-keys nil))

(use-package! doom-modeline
  :custom
  (doom-modeline-persp-icon t)
  (doom-modeline-persp-name t)
  (doom-modeline-display-default-persp-name t)
  (doom-modeline-vcs-max-length 12)
  (doom-modeline-env-version nil)
  (doom-modeline-env-enable-go nil)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-buffer-state-icon nil)
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-enable-word-count nil)
  (doom-modeline-env-enable-ruby nil)
  (doom-modeline-env-enable-perl nil)
  (doom-modeline-env-enable-rust nil)
  (doom-modeline-env-enable-python nil)
  (doom-modeline-lsp nil)
  (doom-modeline-env-enable-elixir nil)
  (doom-modeline-env-load-string ".")
  (doom-modeline-buffer-modification-icon nil)
  (doom-modeline-irc nil)
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-checker-simple-format t)
  (doom-modeline-bar-width 2)
  (doom-modeline-percent-position '(-3 "%p"))
  (doom-modeline-enable-word-count t)
  (doom-modeline-buffer-file-name-style 'buffer-name)
  :config
  (column-number-mode -1)
  (size-indication-mode -1))

(use-package! delight
  :after-call after-find-file
  :config
  (delight '((org-mode "[o]")
             (vimrc-mode "[vim]" "Vimrc")
             (scratch-fundamental-mode "[scf]" "scratch-fundamental")
             (org-brain-visualize-mode "[brain]" "Org-brain Visualize")
             (messages-buffer-mode "[msg]" "Messages")
             (scratch-lisp-mode "[scl]" "scratch-lisp")
             (markdown-mode "[md]" "markdown")
             (sh-mode "" "Shell-script [bash]")
             (special-mode "[spe]" "special")
             (message-mode "[msg]" "messages")
             (fundamental-mode "[fun]" "fundamental")
             (python-mode "[py]" " python")
             (emacs-lisp-mode "[el]" "emacs-lisp")
             (lisp-interaction-mode "[lin]" "lisp interaction"))))
