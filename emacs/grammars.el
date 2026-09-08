(add-to-list 'treesit-language-source-alist
             '(python "https://github.com/tree-sitter/tree-sitter-python"))

(let ((grammars '(python)))
  (dolist (grammar grammars)
    (unless (treesit-language-available-p grammar)
      (treesit-install-language-grammar grammar))))
