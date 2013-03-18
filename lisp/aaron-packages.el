;; shamelessly ripped from bbatsov's prelude

;; packages to install go here
(defvar aaron-packages
  '(linum clojure-mode color-theme-sanityinc-tomorrow evil evil-leader
          evil-numbers auto-indent-mode haskell-mode sml-mode
          highlight-parentheses key-chord magit pep8 pylint slime
          go-mode scala-mode2)
  "packages to install at launch")

;; we need dash for the loop constructs
(unless (package-installed-p 'dash)
  (package-refresh-contents)
  (package-install 'dash))
(require 'dash)

(defun aaron-packages-installed-p ()
  (-all? #'package-installed-p aaron-packages))

(defun aaron-install-packages ()
  (unless (aaron-packages-installed-p)
    ;; update package manifest
    (message "%s" "refreshing package database...")
    (package-refresh-contents)
    (message "%s" "done")
    ;; install missing
    (-each
     (-reject #'package-installed-p aaron-packages)
     #'package-install)))

(aaron-install-packages)
(provide 'aaron-packages)
