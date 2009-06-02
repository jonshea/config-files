(defalias 'yes-or-no-p 'y-or-n-p)

(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")

(setq
 change-log-default-name "ChangeLog"
 debug-on-error t
 default-major-mode 'text-mode
 display-time-24hr-format t
 flyspell-issue-message-flag nil
 frame-title-format '(buffer-file-name "%f" ("%b"))
 ido-everywhere t
 indent-tabs-mode nil
 inhibit-startup-message t
 kill-whole-line t
 longlines-auto-wrap t
 mac-option-modifier 'meta
 make-backup-files nil
 query-replace-highlight t
 require-final-newline t
 scroll-step 1
 search-highlight t
 tab-always-indent t
 tramp-default-method "scp"
 user-full-name "Jon Shea"
 vc-follow-symlinks t
 )
(setq-default 
 indent-tabs-mode nil
 save-place t)

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(line-number-mode 1)
(display-time)
(show-paren-mode 1)
(column-number-mode 1)

(require 'cl)

;; I'm hardcore. I search with regexp
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
;;(define-key isearch-mode-map (kbd "C-r") 'isearch-repeat-backward)
;; Write an isearch-mode-map binding for the arrow keys
  
(global-set-key (kbd "C-l") 'goto-line)
(global-set-key "\C-m" 'newline-and-indent)
(define-key minibuffer-local-map (kbd "<escape>") 'keyboard-quit) ;; Doesn't quite work yet...

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
(global-set-key (kbd "C-;") 'comment-or-uncomment-region-or-line)
;; Write a macro for require that takes a path, and a block and only runs the block if the path exists.

(when (boundp 'aquamacs-version)
  (define-key osx-key-mode-map (kbd "A-/") 'comment-or-uncomment-region-or-line)

  ;;(autoload 'css2-mode "~/emacs/elisp/css2-mode" "Mode for editing CSS files" t)
  ;;(add-to-list 'auto-mode-alist '("\\.css$" . css2-mode))
  ;;mostly just use one buffer
  (one-buffer-one-frame-mode 0)

  (define-key osx-key-mode-map (kbd "M-[") "“")
  (define-key osx-key-mode-map (kbd "M-{") "”")
  (define-key osx-key-mode-map (kbd "M-]") "‘")
  (define-key osx-key-mode-map (kbd "M-}") "’")
  (define-key osx-key-mode-map (kbd "M--") "–")
  (define-key osx-key-mode-map (kbd "M-_") "—")

  (server-start)
  (add-hook 'server-switch-hook
            (lambda ()
              ;; Always open new client sessions in a new frame
              (let ((server-buf (current-buffer)))
                (bury-buffer)
                (switch-to-buffer-other-frame server-buf))
              ;; Rebind both C-x k and C-x C-x to end the server session, rather than quit
              (when (current-local-map)
                (use-local-map (copy-keymap (current-local-map)))) 
              (local-set-key (kbd "C-x k") 'server-edit)
              (local-set-key (kbd "C-x C-c") 'server-edit)
              ))
  (add-hook 'server-done-hook (lambda () (delete-frame)))
   
  (autoload 'js2-mode "js2" nil t)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (setq js2-highlight-level 3
        js2-basic-offset 2
        js2-use-font-lock-faces t)

  (add-to-list 'load-path "/Users/jonshea/emacs/elisp")

  (require 'ido) ;; Improved file selection and buffer switching
  (ido-mode t)
  (setq
   ido-ignore-buffers ; ignore these guys
   '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido")
   ido-work-directory-list '("~/" "~/Desktop")
   ido-case-fold  t ; be case-insensitive
   ido-use-filename-at-point nil ; don't use filename at point (annoying)
   ido-use-url-at-point nil ;  don't use url at point (annoying)
   ido-enable-flex-matching t ; be flexible
   ido-max-prospects 6 ; don't spam my minibuffer
   ido-confirm-unique-completion t) ; wait for RET, even with unique completion

  ;; nxml (HTML ERB template support)
  (load "~/emacs/nxhtml/autostart.el")
  (setq
   nxhtml-global-minor-mode t
   mumamo-chunk-coloring 'submode-colored
   nxhtml-skip-welcome t
   indent-region-mode t
   rng-nxml-auto-validate-flag nil
   nxml-degraded t)
  (add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
  (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo-mode))

  ;; Ranari
  ;; (add-to-list 'load-path "~/emacs/rinari")
  ;; (require 'rinari)

  ;; Rails-reloaded
  ;;  (add-to-list 'load-path "~/emacs/emacs-rails-reloaded")
  ;;  (require 'rails-autoload)

  (add-hook 'ruby-mode 'flyspell-prog-mode t)
  (require 'ruby-block)
  (ruby-block-mode t)
  (setq ruby-block-highlight-toggle t)

  (add-to-list 'load-path "~/emacs/yaml")
  (require 'yaml-mode)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-hook 'yaml-mode-hook
            '(lambda ()
               (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

  ;; ;; ;; duplicate buffers easier to spot
  (require 'uniquify)
  (setq-default uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq-default ispell-program-name "aspell")
  ;; OS X adds words it learns to ~/Library/Spelling, and it looks reasonable to try to include them with --personal=<file>, but I don't feel like it right now.
;;  (setq ispell-program-name "/opt/local/bin/ispell")
;;  (setq ispell-extra-args '("--sug-mode=ultra"))

  ;;  (longlines-mode)
  ;;  (add-hook 'text-mode-hook 'longlines-mode)

  (tool-bar-mode -1)
  (mouse-wheel-mode t)
  (auto-insert-mode t)
  ;;(autoload 'flyspell-mode "flyspell" "On-the-fly spell checker." t)
  ;;(add-hook 'text-mode-hook (lambda () (auto-fill-mode 1)))
  (add-hook 'text-mode-hook (lambda () (flyspell-mode 1)))
  (global-set-key '[(f5)] 'call-last-kbd-macro)
  (global-set-key (kbd "C-j") 'flyspell-check-previous-highlighted-word)
  (global-set-key (kbd "C-c j") 'flyspell-check-previous-highlighted-word)
  (global-set-key '[(f8)] 'flyspell-check-previous-highlighted-word)
     
  (define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

  (add-to-list 'load-path
               "~/emacs/yasnippet")
  (require 'yasnippet)
  (add-to-list 'yas/extra-mode-hooks
               'ruby-mode-hook)
  (yas/initialize)
  (yas/load-directory "~/emacs/yasnippet/snippets/")

  (load-library "paren")
  
  ;;  (autoload 'whizzytex-mode "/Users/jonshea/emacs/whizzytex/whizzytex" "WhizzyTeX, a minor-mode WYSIWYG environment for LaTeX" t) 
  ;;  (setq-default whizzy-viewers '(("-skim" "skim")))
  ;; (add-hook 'LaTeX-mode-hook (lambda ()
  ;; 			     (TeX-fold-mode 1)))
  ;; (autoload 'whizzytex-mode
  ;;   "whizzytex"
  ;;   "WhizzyTeX, a minor-mode WYSIWIG environment for LaTeX" t)

  (setq TeX-newline-function 'newline-and-indent)
  (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode) 

  ;; ;(require 'paredit)

  ;; (add-to-list 'default-frame-alist '(font . "10x20"))

  (require 'color-theme)
  (setq color-theme-is-global t)

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
         (default ((t (:stipple nil :background "gray99" :foreground "black"
                       :inverse-video nil :box nil :strike-through nil :overline nil
                       :underline nil :slant normal :weight normal :height 90 :width normal
                       :family "outline-courier new"))))
         ;; (flyspell-duplicate-face ((t (nil))))
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
;;    (color-theme-feng-shui)
    (let ((color-theme-is-cumulative 0))
      (color-theme-install
       '(color-theme-espresso
         ((background-color . "white")
          (background-mode . light)
          (border-color . "black")
          (cursor-color . "slateblue")
          (foreground-color . "black")
          (mouse-color . "slateblue")) ;; FRAME-PARAMETERS
         nil                           ;; VARIABLE-DEFINITIONS
         (default ((t (:stipple nil :background "gray99" :foreground "black"
                       :inverse-video nil :box nil :strike-through nil :overline nil
                       :underline nil :slant normal :weight normal :height 90 :width normal
                       :family "outline-courier new"))))
         ;; (flyspell-duplicate-face ((t (nil))))
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
         ))))

(color-theme-espresso)
;;  (color-theme-feng-shea)

  ;; (setq sbcl-path "/sw/bin/sbcl")

  ;; (setenv "SBCL_HOME" "/usr/local/lib/sbcl/") ; needed for SBCL
  ;; (setq lisp-sbcl     "/usr/local/bin/sbcl")
  ;; (setq inferior-lisp-program sbcl-path)


  ;; ;; (setenv "SBCL_HOME" "/usr/local/lib/sbcl/") ; needed for SBCL
  ;; ;; (setq lisp-sbcl     "/usr/local/bin/sbcl")
  ;; ;; (setq inferior-lisp-program "/usr/local/bin/sbcl")

  ;; (add-to-list 'load-path "~/emacs/slime")

  ;; (require 'slime)
  ;; (setq common-lisp-hyperspec-root
  ;;       "file:///Users/jonshea/emacs/HyperSpec/")
  ;; (setq browse-url-browser-function 'browse-url-default-macosx-browser)
  ;; ;; (setq slime-lisp-implementations
  ;; ;;       '((sbcl ("/usr/locol/bin/sbcl"))))  ; default
  ;; (setq slime-edit-definition-fallback-function 'find-tag)
  ;; (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
  ;;  (slime-setup :autodoc t)
  ;; ;; (global-set-key "\C-cs" 'slime-selector)

  ;; ;; (defun slime-sbcl ()
  ;; ;;   (interactive)
  ;; ;;   (apply #'slime-start
  ;; ;;          (list* :buffer "*inferior-lisp-sbcl*" 
  ;; ;;                 (slime-lookup-lisp-implementation slime-lisp-implementations
  ;; ;;                                                   'sbcl))))

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
 
  ) ;; end Aquamacs specific code
