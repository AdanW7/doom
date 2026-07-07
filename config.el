;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-helix)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq doom-modeline-project-name t
      doom-modeline-workspace-name t
      doom-modeline-persp-name t)

(setq treesit-font-lock-level 4)

;; gh -> "0"  (absolute start of line)
;; gs -> "^"  (first non-blank)
;; gl -> "$"  (end of line)
;; ge -> "G"  (end of file) -- NOTE: this shadows Evil's default "ge"
;;            (backward-end-of-word).
(map! :n  "gh" #'evil-beginning-of-line
      :v  "gh" #'evil-beginning-of-line
      :o  "gh" #'evil-beginning-of-line
      :n  "gs" #'evil-first-non-blank
      :v  "gs" #'evil-first-non-blank
      :o  "gs" #'evil-first-non-blank
      :n  "gl" #'evil-end-of-line
      :v  "gl" #'evil-end-of-line
      :o  "gl" #'evil-end-of-line
      :n  "ge" #'evil-goto-line
      :v  "ge" #'evil-goto-line
      :n  "U" #'evil-redo
      :o  "ge" #'evil-goto-line)

(map! :n "C-d" (cmd! (evil-scroll-down nil) (recenter))
      :v "C-d" (cmd! (evil-scroll-down nil) (recenter))
      :n "C-u" (cmd! (evil-scroll-up nil) (recenter))
      :v "C-u" (cmd! (evil-scroll-up nil) (recenter)))

(setq evil-vsplit-window-right t   ; SPC w v -> new window opens to the RIGHT
      evil-split-window-below t)   ; SPC w s -> new window opens BELOW


(defun +my/scratch-buffer-here ()
  "Switch the selected window to a fresh, file-less scratch buffer."
  (let ((buf (generate-new-buffer "*scratch*")))
    (with-current-buffer buf
      (fundamental-mode)
      (setq buffer-offer-save nil))
    (switch-to-buffer buf)))

(defun +my/new-scratch-split-horizontal ()
  "Horizontal split with a new scratch buffer (mirrors <leader>wns)."
  (interactive)
  (evil-window-split)
  (+my/scratch-buffer-here))

(defun +my/new-scratch-split-vertical ()
  "Vertical split with a new scratch buffer (mirrors <leader>wnv)."
  (interactive)
  (evil-window-vsplit)
  (+my/scratch-buffer-here))

;; create scratch buffers
(map! :leader
      "w n" nil  ; clear evil-window-new so "w n" can become a prefix
      :desc "New scratch buffer (horizontal)" "w n s" #'+my/new-scratch-split-horizontal
      :desc "New scratch buffer (vertical)"   "w n v" #'+my/new-scratch-split-vertical)

;; completion keybind update
(map! :map vertico-map
      "TAB"     #'vertico-next
      "<backtab>" #'vertico-previous
      "M-RET"   #'vertico-exit)


;; lsp setup
(map! :leader
      :desc "LSP: Format buffer"        "l f" #'eglot-format-buffer
      :desc "LSP: Toggle inlay hints"   "l h" #'eglot-inlay-hints-mode)


;; setup python to use ruff and ty
(after! eglot
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode) . ("rass" "--" "ty" "server" "--" "ruff" "server"))))

(setq delete-trailing-lines nil)
(add-hook 'before-save-hook #'delete-trailing-whitespace)


(defun +my/remove-zero-width ()
  "Remove invisible Unicode formatting characters from current buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "[\u200b\u200c\u200d\u200e\u200f\ufeff]" nil t)
      (replace-match "")))
  (message "Invisible Unicode formatting characters removed from current buffer"))

(defun +my/indent-style (width)
  "Set indent width for the current buffer (tab-width and evil-shift-width)."
  (interactive "nIndent width: ")
  (if (or (not (integerp width)) (< width 1))
      (message "Usage: M-x +my/indent-style, width must be >= 1")
    (setq-local tab-width width)
    (setq-local evil-shift-width width)
    (message "Indent width set to %d for current buffer" width)))

(defun +my/strip-whitespace ()
  "Remove trailing whitespace from current buffer."
  (interactive)
  (delete-trailing-whitespace)
  (message "Trailing whitespace removed"))

(defun +my/yank-path ()
  "Copy absolute path of current file to the system clipboard."
  (interactive)
  (if-let ((path (buffer-file-name)))
      (progn
        (kill-new path)
        (message "Yanked: %s" path))
    (message "Buffer is not visiting a file")))

;; ============================================================================
;; Ripgrep / Consult
;; ============================================================================

(setq grep-program "rg"
      grep-use-null-device nil
      grep-command "rg --color=never --no-heading --line-number ")

(defun +adan/search-word ()
  "Search current word or visual selection with ripgrep."
  (interactive)
  (let ((query
         (if (use-region-p)
             (buffer-substring-no-properties
              (region-beginning)
              (region-end))
           (thing-at-point 'word t))))
    (when query
      (consult-ripgrep nil query))))

(map! :leader
      :prefix ("f" . "find")
      :desc "Ripgrep" "g" #'consult-ripgrep
      :desc "Search word" "w" #'+adan/search-word)

(map! :leader
      :prefix "l"
      :desc "Buffer diagnostics"  "d" #'flymake-show-buffer-diagnostics
      :desc "Project diagnostics" "D" #'flymake-show-project-diagnostics)

(after! files
  (dolist (dir (list doom-user-dir doom-emacs-dir))
    (add-to-list 'trusted-content (expand-file-name dir))))
