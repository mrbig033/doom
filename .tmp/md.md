**Describe the feature**

Documentation should be read only by default. It's not uncommon for me to accidentally hit a command that introduces destructive changes, and I wonder if that's one of the reasons for `doom upgrade` errors regarding a messed up `.emacs.d`

A variable might be provided if the user wants the current behavior, and `C-x C-q` (`read-only-mode`) should also make the buffer editable. 


**System information**
<details><pre>
((emacs
  (version . "27.0.91")
  (features . "RSVG IMAGEMAGICK GLIB NOTIFY KQUEUE ACL GNUTLS LIBXML2 ZLIB TOOLKIT_SCROLL_BARS NS MODULES THREADS JSON PDUMPER LCMS2 GMP")
  (build . "May 14, 2020")
  (buildopts "--disable-dependency-tracking --disable-silent-rules --enable-locallisppath=/usr/local/share/emacs/site-lisp --infodir=/usr/local/Cellar/emacs-plus/HEAD-747e0a2/share/info/emacs --prefix=/usr/local/Cellar/emacs-plus/HEAD-747e0a2 --with-xml2 --without-dbus --with-gnutls --with-imagemagick --with-json --with-modules --with-rsvg --with-ns --disable-ns-self-contained")
  (windowsys . batch)
  (daemonp . server-running))
 (doom
  (version . "2.0.9")
  (build . "HEAD -> develop 0f3bd5710 2020-06-13 03:03:11 -0400")
  (dir . "~/.doom.d/"))
 (system
  (type . darwin)
  (config . "x86_64-apple-darwin18.7.0")
  (shell . "/usr/local/bin/bash")
  (uname . "Darwin 18.7.0 Darwin Kernel Version 18.7.0: Tue Aug 20 16:57:14 PDT 2019; root:xnu-4903.271.2~2/RELEASE_X86_64 x86_64")
  (path "/usr/local/opt/openjdk/bin" "~/.pyenv/shims" "~/.pyenv/bin" "~/.local/bin" "~/.emacs.d/bin" "~/scripts/bin" "~/.nimble/bin" "~/scripts/cline_scripts/" "~/.emacs.d/bin" "/usr/local/opt/sqlite/bin" "/usr/local/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Library/TeX/texbin" "/opt/X11/bin" "/Library/Frameworks/Mono.framework/Versions/Current/Commands" "~/.fzf/bin" "/usr/local/Cellar/emacs-plus/HEAD-747e0a2/libexec/emacs/27.0.91/x86_64-apple-darwin18.7.0"))
 (config
  (envfile . envvar-file)
  (elc-files . 0)
  (modules :completion company (ivy +prescient) :ui doom modeline (popup +defaults) treemacs :editor (evil +everywhere) fold multiple-cursors snippets word-wrap :emacs (dired +ranger +icons) electric undo vc :term eshell shell :checkers syntax spell grammar :tools (eval +overlay) (lookup +dictionary +offline) magit pdf :lang emacs-lisp markdown (org +roam) sh :app irc :config (default +bindings +smartparens))
  (packages (nswbuff) (org-pomodoro) (nswbuff) (olivetti) (super-save) (eyebrowse) (elpy) (clipmon) (evil-god-state) (unkillable-scratch) (yafolding) (recursive-narrow) (git-auto-commit-mode) (electric-operator) (evil-swap-keys) (evil-god-state) (evil-smartparens) (eyebrowse) (shut-up) (super-save) (evil-better-visual-line) (hl-sentence) (wordnut) (apheleia :recipe (:host github :repo "raxod502/apheleia")) (evil-snipe :disable t))
  (unpin "n/a")
  (elpa "n/a")))

</pre></details>

