;;; doom-helix-theme.el --- inspired by helix.nvim -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author: (your name here)
;; Maintainer: (your name here)
;; Source: helix.nvim colorscheme
;;
;;; Commentary:
;;
;; A port of the `helix.nvim` Neovim theme to Doom Emacs, built with
;; `def-doom-theme' so it plugs into all the same infrastructure as
;; `doom-one' (solaire-mode, doom-modeline, org, markdown, etc).
;;
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-helix-theme nil
  "Options for the `doom-helix' theme."
  :group 'doom-themes)

(defcustom doom-helix-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-helix-theme
  :type 'boolean)

(defcustom doom-helix-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-helix-theme
  :type 'boolean)

(defcustom doom-helix-comment-bg doom-helix-brighter-comments
  "If non-nil, comments will have a subtle highlight to enhance their
legibility."
  :group 'doom-helix-theme
  :type 'boolean)

(defcustom doom-helix-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-helix-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme doom-helix
  "A dark theme inspired by the helix.nvim colorscheme."
  :family 'doom-helix
  :background-mode 'dark

  ;; name        default   256           16
  ((bg         '("#1f1f1f" "black"       "black"        )) ; charcoal
   (fg         '("#dadada" "#d7d7d7"     "brightwhite"  )) ; foreground

   ;; solaire-mode alt bg/fg. `background' in the lua palette is the darkest
   ;; tone (used as bg_d), so it becomes our "off" background.
   (bg-alt     '("#141b1e" "black"       "black"        )) ; background
   (fg-alt     '("#7a7c7e" "#7a7a7a"     "white"        )) ; comment

   ;; Spectrum from starker bg -> starker fg
   (base0      '("#141b1e" "black"       "black"        )) ; background
   (base1      '("#2f2f2f" "#2e2e2e"     "brightblack"  )) ; light-charcoal (bg1)
   (base2      '("#232a2d" "#232323"     "brightblack"  )) ; black (bg2)
   (base3      '("#2d3437" "#2d2d2d"     "brightblack"  )) ; black-light (bg3)
   (base4      '("#505557" "#505050"     "brightblack"  )) ; grey
   (base5      '("#7a7c7e" "#7a7a7a"     "brightblack"  )) ; comment
   (base6      '("#8a8c8e" "#8a8a8a"     "brightblack"  )) ; light-comment
   (base7      '("#b3b9b8" "#b3b3b3"     "brightblack"  )) ; white
   (base8      '("#e5e5e5" "#e5e5e5"     "white"        ))

   (grey       base4)
   (red        '("#e57474" "#e57474" "red"          ))
   (orange     '("#ffc285" "#ffaa55" "brightred"    ))
   (green      '("#8ccf7e" "#8ccf7e" "green"        ))
   (teal       '("#4FB6B8" "#4fb6b8" "brightgreen"  ))
   (yellow     '("#e5c76b" "#e5c76b" "yellow"       ))
   (blue       '("#67b0e8" "#67b0e8" "brightblue"   ))
   (dark-blue  (doom-darken blue 0.3))
   (magenta    '("#c47fd5" "#c47fd5" "brightmagenta"))
   (violet     '("#c8a8e8" "#c8a8e8" "magenta"      )) ; lavender
   (cyan       '("#6cbfbf" "#6cbfbf" "brightcyan"   ))
   (dark-cyan  (doom-darken cyan 0.3))

   ;; extra accent colors from the helix palette that don't map to a
   ;; universal class but are used below for plugin-specific faces
   (peach      '("#f2b5a7" "#f2b5a7" "brightred"    ))
   (mint       '("#5de6a8" "#5de6a8" "brightgreen"  ))
   (pink       '("#f38ba8" "#f38ba8" "brightmagenta"))

   ;; These are the "universal syntax classes" doom-themes requires.
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      base4)               ; Visual bg = grey in helix.nvim
   (builtin        cyan)                ; @function.builtin / @variable.builtin
   (comments       (if doom-helix-brighter-comments dark-cyan base6))
   (doc-comments   (doom-lighten (if doom-helix-brighter-comments dark-cyan base6) 0.25))
   (constants      peach)
   (functions      red)
   (keywords       blue)
   (methods        blue)
   (operators      pink)
   (type           teal)
   (strings        green)
   (variables      peach)
   (numbers        orange)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    blue)
   (vc-added       green)
   (vc-deleted     red)

   ;; Extra vars used only in this theme
   (modeline-fg              base7)
   (modeline-fg-alt          base5)
   (modeline-bg              (if doom-helix-brighter-modeline
                                 (doom-darken blue 0.45)
                               (doom-darken bg-alt 0.1)))
   (modeline-bg-alt          (if doom-helix-brighter-modeline
                                 (doom-darken blue 0.475)
                               `(,(doom-darken (car bg-alt) 0.15) ,@(cdr bg))))
   (modeline-bg-inactive     `(,(car bg-alt) ,@(cdr base1)))
   (modeline-bg-inactive-alt `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg)))

   (-modeline-pad
    (when doom-helix-padded-modeline
      (if (integerp doom-helix-padded-modeline) doom-helix-padded-modeline 4))))


  ;;;; Base theme face overrides
  (
   ;;;; --- Tree-sitter parity block -------------------------------------
   ;; The faces below are set explicitly (rather than left to doom-themes'
   ;; universal `functions'/`keywords'/etc vars) so that Emacs's tree-sitter
   ;; fontification matches helix.nvim's @capture groups as closely as
   ;; Emacs's face vocabulary allows. All of these are real, built-in
   ;; `font-lock-*-face' names -- Emacs 29 added several (operator, bracket,
   ;; delimiter, misc-punctuation, property-name/use, number, escape,
   ;; function-call, variable-use, doc-markup) specifically to support
   ;; tree-sitter's finer-grained captures; there is no separate
   ;; `treesit-font-lock-*-face' family.
   ;;
   ;; A few of helix.nvim's distinctions have no Emacs equivalent and are
   ;; called out inline -- in those cases the closest shared face is used.

   ;; @variable / @variable.member  (peach in helix.nvim)
   (font-lock-variable-name-face :foreground peach)
   (font-lock-variable-use-face  :foreground peach) ; Emacs 29: a variable *reference* vs its definition
   (font-lock-property-name-face :foreground peach) ; @variable.member / @property
   (font-lock-property-use-face  :foreground peach)
   ;; @variable.parameter (purple in helix.nvim) -- Emacs has no dedicated
   ;; "parameter" face distinct from variable-name in stock font-lock, so
   ;; most tree-sitter modes fontify parameters with `font-lock-variable-name-face'
   ;; too. If a mode you use does define its own parameter face, add it here.

   ;; @variable.builtin / @constant.builtin / @function.builtin / @type.builtin
   ;; (all cyan/blue "builtin" flavors in helix.nvim) share Emacs's one
   ;; `font-lock-builtin-face'.
   (font-lock-builtin-face :foreground cyan)

   ;; @constant / @constant.macro
   (font-lock-constant-face :foreground peach)
   (font-lock-preprocessor-face :foreground green :weight 'bold) ; @constant.macro, @keyword.directive, @attribute

   ;; @string family
   (font-lock-string-face  :foreground green)
   (font-lock-doc-face     :foreground green :slant 'italic)
   (font-lock-doc-markup-face :foreground blue)
   (font-lock-escape-face  :foreground blue)   ; @string.escape / @string.special
   (font-lock-regexp-grouping-construct :foreground peach :weight 'bold) ; @string.regexp

   ;; @number / @number.float / @character / @boolean
   (font-lock-number-face :foreground orange)
   ;; @boolean has no dedicated stock face; booleans fall under `font-lock-constant-face'.

   ;; @function / @function.call / @function.method / @function.macro
   (font-lock-function-name-face :foreground red)  ; definitions
   (font-lock-function-call-face :foreground red)  ; Emacs 29: call sites, kept same as definitions like helix.nvim's method/function overlap

   ;; @keyword and all its sub-captures (coroutine/function/operator/type/
   ;; modifier/control.*) -- Emacs's tree-sitter modes overwhelmingly emit a
   ;; single `keyword' feature, so these all collapse to one face.
   (font-lock-keyword-face :foreground blue)

   ;; @operator / @punctuation.*
   (font-lock-operator-face          :foreground pink)
   (font-lock-punctuation-face       :foreground mint)
   (font-lock-bracket-face           :foreground mint) ; @punctuation.bracket
   (font-lock-delimiter-face         :foreground mint) ; @punctuation.delimiter
   (font-lock-misc-punctuation-face  :foreground mint) ; @punctuation.special

   ;; @comment / @comment.todo
   (font-lock-comment-face           :foreground base6 :slant 'italic)
   (font-lock-comment-delimiter-face :foreground base6)

   ;; @type / @type.builtin / @namespace
   (font-lock-type-face :foreground teal)

   ;; @tag.* is left to each major mode's own faces (nxml/sgml/web-mode),
   ;; since Emacs doesn't route HTML/JSX tags through generic font-lock-*.

   (font-lock-negation-char-face :foreground red :weight 'bold)
   (font-lock-warning-face       :foreground yellow :weight 'bold)

   ;; hl-todo (Doom's default TODO/FIXME/NOTE highlighter) mirrors
   ;; @comment.todo's cyan in helix.nvim.
   (hl-todo :foreground cyan :weight 'bold)
   ;;;; --- end tree-sitter parity block -----------------------------------

   ((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground cyan)
   ((font-lock-comment-face &override)
    :background (if doom-helix-comment-bg (doom-lighten bg 0.05) 'unspecified))
   ((cursor &override) :background fg)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if doom-helix-brighter-modeline base8 highlight))

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; diff-mode / magit / vc (helix.nvim's muted diff backgrounds)
   (diff-added   :background "#1e2d1e" :foreground green)
   (diff-removed :background "#2d1e1e" :foreground red)
   (diff-changed :background "#1e2233" :foreground blue)
   (diff-refine-added   :background "#1e2d1e" :foreground green :weight 'bold)
   (diff-refine-removed :background "#2d1e1e" :foreground red   :weight 'bold)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-helix-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; ivy
   (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'normal)
   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)
   ;;;; markdown-mode (mirrors the h1-h6 heading backgrounds from helix.nvim)
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground magenta)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))
   (markdown-header-face-1 :foreground magenta :background "#2d2035" :weight 'bold)
   (markdown-header-face-2 :foreground green   :background "#1e2d26" :weight 'bold)
   (markdown-header-face-3 :foreground blue    :background "#1e2a35" :weight 'bold)
   (markdown-header-face-4 :foreground red     :background "#2d2626" :weight 'bold)
   (markdown-header-face-5 :foreground yellow  :background "#2a2d1e" :weight 'bold)
   (markdown-header-face-6 :foreground cyan    :background "#1e2d2d" :weight 'bold)
   ;;;; org-mode headings, same treatment as markdown
   (org-level-1 :foreground magenta :background "#2d2035" :weight 'bold)
   (org-level-2 :foreground green   :background "#1e2d26" :weight 'bold)
   (org-level-3 :foreground blue    :background "#1e2a35" :weight 'bold)
   (org-level-4 :foreground red     :background "#2d2626" :weight 'bold)
   (org-level-5 :foreground yellow  :background "#2a2d1e" :weight 'bold)
   (org-level-6 :foreground cyan    :background "#1e2d2d" :weight 'bold)
   ;;;; rainbow-delimiters (mint used for delimiters in helix.nvim)
   (rainbow-delimiters-depth-1-face :foreground mint)
   (rainbow-delimiters-depth-2-face :foreground violet)
   (rainbow-delimiters-depth-3-face :foreground blue)
   (rainbow-delimiters-depth-4-face :foreground teal)
   (rainbow-delimiters-depth-5-face :foreground yellow)
   (rainbow-delimiters-depth-6-face :foreground orange)
   (rainbow-delimiters-depth-7-face :foreground red)
   ;;;; rjsx-mode
   (rjsx-tag :foreground blue)
   (rjsx-attr :foreground blue)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt))))

  ;;;; Base theme variable overrides
  ())

;;; doom-helix-theme.el ends here
