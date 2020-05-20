__What did you expect to happen?__

``` emacs-lisp
(after! elpy-mode
  (set-company-backend! 'elpy-mode 'elpy-company-backend))
```

  
or 


``` emacs-lisp
(after! python-mode
  (set-company-backend! 'python-mode 'elpy-company-backend))
```

Should add `elpy-company-backend` to `company-backends` or something to that effect, but the setting has no effect whatsoever. I have also tried packages such as `jedi` and `company-jedi`, as well as other methods to modify the list of backends.

**What actually happened?**

Configurations to company backends have no effect.

**Additional details:**
- [[https://github.com/mrbig033/doom][Link to your private config]]
- Screenshots/casts of your issue: **non applicable**.

**Steps to reproduce:**
1. Install and configure elpy and its backend
2. Open file
3. `M-x company-backends`
4. `elpy-company-backend` should be there.


**System information:**
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
  (build . "HEAD -> develop b794de3ba 2020-05-18 15:18:02 -0400")
  (dir . "~/.doom.d/"))
 (system
  (type . darwin)
  (config . "x86_64-apple-darwin18.7.0")
  (shell . "/bin/bash")
  (uname . "Darwin 18.7.0 Darwin Kernel Version 18.7.0: Tue Aug 20 16:57:14 PDT 2019; root:xnu-4903.271.2~2/RELEASE_X86_64 x86_64")
  (path "/usr/local/opt/openjdk/bin" "~/.pyenv/shims" "~/.pyenv/bin" "~/.local/bin" "~/.emacs.d/bin" "~/scripts/bin" "~/.nimble/bin" "~/scripts/cline_scripts/" "~/.emacs.d/bin" "/usr/local/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Library/TeX/texbin" "/opt/X11/bin" "~/.fzf/bin" "/usr/local/Cellar/emacs-plus/HEAD-747e0a2/libexec/emacs/27.0.91/x86_64-apple-darwin18.7.0"))
 (config
  (envfile . envvar-file)
  (elc-files . 0)
  (modules :completion company ivy :ui doom hydra modeline (popup +defaults) treemacs :editor (evil +everywhere) file-templates fold snippets word-wrap :emacs dired electric undo vc :checkers syntax spell grammar :tools (eval +overlay) lookup macos pdf :lang data emacs-lisp markdown org sh :config (default +bindings +smartparens))
  (packages (general) (pdf-tools) (org-pdfview) (org-pomodoro) (benchmark-init) (ranger) (nswbuff) (prescient) (ivy-prescient) (company-prescient) (ivy-hydra) (olivetti) (super-save) (eyebrowse) (elpy) (shut-up) (electric-operator) (ivy-hydra) (elmacro) (clipmon) (evil-god-state) (unkillable-scratch) (git-commit) (ag) (treemacs) (treemacs-projectile) (evil-better-visual-line) (aphelia :recipe (:host github :repo "raxod502/apheleia")) (shut-up :disable t) (evil-snipe :disable t))
  (unpin "n/a")
  (elpa "n/a")))
</pre></details>
