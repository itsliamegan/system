;; -------
;; Startup
;; -------

;; Store user customizations in a separate file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; Store custom themes in a subdirectory.
(setq custom-theme-directory (expand-file-name "themes" user-emacs-directory))

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
                'modus-vivendi
              'modus-operandi))

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

;; Don't wait to display completions.
(setq icomplete-compute-delay 0)

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

;; Refresh files from disk when they update.
(global-auto-revert-mode +1)

;; Treat CamelCase words as separate.
(global-subword-mode +1)

;; Wrap files at 80 characters.
(setq-default fill-column 80)

;; Always follow symlinks.
(setq vc-follow-symlinks t)

;; Always accept abbreviated answers "y" and "n" instead of "yes" and "no".
(fset 'yes-or-no-p 'y-or-n-p)

;; ---------
;; Languages
;; ---------

;; Indent with four-space tabs in (nearly) all languages.

(add-hook 'sgml-mode-hook (lambda ()
                            (indent-tabs-mode +1)
                            (setq-local tab-width 4)
                            (setq-local sgml-basic-offset 4)))
(add-hook 'python-mode-hook (lambda ()
                              (indent-tabs-mode +1)
                              (setq-local tab-width 4)
                              (setq-local python-indent-offset 4)))
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
(add-hook 'zig-mode-hook (lambda ()
                           (indent-tabs-mode +1)
                           (setq-local tab-width 4)
                           (setq-local zig-indent-offset 4)
                           (zig-format-on-save-mode -1)))

;; Indent with spaces in Emacs Lisp mode.
(add-hook 'emacs-lisp-mode-hook (lambda () (indent-tabs-mode -1)))


;; -- Markdown Mode -- ;;

;; Center the viewport.
(add-hook 'markdown-mode-hook (lambda () (olivetti-mode)))

;; Highlight code snippets with the appropriate major mode.
(setq markdown-fontify-code-blocks-natively t)

;; -----------
;; Keybindings
;; -----------

;; Jump to a sequence of two characters on screen.
(define-key global-map (kbd "C-c j") 'avy-goto-char-2)

;; Open a file from the current git project.
(define-key global-map (kbd "C-c p") 'project-find-file)

;; Manage the current git repository.
(define-key global-map (kbd "C-c g") 'magit-status)

(setq harmony--font-lock-defaults
      '(("type\\|module\\|import\\|def\\|func\\|var\\|case\\|cond\\|match\\|do\\|end\\|if\\|else\\|and\\|or\\|not\\|return\\|print" . 'font-lock-keyword-face)
        ("[A-Z][A-Za-z]*" . 'font-lock-type-face)
        ("\".*\"" . 'font-lock-string-face)
        ("'.*'" . 'font-lock-string-face)
        (":[a-zA-Z_?!]+" . 'font-lock-constant-face)
        ("@[a-zA-Z_?!]+" . 'font-lock-constant-face)
        ("nil\\|true\\|false" . 'font-lock-constant-face)
        ("[0-9]\\(\\.[0-9]+\\)?" . 'font-lock-number-face)))

(define-derived-mode harmony-mode prog-mode "harmony"
  ""
  (setq font-lock-defaults '(harmony--font-lock-defaults)))
