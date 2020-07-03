;;; ~/.doom.d/file-functions.el -*- lexical-binding: t; -*-

;;;; BASIC FUNCTIONS ;;;;

(defun my-emacs-init-time ()
  (interactive)
  (let ((str
         (format "%ss"
                 (float-time
                  (time-subtract after-init-time before-init-time)))))
    (if (called-interactively-p 'interactive)
        (message "%s" str)
      str)))

(defun my-show-major-mode ()
  (interactive)
  (message "Major Mode: %s" major-mode))

(defun my-show-server-name ()
  (interactive)
  (message "Server Name: %s" server-name))

(defun my-show-init-times ()
  (interactive)
  (message "Emacs: %s | Doom: %ss" (my-emacs-init-time) doom-init-time))

;;;; IVY FUNCTIONS ;;;;

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

(defun my-widen-to-center-with-excursion ()
  (interactive)
  (widen)
  (recenter))

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

;;; GOTO PLACES ;;;;

(defun my-goto-markdown ()
  (interactive)
  (find-file "~/.doom.d/.tmp/md.md"))

(defun my-goto-scratch-buffer ()
  (interactive)
  (switch-to-buffer "*scratch*"))

(defun my-goto-python-scratch ()
  (interactive)
  (find-file "~/.doom.d/.tmp/py.py"))

(defun my-goto-my-packages ()
  (interactive)
  (find-file "~/.doom.d/ml/my-packages.el")
  (my-recenter-window)
  (message nil))

(defun my-goto-agenda ()
  (interactive)
  (find-file org-agenda-file))

(defun my-goto-messages-buffer ()
  (interactive)
  (switch-to-buffer "*Messages*"))

(defun my-goto-brain-game ()
  (interactive)
  (org-brain-visualize "game"))

(defun my-last-buffer ()
  (interactive)
  (switch-to-buffer nil))
