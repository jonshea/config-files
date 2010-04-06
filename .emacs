(defalias 'yes-or-no-p 'y-or-n-p)

(load "~/functions.el")

;;  Write something to make shift-space insert a NBSP

(prefer-coding-system 'utf-8-mac)
(set-terminal-coding-system 'utf-8-mac)
(set-keyboard-coding-system 'utf-8-mac)
(set-language-environment "UTF-8")

(setq
 change-log-default-name "ChangeLog"
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

(if (fboundp 'global-visual-line-mode) (global-visual-line-mode 1))

(require 'cl)

;;; This was installed by package-install.el.
(when (load
       (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
  
(set-face-attribute 'default nil :height 110 :family "menlo")

;; I'm hardcore. I search with regexp
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key [f1] 'tall-window)
;;(define-key isearch-mode-map (kbd "C-r") 'isearch-repeat-backward)
;; Write an isearch-mode-map binding for the arrow keys

(require 'uniquify)
(setq-default uniquify-buffer-name-style 'post-forward-angle-brackets)

(add-to-list 'load-path "~/projects/go-lang/misc/emacs" t)
(with-library 'go-mode-load)

(global-set-key (kbd "M-[") "“")
(global-set-key (kbd "M-{") "”")
(global-set-key (kbd "M-]") "‘")
(global-set-key (kbd "M-}") "’")
(global-set-key (kbd "M--") "–")
(global-set-key (kbd "M-_") "—")
(global-set-key (kbd "S-<SPC>") #x00A0) ;; I don't think emacs can recognise shift-space. describe-key just says 'SPC'

(global-set-key (kbd "C-l") 'goto-line)
(global-set-key "\C-m" 'newline-and-indent)
(define-key minibuffer-local-map (kbd "ESC") 'keyboard-quit) ;; Doesn't quite work yet...

(global-set-key (kbd "C-;") 'comment-or-uncomment-region-or-line)

(add-hook 'emacs-lisp-mode-hook
          (lambda () 
            (turn-on-eldoc-mode)
            (flyspell-prog-mode)
            (define-key emacs-lisp-mode-map [f5] 'eval-buffer)
            ))

(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)

(add-to-list 'load-path "~/emacs/color-theme/")
(if-emacs-app ;;I’m not sure why my color theme breaks in Terminal.app, but I don't feel like working on it now
(with-library 'color-theme
  (color-theme-initialize)
  (setq color-theme-is-global t)
  (color-theme-espresso)
  )
)
 
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

;; (define-key osx-key-mode-map (kbd "A-/") 'comment-or-uncomment-region-or-line)

;;(autoload 'css2-mode "~/emacs/elisp/css2-mode" "Mode for editing CSS files" t)
;;(add-to-list 'auto-mode-alist '("\\.css$" . css2-mode))

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
 ido-ignore-buffers                     ; ignore these guys
 '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido")
 ido-work-directory-list '("~/" "~/Desktop")
 ido-case-fold  t                       ; be case-insensitive
 ido-use-filename-at-point nil ; don't use filename at point (annoying)
 ido-use-url-at-point nil         ;  don't use url at point (annoying)
 ido-enable-flex-matching t             ; be flexible
 ido-max-prospects 6                    ; don't spam my minibuffer
 ido-confirm-unique-completion t) ; wait for RET, even with unique completion

;; Support for html5 in nxml mode.
;; See http://github.com/hober/html5-el/tree/master
(add-to-list 'load-path "~/emacs/html5-el/")
(eval-after-load "rng-loc"
  '(add-to-list 'rng-schema-locating-files "~/emacs/html5-el/schemas.xml"))
(with-library 'whattf-dt)


;; nxhml (HTML ERB template support)
(if-emacs-app
(with-loaded-file "~/emacs/nxhtml/autostart.el"
  (setq
   nxhtml-global-minor-mode t
   mumamo-chunk-coloring 'submode-colored
   nxhtml-skip-welcome t
   indent-region-mode t
   rng-nxml-auto-validate-flag nil
   nxml-degraded t)
  (add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
  (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo-mode)))
)

(add-to-list 'load-path "~/emacs/zencoding/")
(with-library 'zencoding-mode
  (add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes
;;  (add-hook 'eruby-nxhtml-mumamo-mode 'zencoding-mode)
  )
  
;; Ranari
;; (add-to-list 'load-path "~/emacs/rinari")
;; (require 'rinari)

;; Rails-reloaded
;;  (add-to-list 'load-path "~/emacs/emacs-rails-reloaded")
;;  (require 'rails-autoload)


(define-key global-map (kbd "RET") 'newline-and-indent)

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

(add-hook 'python-mode-hook (lambda () (flyspell-prog-mode)))

(add-hook 'css-mode-hook (lambda ()
                      (flyspell-prog-mode)
                      (set-newline-and-indent)
                      ))

(add-hook 'js2-mode-hook (lambda () (flyspell-prog-mode)))
(add-hook 'emacs-lisp-mode (lambda () (flyspell-prog-mode)))
  
(add-hook 'ruby-mode-hook (lambda ()
                         ;;   (flyspell-prog-mode)
                            (set-newline-and-indent)
                            (message "jonshea ruby mode")
                            ))

(setq ruby-mode-hook nil)

(with-library 'ruby-block
  (ruby-block-mode t)
  (setq ruby-block-highlight-toggle t))

(add-to-list 'load-path "~/emacs/yaml")
(with-library 'yaml-mode
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-hook 'yaml-mode-hook
            '(lambda ()
               (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

(setq-default ispell-program-name "aspell")

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

(setq-default ispell-program-name "/opt/local/bin/aspell")
