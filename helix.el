;;; helix.el -*- lexical-binding: t; -*-

(custom-set-faces!
  ;; Base
  `(default :foreground "#dadada" :background "#1f1f1f")

  ;; Syntax (Tree-sitter / font-lock)
  `(font-lock-comment-face :foreground "#8a8c8e")
  `(font-lock-keyword-face :foreground "#67b0e8")
  `(font-lock-function-name-face :foreground "#e57474")
  `(font-lock-variable-name-face :foreground "#f2b5a7")
  `(font-lock-constant-face :foreground "#f2b5a7")
  `(font-lock-string-face :foreground "#8ccf7e")
  `(font-lock-number-face :foreground "#ffc285")
  `(font-lock-type-face :foreground "#4FB6B8")

  ;; Tree-sitter (modern Emacs)
  `(treesit-font-lock-variable-face :foreground "#f2b5a7")
  `(treesit-font-lock-property-face :foreground "#f2b5a7")
  `(treesit-font-lock-function-face :foreground "#e57474")
  `(treesit-font-lock-function-call-face :foreground "#e57474")
  `(treesit-font-lock-type-face :foreground "#4FB6B8")
  `(treesit-font-lock-keyword-face :foreground "#67b0e8")
  `(treesit-font-lock-string-face :foreground "#8ccf7e")
  `(treesit-font-lock-number-face :foreground "#ffc285")
  `(treesit-font-lock-operator-face :foreground "#f38ba8")
  `(treesit-font-lock-delimiter-face :foreground "#5de6a8")

  ;; LSP / Eglot
  `(eglot-highlight-symbol-face :background "#2c3333")

  ;; Diagnostics
  `(error :foreground "#e57474")
  `(warning :foreground "#e5c76b")
  `(success :foreground "#8ccf7e"))
