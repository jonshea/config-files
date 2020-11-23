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
(setq font-lock-maximum-decoration t)
(line-number-mode 1)
(display-time)
(show-paren-mode 1)
(column-number-mode 1)
(global-auto-revert-mode 1) ; Re-load changed files from disk
(if (fboundp 'global-visual-line-mode) (global-visual-line-mode 0)) ; Don't always soft wrap long lines

(set-face-attribute 'default nil :height 110 :family "menlo")

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
;; (global-set-key [f1] 'tall-window)

;; (require 'uniquify)
;; (setq-default uniquify-buffer-name-style 'post-forward-angle-brackets)

(defvar jcs-keys-mode-map nil "Keymap for jcs-keys mode.")
(setq jcs-keys-mode-map (make-sparse-keymap))
(define-minor-mode jcs-keys-mode
  "Minor mode that defines all of my favorite key bindings."
;;  :lighter "jk"
  :global t
  (define-key jcs-keys-mode-map [f6] `camelcase-word-at-point)
  ;; In Emacs 25.1 you get weird junk when you paste in the terminal if
  ;; you have M-[ bound to something.
  ;; (define-key jcs-keys-mode-map (kbd "M-[") "“")
  ;; (define-key jcs-keys-mode-map (kbd "M-]") "‘")
  ;; The following close quotes are kind of useless without the above open quotes
  ;; (define-key jcs-keys-mode-map (kbd "M-{") "”")
  ;; (define-key jcs-keys-mode-map (kbd "M-}") "’")
  (define-key jcs-keys-mode-map (kbd "M--") "–")
  (define-key jcs-keys-mode-map (kbd "M-_") "—")
  (define-key global-map (kbd "RET") 'newline-and-indent)
  ;; Shift space should insert a non-breaking space.
  (define-key jcs-keys-mode-map (kbd "S-<SPC>") #x00A0) ;; I don't think emacs can recognise shift-space. describe-key just says 'SPC'

  (define-key jcs-keys-mode-map (kbd "C-l") 'goto-line)
  (define-key jcs-keys-mode-map (kbd "C-;") 'comment-or-uncomment-region-or-line)
  (define-key jcs-keys-mode-map (kbd "s-/") 'comment-or-uncomment-region-or-line)
  )
(jcs-keys-mode)

;; (define-key minibuffer-local-map (kbd "ESC") 'keyboard-quit) ;; Doesn't quite work yet...

(add-hook 'emacs-lisp-mode-hook
  (lambda ()
    (turn-on-eldoc-mode)
    (flyspell-prog-mode)
    (define-key emacs-lisp-mode-map [f5] 'eval-buffer)
))
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)

(global-set-key '[(f8)] 'flyspell-check-previous-highlighted-word)

(require 'ido) ; Improved file selection and buffer switching
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

(add-to-list 'auto-mode-alist '("BUILD$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))

;; (if (version< emacs-version "24.4")
;;     (dolist (i '("php" "php3" "php5" "php7" "php-5" "php-5.5" "php7.0.1"))
;;       (add-to-list 'interpreter-mode-alist (cons i 'php-mode)))
;;   (add-to-list 'interpreter-mode-alist
;;                ;; Match php, php-3, php5, php7, php5.5, php-7.0.1, etc.
;;                (cons "php\\(?:-?[3457]\\(?:\\.[0-9]+\\)*\\)?" 'php-mode)))

(when (and
       (version< "24.3" emacs-version)
       (functionp 'package-installed-p)
       (not (package-installed-p 'use-package)))
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize)

  (package-refresh-contents)
  (package-install 'use-package)

  (use-package magit
    :ensure t
    :bind ("C-x g" . magit-status))
)


;; (setq interprogram-cut-function nil)
;; (setq interprogram-paste-function nil)
;; (defun paste-from-pasteboard ()
;;   (interactive)
;;   (and mark-active (filter-buffer-substring (region-beginning) (region-end) t))
;;   (insert (ns-get-pasteboard))
;;   )
;; (defun copy-to-pasteboard (p1 p2)
;;   (interactive "r*")
;;   (ns-set-pasteboard (buffer-substring p1 p2))
;;   (message "Copied selection to pasteboard")
;;   )
;; (defun cut-to-pasteboard (p1 p2) (interactive "r*") (ns-set-pasteboard (filter-buffer-substring p1 p2 t)) )
;; (global-set-key (kbd "s-v") 'paste-from-pasteboard)
;; (global-set-key (kbd "s-c") 'copy-to-pasteboard)
;; (global-set-key (kbd "s-x") 'cut-to-pasteboard)


;; (when (and (functionp 'server-running-p) (not (server-running-p)))
;;   (server-start))
;; (add-hook 'server-switch-hook
;;           (lambda ()

;;             ;; Always open new client sessions in a new frame
;;             (let ((server-buf (current-buffer)))
;;               (bury-buffer)
;;               (switch-to-buffer-other-frame server-buf))
;;             ;; Rebind both C-x k and C-x C-x to end the server session, rather than quit
;;             ;; FIXME: This doesn’t like it when the client is terminated before the buffer is closed
;;             (when (current-local-map)
;;               (use-local-map (copy-keymap (current-local-map))))
;;             (local-set-key (kbd "C-x k") 'server-edit)
;;             (local-set-key (kbd "C-x C-c") 'server-edit)

;;             ;; Turn on flyspell-mode for git commit messages
;;             (when (string-match-p ".git/COMMIT_EDITMSG$" (buffer-file-name))
;;               (flyspell-mode)
;;               (turn-on-auto-fill))
;;             ))
;; (add-hook 'server-done-hook (lambda ()
;;                               (kill-buffer nil)
;;                               (delete-frame)))

;; (global-set-key '[(f5)] 'call-last-kbd-macro)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(magit use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
