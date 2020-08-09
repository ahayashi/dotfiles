;; -*-Emacs-Lisp-*-

;; (setq debug-on-error t)

;; auto generated .el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package.el
(when (require 'use-package nil t)
  ;; major-modes
  (use-package cuda-mode :mode ("\\.cu\\'" . cuda-mode))
  (use-package chpl-mode :load-path ("elisp") :mode ("\\.chpl\\'" . chpl-mode))
  (use-package js2-mode :mode ("\\.js\\'" . js2-mode))
  (use-package llvm-mode :load-path ("elisp") :mode ("\\.ll\\'" . llvm-mode))
  (use-package scala-mode :load-path ("elisp/emacs-scala-mode") :mode ("\\.scala\\'" . scala-mode))
  (use-package shell-script-mode :mode ("dotzshrc" . shell-script-mode) ("dotzshenv" . shell-script-mode))
  (use-package rust-mode :mode ("\\.rs\\'" . rust-mode))
  ;; mode-line (filename)
  (use-package uniquify
    :config
    (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
    (setq uniquify-ignore-buffers-re "*[^*]+*"))
  )

;; delete -> bs
(normal-erase-is-backspace-mode 0)

;; global-set-key
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-x\C-j" 'goto-line)

;; indent / spacing
(setq-default c-default-style "k&r"
              c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)

;;;; indent for lambda expressions
(if (>= emacs-major-version 26)
    (setq c-offsets-alist '((inlambda . 0))) ; experimental
  (defadvice c-lineup-arglist (around my activate)
    "Improve indentation of continued C++11 lambda function opened as argument."
    (setq ad-return-value
          (if (and (equal major-mode 'c++-mode)
                   (ignore-errors
                     (save-excursion
                       (goto-char (c-langelem-pos langelem))
                       ;; Detect "[...](" or "[...]{". preceded by "," or "(",
                       ;;   and with unclosed brace.
                       (looking-at ".*[(,][ \t]*\\[[^]]*\\][ \t]*[({][^}]*$"))))
              0                           ; no additional indent
            ad-do-it)))                   ; default behavior
  )

;; do not generate backup files
(setq make-backup-files nil)
(setq delete-auto-save-files t)

;; when saving
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; remove menubar
(menu-bar-mode -1)

;; mode-line (column and line numbers)
(column-number-mode t)
(line-number-mode t)

;; mode-line (display-time)
(setq display-time-string-forms '(month "/" day " (" dayname ") " 12-hours ":" minutes am-pm))
(display-time)

;; mode-line (show newline)
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; scroll
(setq scroll-conservatively 1)

;; show paren
(show-paren-mode t)
(set-face-foreground 'show-paren-match "black")
(set-face-background 'show-paren-match "grey66")

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
