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

;; Load PATH from .bashrc.
(setq exec-path-from-shell-arguments '("-l" "-i"))
(exec-path-from-shell-initialize)

;; ---------
;; Interface
;; ---------

;; Hide window chrome.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode 0)

;; Maximize the window.
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Set appropriate theme based on system theme.
(setq theme (if (string= (shell-command-to-string "gsettings get org.gnome.desktop.interface color-scheme")
                         "\'prefer-dark\'\n")
                'chalk
              'paper))

;; Use an accessible, high-contrast theme.
(load-theme theme t)

;; Set appropriate font size based on screen resolution.
(setq font-size (if (> (frame-height) 50)
                    140
                  110))

;; Use a default font and line height.
(set-face-attribute 'default nil :family "DejaVu Sans Mono" :height font-size)
(add-to-list 'default-frame-alist '(line-spacing . nil))

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


;; -- Markdown -- ;;

;; Center the viewport.
(add-hook 'markdown-mode-hook (lambda () (olivetti-mode)))

;; Highlight code snippets with the appropriate major mode.
(setq markdown-fontify-code-blocks-natively t)

;; -- Python -- ;;

;; Use TreeSitter when it's available.
(when (treesit-language-available-p 'python)
  (add-to-list 'major-mode-remap-alist
               '(python-mode . python-ts-mode)))

;; Use LSP with Ruff.
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(python-base-mode . ("uv" "run" "ruff" "server"))))

;; Indent with four-space tabs.
(add-hook 'python-base-mode-hook
          (lambda ()
            (indent-tabs-mode +1)
            (setq-local tab-width 4)
            (setq-local python-indent-offset 4)))

;; Format on save.
(add-hook 'python-base-mode-hook
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
