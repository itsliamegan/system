(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-refresh-contents)

(let ((packages '(apheleia
                  avy
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

(let ((vc-packages '(svelte-ts-mode)))
  (unless (package-installed-p 'svelte-ts-mode)
    (package-vc-install '(svelte-ts-mode :url "https://github.com/leafOfTree/svelte-ts-mode"))))
