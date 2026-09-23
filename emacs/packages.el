(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-refresh-contents)

(let ((packages '(avy
                  dockerfile-mode
                  eglot
                  exec-path-from-shell
                  magit
                  markdown-mode
                  olivetti
                  rust-mode
                  vterm)))
  (dolist (package packages)
    (package-install package)))
