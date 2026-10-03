(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-refresh-contents)

(let ((packages '(apheleia
                  avy
                  citar
                  dockerfile-mode
                  eglot
                  exec-path-from-shell
                  magit
                  marginalia
                  markdown-mode
                  olivetti
                  orderless
                  rust-mode
                  vertico
                  vterm)))
  (dolist (package packages)
    (package-install package)))

(let ((vc-packages '((svelte-ts-mode :url "https://github.com/leafOfTree/svelte-ts-mode"))))
  (dolist (package vc-packages)
    (let ((name (car package)))
      (unless (package-installed-p name)
        (package-vc-install package)))))
