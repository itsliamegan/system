(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-refresh-contents)

(let ((packages '(avy
                  exec-path-from-shell
                  go-mode
                  magit
                  markdown-mode
                  olivetti
                  rust-mode
                  zig-mode)))
  (dolist (package packages)
    (package-install package)))
