;;; canvas.el --- Shared faces for the canvas themes -*- lexical-binding: t -*-

(require 'cl-lib)

(defun canvas-color (palette name)
  "Return the color string for NAME in PALETTE, following aliases."
  (let ((value (alist-get name palette)))
    (if (and value (symbolp value))
        (canvas-color palette value)
      value)))

(defun canvas-apply (theme palette)
  "Apply the shared faces and variables to THEME using colors from PALETTE."
  (cl-flet ((c (name) (canvas-color palette name)))
    (custom-theme-set-faces
     theme
     `(default ((t (:background ,(c 'background)
                    :foreground ,(c 'foreground)))))
     `(region ((t (:background ,(c 'region)))))
     `(hl-line ((t (:background ,(c 'region)))))
     `(error ((t (:foreground ,(c 'red-bright) :weight bold))))
     `(flymake-error
       ((t (:underline (:style wave :color ,(c 'red-bright))))))
     `(flymake-warning
       ((t (:underline (:style wave :color ,(c 'red-bright))))))
     `(flymake-note
       ((t (:underline (:style wave :color ,(c 'red-bright))))))
     `(flyspell-incorrect
       ((t (:underline (:style wave :color ,(c 'red-bright))))))
     `(flyspell-duplicate
       ((t (:underline (:style wave :color ,(c 'yellow))))))
     `(isearch
       ((t (:background ,(c 'search-current)
            :foreground ,(c 'foreground)))))
     `(lazy-highlight
       ((t (:background ,(c 'search-alternative)
            :foreground ,(c 'foreground)))))
     `(minibuffer-prompt ((t (:foreground ,(c 'prompt)))))
     `(completions-common-part
       ((t (:foreground ,(c 'completion-match) :weight bold))))
     `(completions-first-difference
       ((t (:foreground ,(c 'completion-discriminator)
            :weight bold))))
     `(highlight
       ((t (:background ,(c 'completion-bg) :weight bold))))
     `(completions-highlight
       ((t (:background ,(c 'completion-bg) :weight bold))))
     `(icomplete-first-match
       ((t (:foreground ,(c 'completion-match) :weight bold))))
     `(icomplete-selected-match
       ((t (:background ,(c 'completion-bg) :weight bold))))
     `(show-paren-match
       ((t (:background ,(c 'paren-match)
            :foreground ,(c 'foreground)))))
     `(show-paren-match-expression
       ((t (:background ,(c 'paren-match)
            :foreground ,(c 'foreground)))))
     `(mode-line
       ((t (:background ,(c 'mode-line-active-bg)
            :foreground ,(c 'foreground)
            :box ,(c 'mode-line-active-border)))))
     `(mode-line-active
       ((t (:background ,(c 'mode-line-active-bg)
            :foreground ,(c 'foreground)
            :box ,(c 'mode-line-active-border)))))
     `(mode-line-inactive
       ((t (:background ,(c 'mode-line-inactive-bg)
            :foreground ,(c 'mode-line-inactive-fg)
            :box ,(c 'mode-line-inactive-border)))))
     `(mode-line-buffer-id ((t (:inherit bold))))
     `(mode-line-emphasis
       ((t (:inherit italic :foreground ,(c 'mode-line-info)))))
     `(mode-line-highlight
       ((t (:background ,(c 'mode-line-hover-bg)
            :foreground ,(c 'foreground)
            :box ,(c 'black)))))
     `(dired-directory ((t (:foreground ,(c 'directory)))))
     `(dired-header ((t (:foreground ,(c 'heading) :weight bold))))
     `(dired-symlink ((t (:foreground ,(c 'cyan)))))
     `(diff-header ((t (:background ,(c 'code-bg)))))
     `(diff-file-header ((t (:inherit diff-header :weight bold))))
     `(diff-added
       ((t (:background ,(c 'diff-added-bg)
            :foreground ,(c 'diff-added-fg) :extend t))))
     `(diff-removed
       ((t (:background ,(c 'diff-removed-bg)
            :foreground ,(c 'diff-removed-fg) :extend t))))
     `(diff-refine-added ((t (:background ,(c 'diff-added-refine-bg)))))
     `(diff-refine-removed ((t (:background ,(c 'diff-removed-refine-bg)))))
     `(diff-indicator-added ((t (:inherit diff-added))))
     `(diff-indicator-removed ((t (:inherit diff-removed))))
     `(magit-section-heading
       ((t (:foreground ,(c 'heading) :weight bold))))
     `(magit-section-highlight ((t (:background unspecified))))
     `(magit-section-heading-selection
       ((t (:background ,(c 'completion-bg) :extend t))))
     `(magit-diff-file-heading-selection
       ((t (:background ,(c 'completion-bg) :extend t))))
     `(magit-diff-hunk-heading
       ((t (:background ,(c 'code-bg) :foreground ,(c 'comment) :extend t))))
     `(magit-diff-hunk-heading-highlight
       ((t (:background ,(c 'region) :extend t))))
     `(magit-diff-hunk-heading-selection
       ((t (:background ,(c 'completion-bg) :extend t))))
     `(magit-diff-lines-heading
       ((t (:background ,(c 'completion-bg) :extend t))))
     `(magit-diff-context ((t (:foreground unspecified :extend t))))
     `(magit-diff-context-highlight ((t (:background unspecified))))
     `(magit-diff-added ((t (:inherit diff-added))))
     `(magit-diff-added-highlight ((t (:inherit diff-added))))
     `(magit-diff-removed ((t (:inherit diff-removed))))
     `(magit-diff-removed-highlight ((t (:inherit diff-removed))))
     `(magit-diffstat-added ((t (:foreground ,(c 'diff-added-fg)))))
     `(magit-diffstat-removed ((t (:foreground ,(c 'diff-removed-fg)))))
     `(magit-branch-local ((t (:foreground ,(c 'blue)))))
     `(magit-branch-remote ((t (:foreground ,(c 'magenta)))))
     `(magit-tag ((t (:foreground ,(c 'yellow)))))
     `(magit-hash ((t (:foreground ,(c 'comment)))))
     `(magit-refname ((t (:foreground ,(c 'comment)))))
     `(magit-dimmed ((t (:foreground ,(c 'comment)))))
     `(magit-log-graph ((t (:foreground ,(c 'comment)))))
     `(magit-log-date ((t (:foreground ,(c 'comment)))))
     `(magit-log-author ((t (:foreground unspecified))))
     `(magit-blame-highlight ((t (:background ,(c 'region) :extend t))))
     `(magit-process-ok ((t (:foreground ,(c 'green) :weight bold))))
     `(magit-process-ng ((t (:foreground ,(c 'red-bright) :weight bold))))
     `(markdown-code-face
       ((t (:background ,(c 'code-bg) :extend t))))
     `(markdown-language-keyword-face
       ((t (:background ,(c 'background)
            :foreground ,(c 'foreground)))))
     `(markdown-inline-code-face
       ((t (:inherit fixed-pitch
            :foreground ,(c 'inline-code)
            :background unspecified :extend nil))))
     `(markdown-pre-face
       ((t (:background ,(c 'code-bg) :extend t))))
     `(markdown-table-face
       ((t (:inherit fixed-pitch :background unspecified :extend nil))))
     `(markdown-header-face
       ((t (:foreground ,(c 'heading) :weight bold))))
     `(markdown-header-face-1
       ((t (:foreground ,(c 'heading) :weight bold))))
     `(markdown-header-face-2
       ((t (:foreground ,(c 'heading) :weight bold))))
     `(markdown-header-face-3
       ((t (:foreground ,(c 'heading) :weight bold))))
     `(markdown-header-face-4
       ((t (:foreground ,(c 'heading) :weight bold))))
     `(markdown-header-face-5
       ((t (:foreground ,(c 'heading) :weight bold))))
     `(markdown-header-face-6
       ((t (:foreground ,(c 'heading) :weight bold))))
     `(font-lock-keyword-face
       ((t (:foreground ,(c 'keyword) :weight normal))))
     `(font-lock-type-face ((t (:foreground ,(c 'type)))))
     `(font-lock-variable-name-face
       ((t (:foreground ,(c 'variable)))))
     `(sh-quoted-exec ((t (:foreground ,(c 'foreground)))))
     `(font-lock-constant-face
       ((t (:foreground ,(c 'constant)))))
     `(font-lock-string-face ((t (:foreground ,(c 'string)))))
     `(font-lock-escape-face ((t (:inherit font-lock-string-face))))
     `(font-lock-number-face ((t (:foreground ,(c 'number)))))
     `(font-lock-function-name-face
       ((t (:foreground ,(c 'function)))))
     `(font-lock-operator-face
       ((t (:foreground ,(c 'operator)))))
     `(font-lock-punctuation-face
       ((t (:foreground ,(c 'operator)))))
     `(font-lock-builtin-face ((t (:foreground ,(c 'builtin)))))
     `(font-lock-preprocessor-face
       ((t (:foreground ,(c 'builtin)))))
     `(font-lock-comment-face
       ((t (:foreground ,(c 'comment)))))
     `(font-lock-comment-delimiter-face
       ((t (:foreground ,(c 'comment)))))
     `(font-lock-doc-face
       ((t (:foreground ,(c 'doc)))))
     `(eglot-semantic-declaration ((t (:inherit nil))))
     `(eglot-semantic-definition ((t (:inherit nil))))
     `(eglot-semantic-namespace
       ((t (:inherit nil :foreground ,(c 'foreground)))))))
  (with-eval-after-load 'sgml-mode
    (custom-theme-set-variables
     theme
     '(html-tag-face-alist nil))
    (when (memq theme custom-enabled-themes)
      (enable-theme theme))))

(provide 'canvas)
