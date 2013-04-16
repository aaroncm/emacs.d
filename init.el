(add-to-list 'load-path "~/.emacs.d/lisp/")
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(require 'aaron-packages)

(add-to-list 'load-path "~/Devel/source-repos/ensime/dist/elisp/")
(require 'ensime)

(setq inhibit-startup-message t)

;; emacs needs to see /usr/local/bin for git
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setq exec-path (append '("/usr/local/bin") exec-path))

;; need to add this for python syntax checking (flake8)
(setq exec-path (append '("/usr/local/share/python") exec-path))

;; fuck tabs yo
(setq-default indent-tabs-mode nil)

;; no checkdoc, please
(eval-after-load 'flycheck
  '(setq flycheck-checkers
         (delq 'emacs-lisp-checkdoc flycheck-checkers)))

;; need this for sml-mode, for the duration of my sml class anyway
(setq exec-path
      (append '("/usr/local/Cellar/smlnj/110.75/libexec/bin") exec-path))

;; let's interactively do
(ido-mode t)

;; and automatically complete
(require 'auto-complete)
(global-auto-complete-mode t)

;; vim it up
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
(require 'surround)
(global-surround-mode 1)
(key-chord-mode 1)
(setq key-chord-two-keys-delay 0.3)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

;; font, color
(if window-system (set-face-attribute 'default nil :font "Source Code Pro-13"))
(color-theme-sanityinc-tomorrow-eighties)

;; show eols and hard tabs
(global-whitespace-mode)
(setq whitespace-style '(face trailing tabs lines-tail newline newline-mark
                              tab-mark empty))
(setq whitespace-display-mappings '((tab-mark 9 [9656 9] [92 9])
                                    (newline-mark 10 [172 10])))

;; paren highlights
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; auto indents
;; (setq-default indent-tabs-mode nil)
;; (setq auto-indent-on-visit-file t)
;; (auto-indent-global-mode)
;; (add-to-list 'auto-indent-disabled-modes-list 'haskell-mode)
;; (add-to-list 'auto-indent-disabled-modes-list 'python-mode)
(electric-indent-mode +1)

;; scrolling
(setq scroll-step 1)
(when window-system
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
  (setq mouse-wheel-progressive-speed nil))

;; window size
(if window-system (set-frame-size (selected-frame) 93 40))

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(global-set-key "\M-`" 'other-frame)

;; cmd-/ comment toggle
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (next-line)))
(global-set-key (kbd "M-/") 'comment-or-uncomment-region-or-line)

(global-set-key (kbd "M-g") 'magit-status)

;; line numbers
(setq column-number-mode t)
(global-linum-mode 1)
;; rendering workaround
(eval-after-load 'linum
  '(progn
     (defface linum-leading-zero
       `((t :inherit 'linum
            :foreground ,(face-attribute 'linum :background nil t)))
       "Face for displaying leading zeroes for line numbers in display margin."
       :group 'linum)
     (defun linum-format-func (line)
       (let ((w (length
                 (number-to-string (count-lines (point-min) (point-max))))))
         (concat
          (propertize (make-string (- w (length (number-to-string line))) ?0)
                      'face 'linum-leading-zero)
          (propertize (number-to-string line) 'face 'linum))))
     (setq linum-format 'linum-format-func)))

;; flycheck
(add-hook 'prog-mode-hook 'flycheck-mode)
(add-hook 'text-mode-hook 'flycheck-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-indent-blank-lines-on-move nil)
 '(auto-indent-next-pair-timer-geo-mean (quote ((default 0.0005 0))))
 '(auto-indent-on-visit-file nil)
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(haskell-mode-hook (quote (turn-on-haskell-indent)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
