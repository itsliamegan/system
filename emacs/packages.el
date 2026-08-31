(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-refresh-contents)

(let ((packages '(avy
                  eglot
                  exec-path-from-shell
                  magit
                  markdown-mode
                  olivetti
                  rust-mode
  (dolist (package packages)
    (package-install package)))
