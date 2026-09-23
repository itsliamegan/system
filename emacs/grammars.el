(setq treesit-language-source-alist
      '((python "https://github.com/tree-sitter/tree-sitter-python")
        (yaml "https://github.com/tree-sitter-grammars/tree-sitter-yaml")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (svelte "https://github.com/tree-sitter-grammars/tree-sitter-svelte" "master" "src")))

(dolist (entry treesit-language-source-alist)
  (let ((grammar (car entry)))
    (unless (treesit-language-available-p grammar)
      (treesit-install-language-grammar grammar))))
