(defconst paper-theme-palette
  '((white . "#ffffff")
    (white-bright . "#e7e7e7")
    (red . "#721045")
    (red-bright . "#d00000")
    (green . "#006800")
    (yellow . "#6f5500")
    (yellow-bright . "#f3d000")
    (blue . "#0031a9")
    (blue-bright . "#354fcf")
    (magenta . "#8f0075")
    (magenta-bright . "#531ab6")
    (cyan . "#005e8b")
    (cyan-bright . "#c0deff")
    (black . "#000000")
    (black-bright . "#595959")

    (mode-line-active-bg . "#c8c8c8")
    (mode-line-active-border . "#5a5a5a")
    (mode-line-inactive-bg . "#e6e6e6")
    (mode-line-inactive-fg . "#585858")
    (mode-line-inactive-border . "#a3a3a3")
    (mode-line-hover-bg . "#b2e4dc")
    (mode-line-info . "#002580")
    (completion-bg . cyan-bright)
    (code-bg . "#f3f3f3")
    (completion-match . blue)
    (completion-discriminator . magenta)
    (keyword . magenta-bright)
    (type . cyan)
    (constant . blue-bright)
    (variable . black)
    (string . blue-bright)
    (number . blue-bright)
    (function . red)
    (operator . black)
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

(defun paper-theme-color (name)
  "Return the color string associated with NAME in `paper-theme-palette`."
  (let ((value (alist-get name paper-theme-palette)))
    (if (and value (symbolp value))
        (paper-theme-color value)
      value)))

(deftheme paper
  "")

(custom-theme-set-faces
 'paper
 `(default ((t (:background ,(paper-theme-color 'white)
                :foreground ,(paper-theme-color 'black)))))
 `(region ((t (:background ,(paper-theme-color 'region)))))
 `(hl-line ((t (:background ,(paper-theme-color 'region)))))
 `(error ((t (:foreground ,(paper-theme-color 'red-bright) :weight bold))))
 `(flymake-error
   ((t (:underline (:style wave :color ,(paper-theme-color 'red-bright))))))
 `(flymake-warning
   ((t (:underline (:style wave :color ,(paper-theme-color 'red-bright))))))
 `(flymake-note
   ((t (:underline (:style wave :color ,(paper-theme-color 'red-bright))))))
 `(isearch
   ((t (:background ,(paper-theme-color 'search-current)
        :foreground ,(paper-theme-color 'black)))))
 `(lazy-highlight
   ((t (:background ,(paper-theme-color 'search-alternative)
        :foreground ,(paper-theme-color 'black)))))
 `(minibuffer-prompt ((t (:foreground ,(paper-theme-color 'prompt)))))
 `(completions-common-part
   ((t (:foreground ,(paper-theme-color 'completion-match) :weight bold))))
 `(completions-first-difference
   ((t (:foreground ,(paper-theme-color 'completion-discriminator)
        :weight bold))))
 `(completions-highlight
   ((t (:background ,(paper-theme-color 'completion-bg) :weight bold))))
 `(icomplete-first-match
   ((t (:foreground ,(paper-theme-color 'completion-match) :weight bold))))
 `(icomplete-selected-match
   ((t (:background ,(paper-theme-color 'completion-bg) :weight bold))))
 `(show-paren-match
   ((t (:background ,(paper-theme-color 'paren-match)
        :foreground ,(paper-theme-color 'black)))))
 `(show-paren-match-expression
   ((t (:background ,(paper-theme-color 'paren-match)
        :foreground ,(paper-theme-color 'black)))))
 `(mode-line
   ((t (:background ,(paper-theme-color 'mode-line-active-bg)
        :foreground ,(paper-theme-color 'black)
        :box ,(paper-theme-color 'mode-line-active-border)))))
 `(mode-line-active
   ((t (:background ,(paper-theme-color 'mode-line-active-bg)
        :foreground ,(paper-theme-color 'black)
        :box ,(paper-theme-color 'mode-line-active-border)))))
 `(mode-line-inactive
   ((t (:background ,(paper-theme-color 'mode-line-inactive-bg)
        :foreground ,(paper-theme-color 'mode-line-inactive-fg)
        :box ,(paper-theme-color 'mode-line-inactive-border)))))
 `(mode-line-buffer-id ((t (:inherit bold))))
 `(mode-line-emphasis
   ((t (:inherit italic :foreground ,(paper-theme-color 'mode-line-info)))))
 `(mode-line-highlight
   ((t (:background ,(paper-theme-color 'mode-line-hover-bg)
        :foreground ,(paper-theme-color 'black)
        :box ,(paper-theme-color 'black)))))
 `(dired-directory ((t (:foreground ,(paper-theme-color 'directory)))))
 `(dired-header ((t (:foreground ,(paper-theme-color 'directory-header)))))
 `(dired-symlink ((t (:foreground ,(paper-theme-color 'cyan)))))
 `(markdown-code-face
   ((t (:background ,(paper-theme-color 'code-bg) :extend t))))
 `(markdown-language-keyword-face
   ((t (:background ,(paper-theme-color 'white)
        :foreground ,(paper-theme-color 'black)))))
 `(markdown-inline-code-face
   ((t (:inherit fixed-pitch
        :foreground ,(paper-theme-color 'cyan)
        :background unspecified :extend nil))))
 `(markdown-pre-face
   ((t (:background ,(paper-theme-color 'code-bg) :extend t))))
 `(markdown-table-face
   ((t (:inherit fixed-pitch :background unspecified :extend nil))))
 `(markdown-header-face
   ((t (:foreground ,(paper-theme-color 'black) :weight bold))))
 `(markdown-header-face-1
   ((t (:foreground ,(paper-theme-color 'black) :weight bold))))
 `(markdown-header-face-2
   ((t (:foreground ,(paper-theme-color 'black) :weight bold))))
 `(markdown-header-face-3
   ((t (:foreground ,(paper-theme-color 'black) :weight bold))))
 `(markdown-header-face-4
   ((t (:foreground ,(paper-theme-color 'black) :weight bold))))
 `(markdown-header-face-5
   ((t (:foreground ,(paper-theme-color 'black) :weight bold))))
 `(markdown-header-face-6
   ((t (:foreground ,(paper-theme-color 'black) :weight bold))))
 `(font-lock-keyword-face
   ((t (:foreground ,(paper-theme-color 'keyword) :weight normal))))
 `(font-lock-type-face ((t (:foreground ,(paper-theme-color 'type)))))
 `(font-lock-variable-name-face
   ((t (:foreground ,(paper-theme-color 'variable)))))
 `(sh-quoted-exec ((t (:foreground ,(paper-theme-color 'black)))))
 `(font-lock-constant-face
   ((t (:foreground ,(paper-theme-color 'constant)))))
 `(font-lock-string-face ((t (:foreground ,(paper-theme-color 'string)))))
 `(font-lock-escape-face ((t (:inherit font-lock-string-face))))
 `(font-lock-number-face ((t (:foreground ,(paper-theme-color 'number)))))
 `(font-lock-function-name-face
   ((t (:foreground ,(paper-theme-color 'function)))))
 `(font-lock-operator-face
   ((t (:foreground ,(paper-theme-color 'operator)))))
 `(font-lock-punctuation-face
   ((t (:foreground ,(paper-theme-color 'operator)))))
 `(font-lock-builtin-face ((t (:foreground ,(paper-theme-color 'builtin)))))
 `(font-lock-preprocessor-face
   ((t (:foreground ,(paper-theme-color 'builtin)))))
 `(font-lock-comment-face
   ((t (:foreground ,(paper-theme-color 'comment)))))
 `(font-lock-comment-delimiter-face
   ((t (:foreground ,(paper-theme-color 'comment)))))
 `(font-lock-doc-face
   ((t (:foreground ,(paper-theme-color 'doc))))))

(with-eval-after-load 'sgml-mode
  (custom-theme-set-variables
   'paper
   '(html-tag-face-alist nil))
  (when (memq 'paper custom-enabled-themes)
    (enable-theme 'paper)))

(provide-theme 'paper)
