(use-package! deft
  :after org-brain
  :init
  (evil-set-initial-state 'deft-mode 'emacs)
  :custom
  (deft-separator " - ")
  (deft-extensions '("org"))
  (deft-recursive t)
  (deft-use-filename-as-title t)
  (deft-default-extension "org")
  (deft-use-filter-string-for-filename t)
  (deft-directory org-brain-path))

(use-package! avy

  :general
  (:states '(normal)
   "g9"      'my-avy-goto-open-paren
   "g0"      'my-avy-goto-close-paren
   ","       'avy-goto-subword-1
   "F"       'evil-avy-goto-char-2-above
   "f"       'evil-avy-goto-char-2-below)

  :custom
  (avy-case-fold-search 't)
  (avy-style 'at-full)
  (avy-timeout-seconds 0.3)
  (avy-highlight-first t)
  (avy-single-candidate-jump t)
  :custom-face
  (avy-background-face((t (:foreground "LightSkyBlue3"))))
  :config

  (add-to-list 'avy-orders-alist '(my-avy-goto-parens . avy-order-closest))

  (defun my-avy-goto-open-paren ()
    (interactive)
    (let ((avy-command this-command))   ; for look up in avy-orders-alist
      (avy-jump "(+")))

  (defun my-avy-goto-close-paren ()
    (interactive)
    (let ((avy-command this-command))   ; for look up in avy-orders-alist
      (avy-jump ")+")))
  (setq! avy-keys (nconc (number-sequence ?a ?z)
                         (number-sequence ?0 ?9))))

(use-package! ispell
  :custom
  (ispell-quietly t)

  :config

  ;; https://stackoverflow.com/a/19186801

  (defvar limit-ispell-choices-to 5
    "Number indicating the maximum number of choices to present")

  (setq! limit-ispell-choices-to 20)

  (defadvice ispell-parse-output (after limit-ispell-choices activate)
    (when (and (listp ad-return-value)
               ad-return-value)
      (let* ((miss-list-end (nthcdr (- limit-ispell-choices-to 1)
                                    (nth 2 ad-return-value)))
             (guess-list-end (nthcdr (- limit-ispell-choices-to 1)
                                     (nth 3 ad-return-value))))
        (when miss-list-end (setcdr miss-list-end nil))
        (when guess-list-end (setcdr guess-list-end nil)))))

  ;; DON'T SPELLCHECK ORG BLOCKS
  (pushnew! ispell-skip-region-alist
            '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:")
            '("#\\+BEGIN_SRC" . "#\\+END_SRC")
            '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))

  ;; SAVE CORRECTIONS TO ABBREV
  (defun endless/simple-get-word ()
    (car-safe (save-excursion (ispell-get-word nil))))

  (defun endless/ispell-word-then-abbrev (p)
    "call `ispell-word', then create an abbrev for it.
      with prefix p, create local abbrev. otherwise it will
      be global.
      if there's nothing wrong with the word at point, keep
      looking for a typo until the beginning of buffer. you can
      skip typos you don't want to fix with `spc', and you can
      abort completely with `c-g'."
    (interactive "p")
    (let (bef aft)
      (save-excursion
        (while (if (setq bef (endless/simple-get-word))
                   ;; word was corrected or used quit.
                   (if (ispell-word nil 'quiet)
                       nil ; end the loop.
                     ;; also end if we reach `bob'.
                     (not (bobp)))
                 ;; if there's no word at point, keep looking
                 ;; until `bob'.
                 (not (bobp)))
          (backward-word)
          (backward-char))
        (setq aft (endless/simple-get-word)))
      (if (and aft bef (not (equal aft bef)))
          (let ((aft (downcase aft))
                (bef (downcase bef)))
            (define-abbrev
              (if p local-abbrev-table global-abbrev-table)
              bef aft)
            (message "\"%s\" now expands to \"%s\" %sally"
                     bef aft (if p "loc" "glob")))
        (user-error "no typo at or before point")))))

(use-package! pdf-view
  :init

  (add-hook 'pdf-outline-buffer-mode-hook (lambda () (toggle-truncate-lines +1)))

  :general

  (:keymaps   'pdf-view-mode-map
   :states '(normal visual)
   "H"        'pdf-history-backward
   "L"        'pdf-history-forward
   "C-s"      'pdf-occur
   "<escape>" 'ignore
   "TAB"      'pdf-outline
   "o"      'pdf-outline
   "q"        'quit-window
   "w"        'pdf-view-fit-width-to-window
   "h"        'pdf-view-scroll-up-or-next-page
   "l"        'pdf-view-scroll-down-or-previous-page
   "j"        'pdf-view-next-page
   "k"        'pdf-view-previous-page
   "p"        'pdf-view-previous-line-or-previous-page
   "n"        'pdf-view-next-line-or-next-page
   "K"        'pdf-view-previous-line-or-previous-page
   "J"        'pdf-view-next-line-or-next-page
   "C-l"      'my-show-pdf-view-commands)

  (:keymaps   'pdf-outline-buffer-mode-map
   :states '(normal visual)
   "<escape>"  'quit-window)

  :custom

  (pdf-view-continuous t)
  (pdf-view-resize-factor 1.15)
  (pdf-misc-size-indication-minor-mode t)

  :config

  (defun my-show-pdf-view-commands ()
    (interactive)
    (counsel-M-x "^pdf-view- ")))

(use-package! text-mode
  :init
  (add-hook! 'text-mode-hook 'my-text-mode-hooks)
  (remove-hook 'text-mode-hook 'hl-line-mode)

  :config
  (defun my-text-mode-hooks ()
    (electric-operator-mode +1)
    (abbrev-mode +1)
    (pabbrev-mode +1)
    (auto-capitalize-mode +1)))

(use-package! recursive-narrow
  :init
  (require 'recursive-narrow))

(use-package! hl-sentence
  :config
  (custom-set-faces
   '(hl-sentence ((t (:inherit hl-line))))))

(use-package! wordnut
  :init
  (add-hook! 'wordnut-mode-hook 'hide-mode-line-mode)
  :general
  (:keymaps '(doom-leader-map)
   "sW"  'wordnut-search
   "sw"  'wordnut-lookup-current-word)
  (:keymaps '(wordnut-mode-map)
   :states '(normal visual)
   "q" 'quit-window
   "Q" 'kill-this-buffer
   :states '(normal)
   "<escape>" 'quit-window))

(use-package! osx-dictionary
  :init
  (add-hook! 'osx-dictionary-mode-hook 'hide-mode-line-mode)
  :general
  (:keymaps '(osx-dictionary-mode-map)
   :states  '(normal)
   "<escape>" 'quit-window
   "q" 'quit-window))

(use-package! clipmon
  :init
  (clipmon-mode-start))

(use-package! olivetti
  :init
  (setq-default olivetti-body-width 85))

(use-package! typo
  :config

  (define-typo-cycle typo-cycle-right-single-quotation-mark
    "Cycle through the right quotation mark and the typewriter apostrophe."
    ( "'" "’"))

  (define-typo-cycle typo-cycle-dashes
    "Cycle through various dashes."
    ("-"   ; hyphen-minus
     "—"   ; em dash
     "−"   ; minus sign
     "‐"   ; hyphen
     "–"   ; en dash
     "‑"   ; non-breaking hyphen
     )))

(use-package! google-translate
  :custom
  (google-translate-pop-up-buffer-set-focus t)
  (google-translate-default-source-language "pt")
  (google-translate-default-target-language "en")
  (google-translate-translation-directions-alist '(("pt" . "en") ("en" . "pt"))))

(use-package! markdown-mode
  :init
  (add-hook! 'markdown-mode-hook #'abbrev-mode #'typo-mode)
  :custom
  (markdown-hide-urls 't)
  (markdown-hide-markup nil)
  (markdown-enable-wiki-links t)
  :general
  (:keymaps     '(markdown-mode-map evil-markdown-mode-map)
   :states      '(insert)
   "<tab>"      'tab-to-tab-stop
   "C-h"        'markdown-outdent-or-delete
   :states      '(visual)
   "<insert>" 'markdown-insert-link
   :states      '(normal visual insert global)
   "M--"        'winner-undo
   "M-="        'winner-redo
   "<C-return>" 'my-open-two-lines
   "M-n"        'my-forward-paragraph-do-indentation
   "M-p"        'my-backward-paragraph-do-indentation))

(use-package! pabbrev
  :custom
  (pabbrev-scavenge-some-chunk-size 120)
  (pabbrev-marker-distance-before-scavenge 1000)
  (pabbrev-idle-timer-verbose nil))

(use-package! org-brain
  :after-call after-find-file
  :init
  (add-hook 'org-brain-visualize-mode-hook (lambda () (+word-wrap-mode +1)))
  (add-hook  'org-brain-visualize-mode-hook 'hide-mode-line-mode)

  (add-hook! 'org-brain-visualize-follow-hook
             #'my-clean-all-empty-lines
             #'xah-clean-empty-lines
             #'my-save-some-buffers
             #'org-hide-drawer-all)
  :custom
  (org-brain-open-same-window t)
  (org-brain-show-text nil)
  (org-brain-path "~/org/Data/brain/boogey")
  (org-brain-show-history nil)
  (org-brain-headline-links-only-show-visible t)
  (org-brain-include-file-entries t)
  ;; (org-brain-scan-for-header-entries nil)
  (org-brain-show-full-entry nil)
  (org-brain-refile-max-level 5)
  (org-brain-visualize-sort-function 'ignore)
  (org-id-track-globally t)
  (org-brain-title-max-length 0)
  (org-brain-file-entries-use-title t)
  (org-brain-mind-map-parent-level 5)
  (org-brain-mind-map-child-level 5)
  (org-brain-visualize-default-choices 'all)
  (org-id-locations-file "~/org/Data/brain/.org-id-locations")
  :config

  (defun my-brain-olivetti ()
    (interactive)
    (setq-local olivetti-body-width '65)
    (olivetti-mode))

  (defun my-brain-goto-current-maximize ()
    (interactive)
    (push-button)
    (org-brain-goto-current)
    (org-hide-drawer-all)
    (doom/window-maximize-vertically)
    (windmove-right))

  (defun my-brain-goto-current-maximize-and-go ()
    (interactive)
    (push-button)
    (org-brain-goto-current)
    (org-hide-drawer-all)
    (doom/window-maximize-vertically))

  (defun my-goto-brain-main ()
    (interactive)
    (org-brain-visualize "boogey"))

  (defun my-goto-brain ()
    (interactive)
    (switch-to-buffer-other-window "*org-brain*"))

  (defun my-goto-brain-same-window ()
    (interactive)
    (switch-to-buffer "*org-brain*"))

  (defun my-brain-erase-history ()
    (interactive)
    (setq org-brain--vis-history nil))

  (add-hook 'before-save-hook #'org-brain-ensure-ids-in-buffer))

(use-package! lorem-ipsum
  :custom
  (lorem-ipsum-paragraph-separator "\n\n"))

(use-package! engine-mode
  :config

  (defun engine/search-aurelio-ap ()
    (interactive)
    (engine/search-aurelio (current-word)))

  (defengine aurelio "https://www.dicio.com.br/%s")

  (defun engine/search-wikitionary-pt-ap ()
    (interactive)
    (engine/search-wikitionary-pt (current-word)))
  (defengine wikitionary-pt "https://pt.wiktionary.org/wiki/%s")

  (defun engine/free-dic-pt-ap ()
    (interactive)
    (engine/search-free-dic-pt (current-word)))
  (defengine free-dic-pt "https://pt.thefreedictionary.com/%s")

  (defun engine/search-dic-infor-ap ()
    (interactive)
    (engine/search-dic-infor (current-word)))
  (defengine dic-infor "https://www.dicionarioinformal.com.br/%s")

  (defun engine/search-dic-infor-sin-ap ()
    (interactive)
    (engine/search-dic-infor-sin (current-word)))
  (defengine dic-infor-sin "https://www.dicionarioinformal.com.br/sinonimos/%s")

  (defun my-engine-dic-infor-rimas-ap ()
    (interactive)
    (engine/search-dic-infor-rimas (current-word)))
  (defengine dic-infor-rimas "https://www.dicionarioinformal.com.br/rimas/%s")

  (defun my-engine-search-michaealis-ap ()
    (interactive)
    (engine/search-michaelis (current-word)))
  (defengine michaelis "https://michaelis.uol.com.br/moderno-portugues/busca/portugues-brasileiro/%s")

  (defun my-engine-rhymit-pt-ap ()
    (interactive)
    (engine/search-rhymit-pt (current-word)))
  (defengine rhymit-pt "https://www.rhymit.com/pt/palavras-que-rimam-com-%s?")

  (engine-mode t))

(use-package! fountain-mode
  :init
  (add-to-list 'auto-mode-alist '("\\ft\\'" . fountain-mode))
  (add-hook 'fountain-mode-hook (lambda () (+word-wrap-mode -1)))
  (add-hook! 'fountain-mode-hook
             #'auto-capitalize-mode
             #'electric-operator-mode
             #'olivetti-mode))

(use-package! url-shortener
  :custom
  (bitly-access-token "3026d7e8b1a0f89da10740c69fd77b4b3293151e"))

(use-package! flyspell
  :custom
  (flyspell-delayed-commands nil)
  (flyspell-correct-auto-delay 0.2)
  (flyspell-delay 0.2))

(use-package! yasnippet
  :disabled
  :config
  (yas-global-mode -1))
