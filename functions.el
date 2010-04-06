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

(defun tall-window ()
  "Maximize the window vertically without changing the width."
  (interactive)
  (set-frame-position (selected-frame)
                      (frame-parameter (selected-frame) 'left)
                       0)
  (set-frame-height (selected-frame) 1000))


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

(defun color-theme-feng-shea ()
  "`color-theme-feng-shui', but highlight the variables for christ sake."
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
     (region ((t (:background "#b5d5ff"))))
     )))
