;; Idea: make is so that quotes, parens, brackets, etc, if you insert one while the region is active then it will wrap the region rather than overwrite it.

;; http://www.emacswiki.org/emacs/LoadingLispFiles
(defmacro with-library (symbol &rest body)
  "Attempts to load the library 'symbol', and logs an error if this is not possible."
  `(if (condition-case err
           (require ,symbol nil t)
         (error (message (format "Library %s failed to load.\n%s" ,symbol err))
                nil))
       (progn ,@body)))
(put 'with-library 'lisp-indent-function 1)

(defmacro with-loaded-file (filename &rest body)
  "Attempts to load the 'filename', and logs an error if the file can't be loaded."
  `(if (load ,filename t)
       (progn ,@body)
     (error (message (format "File %s failed to load.." ,filename)))))
(put 'with-loaded-file 'lisp-indent-function 1)

(defmacro if-emacs-app (&rest body)
  `(if (> emacs-major-version 22)
       (progn ,@body)))

;; thanks to http://github.com/bretthoerner/emacs-dotfiles/
(defun comment-or-uncomment-line (&optional lines)
  "Comment current line. Argument gives the number of lines
forward to comment"
  (interactive "P")
  (comment-or-uncomment-region
   (line-beginning-position)
   (line-end-position lines)))

(defun comment-or-uncomment-region-or-line (&optional lines)
  "If the line or region is not a comment, comments region
if mark is active, line otherwise. If the line or region
is a comment, uncomment."
  (interactive "P")
  (if mark-active
      (if (< (mark) (point))
          (comment-or-uncomment-region (mark) (point))
        (comment-or-uncomment-region (point) (mark)))
    (comment-or-uncomment-line lines)))

(defun set-newline-and-indent ()
  (local-set-key (kbd "RET") 'newline-and-indent))

(defun kill-and-join-forward (&optional arg)
  "If at end of line, join with following; otherwise kill line.
    Deletes whitespace at join."
  (interactive "P")
  (if (and (eolp) (not (bolp)))
      (delete-indentation t)
    (kill-line arg)))

(defun iwb ()
  "Indent the whole buffer."
    (interactive)
      (indent-region (point-min) (point-max)))

;; (defun tall-window ()
;;   "Maximize the window vertically without changing the width."
;;   (interactive)
;;   (set-frame-position (selected-frame)
;;                       (frame-parameter (selected-frame) 'left)
;;                        0)
;;   (set-frame-height (selected-frame) 1000))


;; (defun indent-or-expand (arg)
;;   "Either indent according to mode, or expand the word preceding
;; point."
;;   (interactive "*P")
;;   (if (and
;;        (or (bobp) (= ?w (char-syntax (char-before))))
;;        (or (eobp) (not (= ?w (char-syntax (char-after))))))
;;       (dabbrev-expand arg)
;;     (indent-according-to-mode)))

;; (defun my-tab-fix ()
;;   (local-set-key [tab] 'indent-or-expand))

(defun camelcase  (s)
  "Converts underscore to camelCase. FIXME: Will incorrectly capitalize '_foo'."
  (let ((l (split-string s "_")))
    (if (cdr l)
        (concat (car l) (mapconcat 'capitalize (cdr l) ""))
      (car l)
      )))

(defun camelcase-word-at-point ()
  "There's probably a one-liner for this..."
  (interactive)
  (let* ((bounds (bounds-of-thing-at-point 'symbol))
         (p1 (car bounds))
         (p2 (cdr bounds))
         (s (delete-and-extract-region p1 p2)))
    (message s)
    (insert (camelcase s))))

(defun color-theme-feng-shea ()
  "`color-theme-feng-shui', but highlight the variables please."
  (interactive)
  (color-theme-feng-shui)
  (let ((color-theme-is-cumulative t))
    (color-theme-install
     '(color-theme-feng-shea
       ((background-color . "gray99")
        (background-mode . light)
        (border-color . "black")
        (cursor-color . "slateblue")
        (foreground-color . "black")
        (mouse-color . "slateblue")) ;; FRAME-PARAMETERS
       nil                           ;; VARIABLE-DEFINITIONS
       (default ((t (nil))))
       (flyspell-incorrect-face ((t (:italic t :foreground "red" :slant italic :underline t))))
       ;; (font-lock-doc-string-face ((t (nil))))
       (font-lock-builtin-face ((t (:foreground "brown"))))
       (font-lock-comment-face ((t (:italic t :foreground "dark slate blue" :slant italic))))
       (font-lock-constant-face ((t (:foreground "darkblue"))))
       (font-lock-doc-face ((t (:background "cornsilk"))))
       (font-lock-function-name-face ((t (:bold t :underline t :weight bold))))
       (font-lock-keyword-face ((t (:foreground "blue"))))
       (font-lock-string-face ((t (:foreground "midnight blue" :background "alice blue"))))
       (font-lock-type-face ((t (:foreground "sienna"))))
       (font-lock-variable-name-face ((t (:foreground "dark goldenrod"))))
       (font-lock-warning-face ((t (:bold t :foreground "Red" :weight bold))))
       (highlight ((t (:background "mistyRose"))))
       (region ((t (:background "lavender"))))
       ))))

(defun color-theme-espresso ()
  "`color-theme-espresso', emulate the colors in Espresso.app."
  (interactive)
  (color-theme-install
   '(color-theme-espresso
     ((background-color . "gray99")
      (background-mode . light)
      (border-color . "black")
      (cursor-color . "slateblue")
      (foreground-color . "black")
      (mouse-color . "slateblue")) ;; FRAME-PARAMETERS
     nil                           ;; VARIABLE-DEFINITIONS
     (default ((t (nil))))
     (flyspell-incorrect-face ((t (:italic t :foreground "red" :slant italic :underline t))))
     (font-lock-doc-string-face ((t (:background "#faedc4"))))
     (font-lock-builtin-face ((t (:foreground "brown"))))
     (font-lock-comment-face ((t (:foreground "#777777"))))
     (font-lock-constant-face ((t (:foreground "darkblue"))))
     (font-lock-doc-face ((t (:background "cornsilk"))))
     (font-lock-function-name-face ((t (:foreground "#2F6F9F" :background "#f4faff"))))
     (font-lock-keyword-face ((t (:foreground "#DF9F4F"))))
     (font-lock-string-face ((t (:foreground "#d44950"))))
     (font-lock-type-face ((t (:foreground "sienna"))))
     (font-lock-variable-name-face ((t (:foreground "#7b8c4d"))))
     (font-lock-warning-face ((t (:foreground "#f9f2ce" :background "#f93232"))))
     (highlight ((t (:background "mistyRose"))))
     (ensime-errline ((t (:background "mistyRose"))))
     (ensime-errline-highlight ((t (:box "#6c71c4" :background nil))))
     (region ((t (:background "#b5d5ff"))))
     )))



(defun color-theme-solarized2 ()
  "Color theme by Ethan Schoonover, created 2011-03-24.
Ported to Emacs by Greg Pfeil, http://ethanschoonover.com/solarized."
  (interative)
  (let ((base03  "#002b36")
        (base02  "#073642")
        (base01  "#586e75")
        (base00  "#657b83")
        (base0   "#839496")
        (base1   "#93a1a1")
        (base2   "#eee8d5")
        (base3   "#f8fcfb")
        (yellow  "#b58900")
        (orange  "#cb4b16")
        (red     "#dc322f")
        (magenta "#d33682")
        (violet  "#6c71c4")
        (blue    "#268bd2")
        (cyan    "#2aa198")
        (green   "#859900"))
      (rotatef base03 base3)
      (rotatef base02 base2)
      (rotatef base01 base1)
      (rotatef base00 base0)
    (color-theme-install
     `(color-theme-solarized2
       ((foreground-color . ,base0)
        (background-color . ,base03)
        (background-mode . light)
        (cursor-color . ,base0))
       ;; basic
       (default ((t (:foreground ,base0))))
       (cursor ((t (:foreground ,base0 :background ,base03 :inverse-video t))))
       (escape-glyph-face ((t (:foreground ,red))))
       (fringe ((t (:foreground ,base01 :background ,base02))))
       (header-line ((t (:foreground ,base0 :background ,base2))))
       (highlight ((t (:background ,base02))))
       (isearch ((t (:foreground ,yellow :inverse-video t))))
       (menu ((t (:foreground ,base0 :background ,base02))))
       (minibuffer-prompt ((t (:foreground ,blue))))
       (mode-line
        ((t (:foreground ,base1 :background ,base02
                         :box (:line-width 1 :color ,base1)))))
       (mode-line-buffer-id ((t (:foreground ,base1))))
       (mode-line-inactive
        ((t (:foreground ,base0  :background ,base02
                         :box (:line-width 1 :color ,base02)))))
       (region ((t (:background ,base02))))
       (secondary-selection ((t (:background ,base02))))
       (trailing-whitespace ((t (:foreground ,red :inverse-video t))))
       (vertical-border ((t (:foreground ,base0))))
       ;; compilation
       (compilation-info ((t (:forground ,green :bold t))))
       (compilation-warning ((t (:foreground ,orange :bold t))))
       ;; customize
       (custom-button
        ((t (:background ,base02 :box (:line-width 2 :style released-button)))))
       (custom-button-mouse ((t (:inherit custom-button :foreground ,base1))))
       (custom-button-pressed
        ((t (:inherit custom-button-mouse
                      :box (:line-width 2 :style pressed-button)))))
       (custom-comment-tag ((t (:background ,base02))))
       (custom-comment-tag ((t (:background ,base02))))
       (custom-documentation ((t (:inherit default))))
       (custom-group-tag ((t (:foreground ,orange :bold t))))
       (custom-link ((t (:foreground ,violet))))
       (custom-state ((t (:foreground ,green))))
       (custom-variable-tag ((t (:foreground ,orange :bold t))))
       ;; diff
       (diff-added ((t (:foreground ,green :inverse-video t))))
       (diff-changed ((t (:foreground ,yellow :inverse-video t))))
       (diff-removed ((t (:foreground ,red :inverse-video t))))
       ;; emacs-wiki
       (emacs-wiki-bad-link-face ((t (:foreground ,red :underline t))))
       (emacs-wiki-link-face ((t (:foreground ,blue :underline t))))
       (emacs-wiki-verbatim-face ((t (:foreground ,base00 :underline t))))
       ;; font-lock
       (font-lock-builtin-face ((t (:foreground ,green))))
       (font-lock-comment-face ((t (:foreground ,base01 :italic t))))
       (font-lock-constant-face ((t (:foreground ,cyan))))
       (font-lock-function-name-face ((t (:foreground ,blue))))
       (font-lock-keyword-face ((t (:foreground ,green))))
       (font-lock-string-face ((t (:foreground ,cyan))))
       (font-lock-type-face ((t (:foreground ,yellow))))
       (font-lock-variable-name-face ((t (:foreground ,blue))))
       (font-lock-warning-face ((t (:foreground ,red :bold t))))
       ;; info
       (info-xref ((t (:foreground ,blue :underline t))))
       (info-xref-visited ((t (:inherit info-xref :foreground ,magenta))))
       ;; org
       (org-hide ((t (:foreground ,base03))))
       (org-todo ((t (:foreground ,red :bold t))))
       (org-done ((t (:foreground ,green :bold t))))
       ;; show-paren
       (show-paren-match-face ((t (:background ,cyan :foreground ,base3))))
       (show-paren-mismatch-face ((t (:background ,red :foreground ,base3))))))))

