(add-to-list 'load-path "~/.emacs.d/lisp/")
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(setq inhibit-startup-message t)

(require 'evil)
(evil-mode 1)
(require 'surround)
(global-surround-mode 1)
(key-chord-mode 1)
(setq key-chord-two-keys-delay 0.3)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

(if window-system (set-face-attribute 'default nil :font "Source Code Pro-13"))
(color-theme-sanityinc-tomorrow-eighties)

(global-whitespace-mode)
(setq whitespace-display-mappings '((space-mark 32 [32])
                                    (newline-mark 10 [172 10])
                                    (tab-mark 9 [9656 9] [92 9])))

(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

(setq column-number-mode t)
(global-linum-mode 1)

(setq-default indent-tabs-mode nil)
(setq auto-indent-on-visit-file t)
(auto-indent-global-mode)

(if window-system (set-frame-size (selected-frame) 93 40))

(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (next-line)))
(global-set-key (kbd "s-/") 'comment-or-uncomment-region-or-line)


(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

(add-hook 'linum-before-numbering-hook
          (lambda ()
            (let ((w (length (number-to-string
                              (count-lines (point-min) (point-max))))))
              (setq linum-format
                    `(lambda (line)
                       (propertize (concat
                                    (truncate-string-to-width
                                     "" (- ,w (length (number-to-string line)))
                                     nil ?\x2007)
                                    (number-to-string line))
                                   'face 'linum))))))

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-indent-next-pair-timer-geo-mean (quote ((default 0.0005 0))))
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
