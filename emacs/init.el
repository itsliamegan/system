;; -------
;; Startup
;; -------

(defconst *16-mb* (* 16 1024 1024))

;; Increase the garbage collection threshold at startup, then set it to a
;; reasonable amount after Emacs has initialized.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold *16-mb*
                  gc-cons-percentage 0.1)))

;; Increase the garbage collection threshold when using the minibuffer, then
;; restore it afterwards.
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (setq gc-cons-threshold most-positive-fixnum)))

(add-hook 'minibuffer-exit-hook
          (lambda ()
            (run-at-time 1 nil (lambda ()
                                 (setq gc-cons-threshold *16-mb*)))))

;; Store user customizations in a separate file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; Store custom themes in a subdirectory.
(setq custom-theme-directory (expand-file-name "themes" user-emacs-directory))
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))

;; Store backups in the system temporary directory.
(setq backup-directory-alist `(("." . ,temporary-file-directory)))

(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; Show a blank buffer on startup.
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)
(setq initial-major-mode 'fundamental-mode)
(defun startup-echo-area-message () "")

;; Load environment variables from .bashrc.
(require 'exec-path-from-shell)
(setq exec-path-from-shell-arguments '("-l" "-i"))
(add-to-list 'exec-path-from-shell-variables "ASPELL_CONF")
(exec-path-from-shell-initialize)

;; ---------
;; Interface
;; ---------

;; Hide window chrome.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode 0)

;; Maximize the default window.
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Open new frames with reasonable dimensions.
(add-to-list 'default-frame-alist '(width . 100))
(add-to-list 'default-frame-alist '(height . 52))

;; Set appropriate theme based on system theme.
(setq theme (if (string= (shell-command-to-string "gsettings get org.gnome.desktop.interface color-scheme")
                         "\'prefer-dark\'\n")
                'modus-vivendi
              'modus-operandi))

;; Use an accessible, high-contrast theme.
(load-theme theme t)

;; Set appropriate font size based on screen resolution.
(setq relative-screen-size (if (> (display-pixel-width) 1440)
                               'large
                             'small))
(setq fixed-pitch-font-size (pcase relative-screen-size
                              ('large 140)
                              ('small 110)))
(setq variable-pitch-font-size (pcase relative-screen-size
                                 ('large 160)
                                 ('small 120)))

;; Use a monospaced font with no line spacing by default.
(set-face-attribute 'default nil :family "DejaVu Sans Mono" :height fixed-pitch-font-size)
(set-face-attribute 'fixed-pitch nil :inherit 'default)
(setq variable-pitch-line-spacing 0)
(setq-default line-spacing variable-pitch-line-spacing)

;; Use a sans serif font with light line spacing for prose.
(set-face-attribute 'variable-pitch nil :family "Helvetica Neue" :height variable-pitch-font-size)
(setq variable-pitch-line-spacing 0.15)

;; Use a simple window title.
(setq frame-title-format "Emacs")

(defun custom-mode-line-render (left center right &optional lpad rpad)
  "Return a string the width of the current window with LEFT, CENTER, and RIGHT
spaced out accordingly, LPAD and RPAD, can be used to add a number of spaces to
the front and back of the string."
  (condition-case err
      (let* ((left (if lpad (concat (make-string lpad ?\s) left) left))
             (right (if rpad (concat right (make-string rpad ?\s)) right))
             (width (apply '+ (window-width) (let ((m (window-margins))) (list (or (car m) 0) (or (cdr m) 0)))))
             (total-length (+ (length left) (length center) (length right) 2)))
        (when (> total-length width) (setq left "" right ""))
        (let* ((left-space (/ (- width (length center)) 2))
               (right-space (- width left-space (length center)))
               (lspaces (max (- left-space (length left)) 1))
               (rspaces (max (- right-space (length right)) 1 0)))
          (concat left (make-string lspaces  ?\s)
                  center
                  (make-string rspaces ?\s)
                  right)))
    (error (format "[%s]: (%s) (%s) (%s)" err left center right))))

(defun formatted-mode-name ()
  (downcase (cond ((and (listp mode-name)
                        (listp (car mode-name))
                        (member "HTML+" (car mode-name))) "html+")
                  ((and (listp mode-name)
                        (member "JavaScript" mode-name)) "javascript")
                  ((and (listp mode-name)
                        (member "JSON" mode-name)) "json")
                  ((and (listp mode-name)
                        (member "ELisp" mode-name)) "elisp")
                  (t mode-name))))

;; Render a simple modeline: file name, mode name, modification indicator, line and
;; column indicator.
(setq-default mode-line-format
              '((:eval (custom-mode-line-render
                        (concat (format-mode-line "%b ")
                                (concat "(" (formatted-mode-name) ")")
                                (if (and (buffer-modified-p) (not buffer-read-only))
                                    " [+]"
                                  ""))
                        ""
                        (format-mode-line "%l,%c")
                        1
                        20))))

;; Scroll before reaching the frame edge.
(setq scroll-conservatively 10)
(setq scroll-margin 15)

;; --------
;; Behavior
;; --------

;; Display minibuffer completions vertically.
(fido-vertical-mode +1)

;; Match completions using the following algorithms:
;; basic - Something between fuzzy and substring matching.
;; partial-completion - Use the query as a series of arbitrary length prefixes.
;; initials - Use the query as single letters composing a set of prefixes.
;; substring - Match a substring of the query.
(setq completion-styles '(basic partial-completion initials substring))

;; Show more information about completions.
(setq completions-detailed t)

;; Show previously used completions first.
(setq completions-sort 'historical)

;; Don't wait to display completions.
(setq icomplete-compute-delay 0)

;; Don't redraw vterm for the minibuffer. Prevents flickering in TUIs.
(advice-add 'vterm--window-adjust-process-window-size :around
			(lambda (orig-fun &rest args)
			  (unless (active-minibuffer-window)
				(apply orig-fun args))))

;; Indent using four-space tabs.
(setq-default tab-width 4)
(indent-tabs-mode +1)

;; Improve dired output:
;; F - Add indicators to different types of file.
;; G - Don't show the group that owns the file.
;; h - Show human readable file sizes.
(setq dired-listing-switches "-aFGhl --group-directories-first")

;; Don't play a sound when encountering an error or an impossible action.
(setq ring-bell-function 'ignore)

;; End sentences with one space, not two.
(setq sentence-end-double-space nil)

;; Ensure all files end with a trailing newline.
(setq require-final-newline t)

;; Trim trailing whitespace on save.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Refresh files from disk when they update, using the system interface rather
;; than polling.
(setq auto-revert-avoid-polling t)
(setq auto-revert-interval 5)
(setq auto-revert-check-vc-info t)
(global-auto-revert-mode +1)

;; Treat CamelCase words as separate.
(global-subword-mode +1)

;; Wrap files at 80 characters.
(setq-default fill-column 80)

;; Always follow symlinks.
(setq vc-follow-symlinks t)

;; Always accept abbreviated answers "y" and "n" instead of "yes" and "no".
(setq use-short-answers t)

;; Integrate with the system clipboard.
(setq select-enable-clipboard t)
(setq save-interprogram-paste-before-kill t)

;; Do not save duplicates to the clipboard.
(setq kill-do-not-save-duplicates t)

;; Always assume left-to-right text.
(setq-default bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; Use aspell for spellcheck and load from a custom directory.
(setq ispell-program-name "aspell")
(let* ((conf-val (getenv "ASPELL_CONF"))
       (dir-path (nth 1 (split-string conf-val " " t))))
  (setq ispell-personal-dictionary (concat dir-path "/.aspell.en.pws")))

;; Search across a project with Ripgrep.
(setq xref-search-program 'ripgrep)

;; ---------
;; Languages
;; ---------

;; Indent with four-space tabs in (nearly) all languages.

(add-hook 'sgml-mode-hook (lambda ()
                            (indent-tabs-mode +1)
                            (setq-local tab-width 4)
                            (setq-local sgml-basic-offset 4)))
(add-hook 'ruby-mode-hook (lambda ()
                            (indent-tabs-mode +1)
                            (setq-local tab-width 4)
                            (setq-local ruby-indent-tabs-mode t)
                            (setq-local ruby-indent-level 4)))
(add-hook 'c-mode-hook (lambda ()
                         (indent-tabs-mode +1)
                         (setq-local tab-width 4)
                         (setq-local c-basic-offset 4)))
(add-hook 'c++-mode-hook (lambda ()
                           (indent-tabs-mode +1)
                           (setq-local tab-width 4)
                           (setq-local c-basic-offset 4)
                           (c-set-offset 'innamespace 0)))
(add-hook 'rust-mode-hook (lambda ()
                            (indent-tabs-mode +1)
                            (setq-local tab-width 4)
                            (setq-local rust-indent-offset 4)))

;; Indent with spaces in Emacs Lisp mode.
(add-hook 'emacs-lisp-mode-hook (lambda () (indent-tabs-mode -1)))


;; -- Python -- ;;

;; Use TreeSitter.
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-ts-mode))

;; Use Ty as the LSP server.
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `((python-ts-mode) "uv" "run" "ty" "server")))

;; Use Ruff as the formatter.
(with-eval-after-load 'apheleia
  (setf (alist-get 'ruff apheleia-formatters)
        '("uv" "run" "ruff" "format" "--stdin-filename" filepath "-"))
  (setf (alist-get 'ruff-isort apheleia-formatters)
        '("uv" "run" "ruff" "check" "--select" "I" "--fix" "--stdin-filename" filepath "-"))
  (setf (alist-get 'python-ts-mode apheleia-mode-alist) '(ruff-isort ruff)))


(add-hook 'python-ts-mode-hook
          (lambda ()
            ;; Use LSP.
            (eglot-ensure)

            ;; Indent with four-space tabs.
            (indent-tabs-mode +1)
            (setq-local tab-width 4)
            (setq-local python-indent-offset 4)

            ;; Format on save.
            (apheleia-mode +1)
            ))

;; -- TypeScript -- ;;

;; Use TreeSitter.
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

;; Use LSP with typescript-language-server.
(add-hook 'typescript-ts-mode-hook
          (lambda ()
            (eglot-ensure)))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((typescript-ts-mode)
                 "typescript-language-server" "--stdio")))

;; Indent with four-space tabs.
(add-hook 'typescript-ts-mode-hook
          (lambda ()
            (indent-tabs-mode +1)
            (setq-local tab-width 4)
            (setq-local typescript-ts-mode-indent-offset 4)))

;; Format on save with Biome.
(with-eval-after-load 'apheleia
  (setf (alist-get 'typescript-ts-mode apheleia-mode-alist) 'biome))

(add-hook 'typescript-ts-mode-hook
          (lambda ()
            (apheleia-mode +1)))

;; -- Svelte -- ;;

(add-to-list 'auto-mode-alist '("\\.svelte\\'" . svelte-ts-mode))

(with-eval-after-load 'svelte-ts-mode
  (setq svelte-ts-mode-ts-languages '(svelte typescript css html)))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((svelte-ts-mode)
                 "svelteserver" "--stdio")))

(add-hook 'svelte-ts-mode-hook
          (lambda ()
            (eglot-ensure)))

(add-hook 'svelte-ts-mode-hook
          (lambda ()
            (indent-tabs-mode +1)
            (setq-local tab-width 4)
            (setq-local svelte-ts-mode-indent-offset 4)
            (setq-local js-ts-mode-indent-offset 4)
            (setq-local typescript-ts-mode-indent-offset 4)
            (setq-local css-indent-offset 4)
            (setq-local sgml-basic-offset 4)))

(with-eval-after-load 'apheleia
  (setf (alist-get 'svelte-ts-mode apheleia-mode-alist) 'biome))

(add-hook 'svelte-ts-mode-hook
          (lambda ()
            (apheleia-mode +1)))

;; -- Markdown -- ;;

(add-hook 'markdown-mode-hook
          (lambda ()
            ;; Wrap text at 90 characters.
            (setq-local fill-column 90)

            ;; Use a sans serif font and a bar cursor.
            (variable-pitch-mode +1)
            (setq-local line-spacing variable-pitch-line-spacing)
            (setq-local cursor-type 'bar)

            ;; Use spellcheck.
            (flyspell-mode +1)

            ;; Center the viewport.
            (olivetti-mode +1)
            ))

;; Highlight code snippets with the appropriate major mode.
(setq markdown-fontify-code-blocks-natively t)

;; -- YAML -- ;;

;; Use TreeSitter.
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))

;; Use LSP with yaml-language-server.
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(yaml-ts-mode . ("yaml-language-server" "--stdio"))))

;; Indent with two spaces.
(add-hook 'yaml-ts-mode-hook
          (lambda ()
            (indent-tabs-mode -1)
            (setq-local tab-width 2)))

;; Format on save.
(add-hook 'yaml-ts-mode-hook
          (lambda ()
            (eglot-ensure)
            (add-hook 'before-save-hook 'eglot-format nil t)))

;; --------
;; Projects
;; --------

(defun project-vterm ()
  "Open a vterm buffer in the current project."
  (interactive)
  (let* ((project (project-current t))
         (default-directory (project-root project))
         (vterm-buffer-name (format "*vterm %s*" (project-name project))))
    (vterm vterm-buffer-name)))

;; -----------
;; Keybindings
;; -----------

;; Kill the current buffer.
(define-key global-map (kbd "C-x x") 'kill-current-buffer)

;; Jump to a sequence of two characters on screen.
(define-key global-map (kbd "C-c j") 'avy-goto-char-2)

;; Open a file from the current project.
(define-key global-map (kbd "C-c p f") 'project-find-file)

;; Open a shell in the current project.
(define-key global-map (kbd "C-c p t") 'project-vterm)

;; Search the current project.
(define-key global-map (kbd "C-c p s") 'project-find-regexp)

;; Move between compiler errors.
(define-key global-map (kbd "C-c t n") 'flymake-goto-next-error)
(define-key global-map (kbd "C-c t p") 'flymake-goto-prev-error)

;; Manage the current git repository.
(define-key global-map (kbd "C-c g s") 'magit-status)

;; View git blame for the current file.
(define-key global-map (kbd "C-c g b") 'magit-blame)

(with-eval-after-load 'magit
  ;; Open diffs in the other window.
  (define-key magit-file-section-map (kbd "RET") 'magit-diff-visit-file-other-window)
  (define-key magit-hunk-section-map (kbd "RET") 'magit-diff-visit-file-other-window)

  ;; Open diffs in the same window.
  (define-key magit-file-section-map (kbd "M-RET") 'magit-diff-visit-file)
  (define-key magit-hunk-section-map (kbd "M-RET") 'magit-diff-visit-file))

(setq mesa--font-lock-defaults
      '(("\\_<\\(module\\|import\\|export\\|type\\|proto\\|impl\\|case\\|extern\\|def\\|each\\|loop\\|do\\|in\\|when\\|then\\|else\\|rescue\\|end\\|return\\|break\\|raise\\|and\\|or\\|not\\)\\_>" . 'font-lock-keyword-face)
        ("[A-Z][a-zA-Z]*" . 'font-lock-type-face)
        (":[a-zA-Z_?!]+" . 'font-lock-constant-face)
        ("@[a-zA-Z_?!]+" . 'font-lock-constant-face)
        ("nil\\|true\\|false" . 'font-lock-constant-face)
        ("[0-9]\\(\\.[0-9]+\\)?" . 'font-lock-number-face)))

(defvar mesa-mode-syntax-table
  (let ((table (make-syntax-table)))
	(modify-syntax-entry ?\# "<" table)
	(modify-syntax-entry ?\n ">" table)
	(modify-syntax-entry ?\" "\"" table)
	(modify-syntax-entry ?' "/" table)
    table))

(define-derived-mode mesa-mode prog-mode "Mesa"
  ""
  (set-syntax-table mesa-mode-syntax-table)
  (setq font-lock-defaults '(mesa--font-lock-defaults)))

(add-to-list 'auto-mode-alist '("\\.ms\\'" . mesa-mode))
