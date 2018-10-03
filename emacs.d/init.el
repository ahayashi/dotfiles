;; -*-Emacs-Lisp-*-

;; (setq debug-on-error t)

;; load-path
(setq load-path (cons (expand-file-name "~/.emacs.d/elisp") load-path))
(setq load-path (cons (expand-file-name "~/.emacs.d/elisp/emacs-scala-mode") load-path))

;; auto generated .el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; auto install
(require 'package)

;; package repos
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(unless package-archive-contents (package-refresh-contents))

;;; On-demand installation of packages (by @purcell)
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION. If
NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version) t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(require-package 'csv-mode)
(require-package 'js2-mode)
(require-package 'json-mode)

;; do not generate backup files
(setq make-backup-files nil)
(setq delete-auto-save-files t)

;; delete -> bs
(normal-erase-is-backspace-mode 0)

;; when saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; remove menubar
(menu-bar-mode -1)

;; mode-line (column and line numbers)
(column-number-mode t)
(line-number-mode t)

;; mode-line (display-time)
(setq display-time-string-forms '(month "/" day " (" dayname ") " 12-hours ":" minutes am-pm))
(display-time)

;; mode-line (newline)
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; mode-line (filename)
(when (require 'uniquify nil t)
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq uniquify-ignore-buffers-re "*[^*]+*"))

;; scroll
(setq scroll-conservatively 1)

;; global-set-key
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-x\C-j" 'goto-line)

;; show paren
(show-paren-mode t)
(set-face-foreground 'show-paren-match "black")
(set-face-background 'show-paren-match "grey66")

;; indent / spacing
(setq-default tab-width 4 indent-tabs-mode nil)

;; color (font-lock)
(setq font-lock-support-mode 'jit-lock-mode)
(global-font-lock-mode t)  ; always turn on syntax highlighting
(set-face-foreground 'font-lock-comment-face "grey60")
(set-face-foreground 'font-lock-string-face  "grey50")
(set-face-foreground 'font-lock-keyword-face "royalblue1")
(set-face-foreground 'font-lock-function-name-face "sienna3")
(set-face-bold-p 'font-lock-function-name-face t)
(set-face-foreground 'font-lock-variable-name-face "white")
(set-face-foreground 'font-lock-type-face "cornflowerblue")
(set-face-foreground 'font-lock-builtin-face "green")
(set-face-foreground 'font-lock-constant-face "gray100")
(set-face-foreground 'font-lock-warning-face "red")
(set-face-bold-p 'font-lock-warning-face nil)

;; color (region)
(set-face-background 'region "gray66")
(set-face-foreground 'region "black")

;; major mode (adding suffixes)
(add-to-list 'auto-mode-alist (cons  "\\.\\(cu\\)\\'" 'c++-mode))
(add-to-list 'auto-mode-alist (cons  "\\.\\(hj\\)\\'" 'java-mode))
(add-to-list 'auto-mode-alist (cons  "dotzshrc" 'shell-script-mode))
(add-to-list 'auto-mode-alist (cons  "dotzshenv" 'shell-script-mode))

;; major mode (regiter new major modes)
(when (require 'chpl-mode nil t)
  (add-to-list 'auto-mode-alist (cons  "\\.\\(chpl\\)\\'" 'chpl-mode)))
(when (require 'llvm-mode nil t)
  (add-to-list 'auto-mode-alist (cons  "\\.\\(ll\\)\\'" 'llvm-mode)))
(when (require 'scala-mode nil t)
  (add-to-list 'auto-mode-alist (cons  "\\.\\(scala\\)\\'" 'scala-mode)))

;; major mode (c-mode)
(defun my-c-c++-mode-init () (setq c-basic-offset 4))

(add-hook 'c-mode-hook 'my-c-c++-mode-init)
(add-hook 'c++-mode-hook 'my-c-c++-mode-init)
