(defconst chalk-theme-palette
  '((white . "#ffffff")
    (white-bright . "#1e1e1e")
    (red . "#feacd0")
    (red-bright . "#d00000")
    (green . "#44bc44")
    (yellow . "#d0bc00")
    (yellow-bright . yellow)
    (blue . "#79a8ff")
    (blue-bright . blue)
    (magenta . "#b6a0ff")
    (magenta-bright . magenta)
    (cyan . "#6ae4b9")
    (cyan-bright . cyan)
    (black . "#000000")
    (black-bright . "#989898")

    (mode-line-active-bg . black)
    (mode-line-active-border . black-bright)
    (mode-line-inactive-bg . white-bright)
    (mode-line-inactive-fg . black-bright)
    (mode-line-inactive-border . black)
    (mode-line-hover-bg . cyan)
    (mode-line-info . blue)
    (completion-bg . cyan)
    (code-bg . black)
    (completion-match . blue)
    (completion-discriminator . magenta)
    (keyword . magenta-bright)
    (type . cyan)
    (constant . blue-bright)
    (variable . white)
    (string . blue-bright)
    (number . blue-bright)
    (function . red)
    (operator . white)
    (builtin . magenta)
    (comment . black-bright)
    (doc . black-bright)
    (region . white-bright)
    (search-current . yellow-bright)
    (search-alternative . region)
    (prompt . cyan)
    (paren-match . completion-bg)
    (directory . blue)
    (directory-header . red))
  "")

(defun chalk-theme-color (name)
  "Return the color string associated with NAME in `chalk-theme-palette`."
  (let ((value (alist-get name chalk-theme-palette)))
    (if (and value (symbolp value))
        (chalk-theme-color value)
      value)))

(deftheme chalk
  "")

(custom-theme-set-faces
 'chalk
 `(default ((t (:background ,(chalk-theme-color 'black)
                :foreground ,(chalk-theme-color 'white)))))
 `(region ((t (:background ,(chalk-theme-color 'region)))))
 `(hl-line ((t (:background ,(chalk-theme-color 'region)))))
 `(error ((t (:foreground ,(chalk-theme-color 'red-bright) :weight bold))))
 `(flymake-error
   ((t (:underline (:style wave :color ,(chalk-theme-color 'red-bright))))))
 `(flymake-warning
   ((t (:underline (:style wave :color ,(chalk-theme-color 'red-bright))))))
 `(flymake-note
   ((t (:underline (:style wave :color ,(chalk-theme-color 'red-bright))))))
 `(isearch
   ((t (:background ,(chalk-theme-color 'search-current)
        :foreground ,(chalk-theme-color 'white)))))
 `(lazy-highlight
   ((t (:background ,(chalk-theme-color 'search-alternative)
        :foreground ,(chalk-theme-color 'white)))))
 `(minibuffer-prompt ((t (:foreground ,(chalk-theme-color 'prompt)))))
 `(completions-common-part
   ((t (:foreground ,(chalk-theme-color 'completion-match) :weight bold))))
 `(completions-first-difference
   ((t (:foreground ,(chalk-theme-color 'completion-discriminator)
        :weight bold))))
 `(completions-highlight
   ((t (:background ,(chalk-theme-color 'completion-bg) :weight bold))))
 `(icomplete-first-match
   ((t (:foreground ,(chalk-theme-color 'completion-match) :weight bold))))
 `(icomplete-selected-match
   ((t (:background ,(chalk-theme-color 'completion-bg) :weight bold))))
 `(show-paren-match
   ((t (:background ,(chalk-theme-color 'paren-match)
        :foreground ,(chalk-theme-color 'white)))))
 `(show-paren-match-expression
   ((t (:background ,(chalk-theme-color 'paren-match)
        :foreground ,(chalk-theme-color 'white)))))
 `(mode-line
   ((t (:background ,(chalk-theme-color 'mode-line-active-bg)
        :foreground ,(chalk-theme-color 'white)
        :box ,(chalk-theme-color 'mode-line-active-border)))))
 `(mode-line-active
   ((t (:background ,(chalk-theme-color 'mode-line-active-bg)
        :foreground ,(chalk-theme-color 'white)
        :box ,(chalk-theme-color 'mode-line-active-border)))))
 `(mode-line-inactive
   ((t (:background ,(chalk-theme-color 'mode-line-inactive-bg)
        :foreground ,(chalk-theme-color 'mode-line-inactive-fg)
        :box ,(chalk-theme-color 'mode-line-inactive-border)))))
 `(mode-line-buffer-id ((t (:inherit bold))))
 `(mode-line-emphasis
   ((t (:inherit italic :foreground ,(chalk-theme-color 'mode-line-info)))))
 `(mode-line-highlight
   ((t (:background ,(chalk-theme-color 'mode-line-hover-bg)
        :foreground ,(chalk-theme-color 'white)
        :box ,(chalk-theme-color 'black)))))
 `(dired-directory ((t (:foreground ,(chalk-theme-color 'directory)))))
 `(dired-header ((t (:foreground ,(chalk-theme-color 'directory-header)))))
 `(dired-symlink ((t (:foreground ,(chalk-theme-color 'cyan)))))
 `(markdown-code-face
   ((t (:background ,(chalk-theme-color 'code-bg) :extend t))))
 `(markdown-language-keyword-face
   ((t (:background ,(chalk-theme-color 'black)
        :foreground ,(chalk-theme-color 'white)))))
 `(markdown-inline-code-face
   ((t (:inherit fixed-pitch
        :foreground ,(chalk-theme-color 'blue-bright)
        :background unspecified :extend nil))))
 `(markdown-pre-face
   ((t (:background ,(chalk-theme-color 'code-bg) :extend t))))
 `(markdown-table-face
   ((t (:inherit fixed-pitch :background unspecified :extend nil))))
 `(markdown-header-face
   ((t (:foreground ,(chalk-theme-color 'white) :weight bold))))
 `(markdown-header-face-1
   ((t (:foreground ,(chalk-theme-color 'white) :weight bold))))
 `(markdown-header-face-2
   ((t (:foreground ,(chalk-theme-color 'white) :weight bold))))
 `(markdown-header-face-3
   ((t (:foreground ,(chalk-theme-color 'white) :weight bold))))
 `(markdown-header-face-4
   ((t (:foreground ,(chalk-theme-color 'white) :weight bold))))
 `(markdown-header-face-5
   ((t (:foreground ,(chalk-theme-color 'white) :weight bold))))
 `(markdown-header-face-6
   ((t (:foreground ,(chalk-theme-color 'white) :weight bold))))
 `(font-lock-keyword-face
   ((t (:foreground ,(chalk-theme-color 'keyword) :weight normal))))
 `(font-lock-type-face ((t (:foreground ,(chalk-theme-color 'type)))))
 `(font-lock-variable-name-face
   ((t (:foreground ,(chalk-theme-color 'variable)))))
 `(sh-quoted-exec ((t (:foreground ,(chalk-theme-color 'white)))))
 `(font-lock-constant-face
   ((t (:foreground ,(chalk-theme-color 'constant)))))
 `(font-lock-string-face ((t (:foreground ,(chalk-theme-color 'string)))))
 `(font-lock-escape-face ((t (:inherit font-lock-string-face))))
 `(font-lock-number-face ((t (:foreground ,(chalk-theme-color 'number)))))
 `(font-lock-function-name-face
   ((t (:foreground ,(chalk-theme-color 'function)))))
 `(font-lock-operator-face
   ((t (:foreground ,(chalk-theme-color 'operator)))))
 `(font-lock-punctuation-face
   ((t (:foreground ,(chalk-theme-color 'operator)))))
 `(font-lock-builtin-face ((t (:foreground ,(chalk-theme-color 'builtin)))))
 `(font-lock-preprocessor-face
   ((t (:foreground ,(chalk-theme-color 'builtin)))))
 `(font-lock-comment-face
   ((t (:foreground ,(chalk-theme-color 'comment)))))
 `(font-lock-comment-delimiter-face
   ((t (:foreground ,(chalk-theme-color 'comment)))))
 `(font-lock-doc-face
   ((t (:foreground ,(chalk-theme-color 'doc))))))

(with-eval-after-load 'sgml-mode
  (custom-theme-set-variables
   'chalk
   '(html-tag-face-alist nil))
  (when (memq 'chalk custom-enabled-themes)
    (enable-theme 'chalk)))

(provide-theme 'chalk)
