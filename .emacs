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

(camelcase "twitter_name")


(defalias 'yes-or-no-p 'y-or-n-p)

(defvar home-dir ""
  "")
(defvar config-files ""
  "")

(defvar elisp-dir "~/emacs/"
  "Directory of elisp files and packages.")

(when (file-exists-p "~/functions.el")
  (load "~/functions.el"))
(add-to-list 'load-path (concat elisp-dir "elisp"))

(prefer-coding-system 'utf-8-mac)
(set-terminal-coding-system 'utf-8-mac)
(set-keyboard-coding-system 'utf-8-mac)
(set-language-environment "UTF-8")

(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/Users/jonshea/foursquare.web")
(add-to-list 'exec-path ".")
;; (cond ((>= emacs-major-version 24)
;;        (add-to-list 'load-path (concat elisp-dir "scala-mode2"))
;;        (require 'scala-mode2))
;;       (t
;;        (add-to-list 'load-path (concat elisp-dir "scala")) 
;;        (require 'scala-mode-auto)))

;; (add-to-list 'load-path (concat elisp-dir "scala"))
;;(require 'scala-mode-auto)
;; (add-to-list 'load-path (concat elisp-dir "scala-mode2"))
;; (require 'scala-mode)
(add-to-list 'load-path (concat elisp-dir "markdown-mode"))
(autoload 'markdown-mode "markdown-mode"
     "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'markdown-mode-hook
          (lambda ()
            (flyspell-mode)
            (visual-line-mode t)
            ))




(add-hook 'scala-mode-hook
	  (lambda ()
	    (local-set-key [return]
			   '(lambda ()
			      (interactive)
			      (newline-and-indent)
			      (scala-indent:insert-asterisk-on-multiline-comment)))
	    (flyspell-prog-mode)))

(setq
 change-log-default-name "ChangeLog"
 default-major-mode 'text-mode
 default-truncate-lines t
 display-time-24hr-format t
 flyspell-issue-message-flag nil
 frame-title-format '(buffer-file-name "%f" ("%b"))
 ido-everywhere t
 indent-tabs-mode nil
 inhibit-startup-message t
 kill-whole-line t
 mac-option-modifier 'meta
 make-backup-files nil
 mouse-wheel-progressive-speed t
 mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil))
 mouse-yank-at-point nil
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
 tab-width 4
 save-place t)

(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(line-number-mode 1)
(display-time)
(show-paren-mode 1)
(column-number-mode 1)
(global-auto-revert-mode 1)
;;(global-visual-line-mode 0)
(if (fboundp 'global-visual-line-mode) (global-visual-line-mode 0))

(require 'cl)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; (unless (require 'el-get nil t)
;;   (url-retrieve
;;    "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
;;    (lambda (s)
;;      (end-of-buffer)
;;      (eval-print-last-sexp))))

;; ;; (setq el-get-sources
;; ;;       '((:name color-theme-solarized)
;; ;;         (:name
         

(add-to-list 'load-path (concat elisp-dir "soy-mode"))
(autoload 'soy-mode "soy-mode" "soy-mode")
(add-to-list 'auto-mode-alist '("\\.soy$" . soy-mode))

(add-to-list 'auto-mode-alist '("\\.soy$" . soy-mode))

(set-face-attribute 'default nil :height 110 :family "menlo")

;; ;; I'm hardcore. I search with regexp
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
;; (global-set-key [f1] 'tall-window)
;; ;;(define-key isearch-mode-map (kbd "C-r") 'isearch-repeat-backward)
;; ;; Write an isearch-mode-map binding for the arrow keys

;; (require 'uniquify)
;; (setq-default uniquify-buffer-name-style 'post-forward-angle-brackets)

;; (add-to-list 'load-path (concat elisp-dir "textmate"))
;; (with-library 'textmate
;;   (textmate-mode)
;;   (setq *textmate-gf-exclude* "/\\/\\.|(\\/|^)(\\.|vendor|fixtures|tmp|log|build)($|\\/)|(\\.xcodeproj|\\.nib|\\.framework|\\.app|\\.pbproj|\\.pbxproj|\\.xcode|\\.xcodeproj|\\.bundle|\\.pyc|\\.class|\\.jar)$"))
  
(defvar jcs-keys-mode-map nil "Keymap for jcs-keys mode.")
(setq jcs-keys-mode-map (make-sparse-keymap))
(define-minor-mode jcs-keys-mode
  "Minor mode that defines all of my favorite key bindings."
;;  :lighter "jk"
  :global t
  (define-key jcs-keys-mode-map [f6] `camelcase-word-at-point)
  ;; In Emacs 25.1 you get weird junk when you paste in the terminal if
  ;; you have M-[ bound to something.
  ;;  (define-key jcs-keys-mode-map (kbd "M-[") "“")
  ;;  (define-key jcs-keys-mode-map (kbd "M-]") "‘")
  (define-key jcs-keys-mode-map (kbd "M-{") "”")
  (define-key jcs-keys-mode-map (kbd "M-}") "’")
  (define-key jcs-keys-mode-map (kbd "M--") "–")
  (define-key jcs-keys-mode-map (kbd "M-_") "—")
  (define-key global-map (kbd "RET") 'newline-and-indent)
  ;; Shift space should insert a non-breaking space.
  (define-key jcs-keys-mode-map (kbd "S-<SPC>") #x00A0) ;; I don't think emacs can recognise shift-space. describe-key just says 'SPC'

  (define-key jcs-keys-mode-map (kbd "C-l") 'goto-line)
;;  (define-key jcs-keys-mode-map "\C-m" 'newline-and-indent)
  (define-key jcs-keys-mode-map (kbd "C-;") 'comment-or-uncomment-region-or-line)
  (define-key jcs-keys-mode-map (kbd "s-/") 'comment-or-uncomment-region-or-line)
  )
(jcs-keys-mode)


;; (define-key minibuffer-local-map (kbd "ESC") 'keyboard-quit) ;; Doesn't quite work yet...

;; (global-set-key (kbd "C-;") 'comment-or-uncomment-region-or-line)

;; (add-to-list 'load-path (concat elisp-dir "ocaml"))
;; (setq auto-mode-alist
;;           (cons '("\\.ml[iyl]?$" .  caml-mode) auto-mode-alist))

;; (autoload 'caml-mode "ocaml" (interactive)
;;   "Major mode for editing Caml code." t)
;; (autoload 'camldebug "camldebug" (interactive) "Debug caml mode")


;; (add-to-list 'load-path (concat elisp-dir "slime"))
;; (require 'slime)

;; (add-to-list 'load-path (concat elisp-dir "clojure-mode"))
;; (require 'clojure-mode)


(add-hook 'emacs-lisp-mode-hook
          (lambda () 
            (turn-on-eldoc-mode)
            (flyspell-prog-mode)
            (define-key emacs-lisp-mode-map [f5] 'eval-buffer)
            ))
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)

(add-to-list 'load-path "~/emacs/color-theme/")
(add-to-list 'load-path "~/emacs/color-themes/")
;; ;;  (require )  
;; ;;(if-emacs-app ;;I’m not sure why my color theme breaks in Terminal.app, but I don't feel like working on it now
;; ;; (with-library 'color-theme
;; ;;   (color-theme-initialize)
;; ;;   (setq color-theme-is-global t)
;; ;;   (color-theme-espresso)
;; ;;   )

(when (and (functionp 'server-running-p) (not (server-running-p)))
  (server-start))
(add-hook 'server-switch-hook
          (lambda ()

            ;; Always open new client sessions in a new frame
            (let ((server-buf (current-buffer)))
              (bury-buffer)
              (switch-to-buffer-other-frame server-buf))
            ;; Rebind both C-x k and C-x C-x to end the server session, rather than quit
            ;; FIXME: This doesn’t like it when the client is terminated before the buffer is closed
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map)))) 
            (local-set-key (kbd "C-x k") 'server-edit)
            (local-set-key (kbd "C-x C-c") 'server-edit)

            ;; Turn on flyspell-mode for git commit messages
            (when (string-match-p ".git/COMMIT_EDITMSG$" (buffer-file-name))
              (flyspell-mode)
              (turn-on-auto-fill))
            ))
(add-hook 'server-done-hook (lambda ()
                              (kill-buffer nil)
                              (delete-frame)))

;; ;; (define-key osx-key-mode-map (kbd "A-/") 'comment-or-uncomment-region-or-line)

;; ;;(autoload 'css2-mode "~/emacs/elisp/css2-mode" "Mode for editing CSS files" t)
;; ;;(add-to-list 'auto-mode-alist '("\\.css$" . css2-mode))

;; (global-set-key '[(f5)] 'call-last-kbd-macro)
;; (global-set-key (kbd "C-j") 'flyspell-check-previous-highlighted-word)
;; (global-set-key (kbd "C-c j") 'flyspell-check-previous-highlighted-word)
(global-set-key '[(f8)] 'flyspell-check-previous-highlighted-word)

;; ;; (add-to-list 'load-path "~/emacs/company")
;; ;; (autoload 'company-mode "company" nil t)

;; (define-key comint-mode-map [up] 'comint-previous-matching-input-from-input)
;; (define-key comint-mode-map [down] 'comint-next-matching-input-from-input)

;; (add-to-list 'load-path elisp-dir)
  
;; (autoload 'js2-mode "js2" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; (setq js2-highlight-level 3
;;       js2-basic-offset 4
;;       js2-use-font-lock-faces t
;;       js2-bounce-indent-p t
;;       js2-enter-indents-newline t)

;; ;; (add-to-list 'load-path (concat elisp-dir "auto-complete"))
;; ;; (require 'auto-complete-config)
;; ;; (add-to-list 'ac-dictionary-directories (concat elisp-dir "auto-complete/ac-dict"))
;; ;; (ac-config-default)

(require 'ido) ;; Improved file selection and buffer switching
(ido-mode t)
(setq
  ido-ignore-buffers                     ; ignore these guys
  '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido")
  ido-work-directory-list '("~/" "~/Desktop")
  ido-case-fold  t                       ; be case-insensitive
  ido-use-filename-at-point nil ; don't use filename at point (annoying)
  ido-use-url-at-point nil         ;  don't use url at point (annoying)
  ido-enable-flex-matching t             ; be flexible
  ido-max-prospects 6                    ; don't spam my minibuffer
  ido-confirm-unique-completion t) ; wait for RET, even with unique completion

;; ;; Support for html5 in nxml mode.
;; ;; See http://github.com/hober/html5-el/tree/master
;; (add-to-list 'load-path (concat elisp-dir "html5-el/"))
;; (eval-after-load "rng-loc"
;;   '(add-to-list 'rng-schema-locating-files (concat elisp-dir "html5-el/schemas.xml")))
;; (with-library 'whattf-dt)


;; ;; nxhml (HTML ERB template support)
;; (if-emacs-app
;; (with-loaded-file (concat elisp-dir "nxhtml/autostart.el")
;;   (setq
;;    nxhtml-global-minor-mode t
;;    mumamo-chunk-coloring 'submode-colored
;;    nxhtml-skip-welcome t
;;    indent-region-mode t
;;    rng-nxml-auto-validate-flag nil
;;    nxml-degraded t)
;;   (add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
;;   (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo-mode))
;;   (add-to-list 'auto-mode-alist '("\\.html\\.mako\\'" .  mako-html-mumamo-mode)))
;; )

;; (add-hook 'nXhtml-mode-hook
;;           (lambda ()
;;             (turn-on-visual-line-mode)
;;             ))

;; (add-hook 'eruby-nxhtml-mumamo-mode-hook (lambda ()
;;     (flyspell-prog-mode)
;;     (visual-line-mode t) ;;eruby-html-mumamo-mode-map 
;;     (define-key nxhtml-tag-map (kbd "M-{") "”"))
;; ;;    (define-key nxhtml-tag-map (kbd "M-}") "’")
;;     )
;; ;; (add-to-list 'load-path (concat elisp-dir "zencoding/"))
;; ;; (with-library 'zencoding-mode
;; ;;  (add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes
;; ;;  (add-hook 'eruby-nxhtml-mumamo-mode 'zencoding-mode)
;; ;;)


;; ;; Auto-indent pasted code. Figure out how to make this work with cmnd-v also
;; ;;   (dolist (command '(yank yank-pop))
;; ;;     (eval `(defadvice ,command (after indent-region activate)
;; ;;              (and (not current-prefix-arg)
;; ;;                   (member major-mode '(emacs-lisp-mode lisp-mode
;; ;;                                                        clojure-mode    scheme-mode
;; ;;                                                        haskell-mode    ruby-mode
;; ;;                                                        rspec-mode      python-mode
;; ;;                                                        c-mode          c++-mode
;; ;;                                                        objc-mode       latex-mode
;; ;;                                                        plain-tex-mode))
;; ;;                   (let ((mark-even-if-inactive transient-mark-mode))
;; ;;                     (indent-region (region-beginning) (region-end) nil))))))

;; (add-hook 'python-mode-hook (lambda () (flyspell-prog-mode)))

;; (add-hook 'css-mode-hook (lambda ()
;;                       (flyspell-prog-mode)
;;                       (set-newline-and-indent)
;;                       ))

;; (add-hook 'js2-mode-hook (lambda () (flyspell-prog-mode)))
(add-hook 'emacs-lisp-mode (lambda () (flyspell-prog-mode)))
  
;; (add-hook 'ruby-mode-hook (lambda ()
;;                          ;;   (flyspell-prog-mode)
;;                             (set-newline-and-indent)
;;                             (message "jonshea ruby mode")
;;                             ))

;; (setq ruby-mode-hook nil)

;; ;; (with-library 'ruby-block
;; ;;   (ruby-block-mode t)
;; ;;   (setq ruby-block-highlight-toggle t))

(add-to-list 'load-path (concat elisp-dir "thrift"))
(autoload 'thrift-mode "thrift-mode" "thrift-mode")
(add-to-list 'auto-mode-alist '("\\.thrift$" . thrift-mode))

(add-to-list 'auto-mode-alist '("BUILD$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))


;; (setq-default ispell-program-name "aspell")
;; (setq-default ispell-program-name "/usr/local/bin/aspell")

;; (add-to-list 'load-path (concat elisp-dir "yasnippet"))
;; (require 'yasnippet)
;; ;;  (setq yas/root-directory "~/emacs/yasnippet/snippets/")
;; ;;  (add-to-list 'yas/extra-mode-hooks 'ruby-mode-hook)
;; ;;  (yas/load-directory yas/root-directory)
;; (yas/initialize)
;; (yas/load-directory  "~/emacs/yasnippet/snippets")
  
;; (load-library "paren")
  
;; ;;  (autoload 'whizzytex-mode "/Users/jonshea/emacs/whizzytex/whizzytex" "WhizzyTeX, a minor-mode WYSIWYG environment for LaTeX" t) 
;; ;;  (setq-default whizzy-viewers '(("-skim" "skim")))
;; ;; (add-hook 'LaTeX-mode-hook (lambda ()
;; ;; 			     (TeX-fold-mode 1)))
;; ;; (autoload 'whizzytex-mode
;; ;;   "whizzytex"
;; ;;   "WhizzyTeX, a minor-mode WYSIWIG environment for LaTeX" t)

;; (add-to-list 'load-path "/opt/local/share/emacs/site-lisp/auctex" t)
;; (with-library 'tex-site)
;; ;;(load "/opt/local/share/emacs/site-lisp/auctex.el" nil t t)
;; ;;(add-to-list 'TeX-command-list '("pdflatex" "/opt/local/bin/pdflatex %s" PDFLaTeX t t :help "Run pdflatex") t)
;; ;;(add-hook 'LaTeX-mode-hook 'visual-line-mode)
;; ;;(setq TeX-engine "")
;; (setq TeX-newline-function 'newline-and-indent)
;; (add-hook 'LaTeX-mode-hook (lambda() (
;;           TeX-PDF-mode
;;           visual-line-mode
;;           LaTeX-math-mode
;;           )))
          
(setq interprogram-cut-function nil)
(setq interprogram-paste-function nil)
(defun paste-from-pasteboard ()
  (interactive)
  (and mark-active (filter-buffer-substring (region-beginning) (region-end) t))
  (insert (ns-get-pasteboard))
  )
(defun copy-to-pasteboard (p1 p2)
  (interactive "r*")
  (ns-set-pasteboard (buffer-substring p1 p2))
  (message "Copied selection to pasteboard")
  )
(defun cut-to-pasteboard (p1 p2) (interactive "r*") (ns-set-pasteboard (filter-buffer-substring p1 p2 t)) )
(global-set-key (kbd "s-v") 'paste-from-pasteboard)
(global-set-key (kbd "s-c") 'copy-to-pasteboard)
(global-set-key (kbd "s-x") 'cut-to-pasteboard)
