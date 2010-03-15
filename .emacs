(defalias 'yes-or-no-p 'y-or-n-p)

;;  Write something to make shift-space insert a NBSP

(prefer-coding-system 'utf-8-mac)
(set-terminal-coding-system 'utf-8-mac)
(set-keyboard-coding-system 'utf-8-mac)
(set-language-environment "UTF-8")

(setq
 change-log-default-name "ChangeLog"
; debug-on-error t
 default-major-mode 'text-mode
 display-time-24hr-format t
 flyspell-issue-message-flag nil
 frame-title-format '(buffer-file-name "%f" ("%b"))
 ido-everywhere t
 indent-tabs-mode nil
 inhibit-startup-message t
 kill-whole-line t
 mac-option-modifier 'meta
 make-backup-files nil
 query-replace-highlight t
 require-final-newline t
 scroll-step 1
 search-highlight t
 tab-always-indent t
 tramp-default-method "scp"
 transient-mark-mode t
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
(global-auto-revert-mode 1)
(global-visual-line-mode 1)

(require 'cl)

;;; This was installed by package-install.el.
(when (load
       (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(add-to-list 'load-path "~/projects/go-lang/misc/emacs" t)
(require 'go-mode-load)
  
;; (custom-set-faces                    
;;    ;; custom-set-faces was added by Custom.
;;    ;; If you edit it by hand, you could mess it up, so be careful.
;;    ;; Your init file should contain only one such instance.
;;    ;; If there is more than one, they won't work right.
;;   '(default ((t (:stipple nil :background "gray99" :foreground "black" :inverse-video nil :box nil :strike-through nil :\
;;                           overline nil :underline nil :slant normal :weight normal :height 130 :width normal :family "menlo")))))

(set-face-attribute 'default nil :height 110 :family "menlo")

;; I'm hardcore. I search with regexp
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
;;(define-key isearch-mode-map (kbd "C-r") 'isearch-repeat-backward)
;; Write an isearch-mode-map binding for the arrow keys

(require 'uniquify)
(setq-default uniquify-buffer-name-style 'post-forward-angle-brackets)

;; http://www.emacswiki.org/emacs/LoadingLispFiles
(defmacro with-library (symbol &rest body)
    "Attempts to load the library 'symbol', and logs an error if this is not possible."
  `(condition-case err
       (progn
         (require ,symbol)
         ,@body)
     
     (error (message (format "Library %s failed to load.\n%s" ,symbol err))
            nil)))
(put 'with-library 'lisp-indent-function 1)

(global-set-key (kbd "M-[") "“")
(global-set-key (kbd "M-{") "”")
(global-set-key (kbd "M-]") "‘")
(global-set-key (kbd "M-}") "’")
(global-set-key (kbd "M--") "–")
(global-set-key (kbd "M-_") "—")

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

(add-hook 'emacs-lisp-mode-hook
          (lambda () 
            (turn-on-eldoc-mode)
            (flyspell-prog-mode)
            (define-key emacs-lisp-mode-map [f5] 'eval-buffer)
            ))

(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)

(add-to-list 'load-path "~/emacs/color-theme/")
(with-library 'color-theme
  (color-theme-initialize)
  (setq color-theme-is-global t))

(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (setq color-theme-is-global t)))

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
        (mouse-color . "slateblue"))   ;; FRAME-PARAMETERS
       nil                             ;; VARIABLE-DEFINITIONS
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
 
  (color-theme-espresso)
;;  (color-theme-feng-shea)

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



(when (boundp 'aquamacs-version)
;;(when t
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
  ;; I want to unbind "cmd-;", which does something horrible, but I can't figure out how
  ;;  (global-unset-key [( mac-command-modifier ";")])
  (global-set-key '[(f5)] 'call-last-kbd-macro)
  (global-set-key (kbd "C-j") 'flyspell-check-previous-highlighted-word)
  (global-set-key (kbd "C-c j") 'flyspell-check-previous-highlighted-word)
  (global-set-key '[(f8)] 'flyspell-check-previous-highlighted-word)

  (add-to-list 'load-path "~/emacs/company")
  (autoload 'company-mode "company" nil t)

  (add-to-list 'load-path "/Users/jonshea/emacs/elisp")
  
  (autoload 'js2-mode "js2" nil t)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (setq js2-highlight-level 3
        js2-basic-offset 2
        js2-use-font-lock-faces t
        js2-enter-indents-newline t)

;;  (require 'ido) ;; Improved file selection and buffer switching
;;  (ido-mode t)
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

  ;; Support for html5 in nxml mode.
  ;; See http://github.com/hober/html5-el/tree/master
  (add-to-list 'load-path "~/emacs/html5-el/")
  (eval-after-load "rng-loc"
      '(add-to-list 'rng-schema-locating-files "~/emacs/html5-el/schemas.xml"))

  (require 'whattf-dt)

  
  ;; nxhml (HTML ERB template support)
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

  (add-to-list 'load-path "~/emacs/zencoding/")
  (require 'zencoding-mode)
  (add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes
;;  (add-hook 'eruby-nxhtml-mumamo-mode 'zencoding-mode)
  
  ;; Ranari
  ;; (add-to-list 'load-path "~/emacs/rinari")
  ;; (require 'rinari)

  ;; Rails-reloaded
  ;;  (add-to-list 'load-path "~/emacs/emacs-rails-reloaded")
  ;;  (require 'rails-autoload)


  ;; http://www.emacswiki.org/emacs-en/AutoIndentation
  ;; When killing a line, get rid of indentation spaces
  ;; This doesn't work with kill-and-join-forward, because of the obvious recursion
;;  (defadvice kill-line (before check-position activate)
;;    (kill-and-join-forward))
    
  (defun kill-and-join-forward (&optional arg)
    "If at end of line, join with following; otherwise kill line.
    Deletes whitespace at join."
    (interactive "P")
    (if (and (eolp) (not (bolp)))
        (delete-indentation t)
      (kill-line arg)))
  
  (define-key global-map (kbd "RET") 'newline-and-indent)
  (defun set-newline-and-indent ()
    (local-set-key (kbd "RET") 'newline-and-indent))


  ;; Auto-indent pasted code. Figure out how to make this work with cmnd-v also
;;   (dolist (command '(yank yank-pop))
;;     (eval `(defadvice ,command (after indent-region activate)
;;              (and (not current-prefix-arg)
;;                   (member major-mode '(emacs-lisp-mode lisp-mode
;;                                                        clojure-mode    scheme-mode
;;                                                        haskell-mode    ruby-mode
;;                                                        rspec-mode      python-mode
;;                                                        c-mode          c++-mode
;;                                                        objc-mode       latex-mode
;;                                                        plain-tex-mode))
;;                   (let ((mark-even-if-inactive transient-mark-mode))
;;                     (indent-region (region-beginning) (region-end) nil))))))

  (add-hook 'python-mode (lambda () (flyspell-prog-mode 1)))
  (add-hook 'css-mode (lambda ()
                        (flyspell-prog-mode 1)
                        (set-newline-and-indent)
                        (message "Jon Shea: css-mode hook")
                        ))
  (add-hook 'js2-mode (lambda () (flyspell-prog-mode 1)))
  (add-hook 'emacs-lisp-mode (lambda () (flyspell-prog-mode 1)))
  
  (add-hook 'ruby-mode (lambda ()
                         (flyspell-prog-mode 1)
                         (set-newline-and-indent)
                         (message "Jon Shea: ruby-mode hook")
                         ))
  (require 'ruby-block)
  (ruby-block-mode t)
  (setq ruby-block-highlight-toggle t)

  (add-to-list 'load-path "~/emacs/yaml")
  (require 'yaml-mode)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-hook 'yaml-mode-hook
            '(lambda ()
               (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

  (setq-default ispell-program-name "aspell")
  ;; OS X adds words it learns to ~/Library/Spelling, and it looks reasonable to try to include them with --personal=<file>, but I don't feel like it right now.
;;  (setq ispell-program-name "/opt/local/bin/ispell")
;;  (setq ispell-extra-args '("--sug-mode=ultra"))

  (tool-bar-mode -1)
  (mouse-wheel-mode t)
  (auto-insert-mode t)
;  (add-hook 'text-mode-hook (lambda () (flyspell-mode 1)))
     
;;  (define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

  (add-to-list 'load-path "~/emacs/yasnippet")
;;  (require 'yasnippet)
;;  (setq yas/root-directory "~/emacs/yasnippet/snippets/")
;;  (add-to-list 'yas/extra-mode-hooks 'ruby-mode-hook)
;;  (yas/load-directory yas/root-directory)
;;  (yas/initialize)
;;  (yas/load-directory  "~/emacs/yasnippet/snippets")
  
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
        (mouse-color . "slateblue"))   ;; FRAME-PARAMETERS
       nil                             ;; VARIABLE-DEFINITIONS
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


