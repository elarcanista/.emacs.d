;;packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;;customs
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;no start up, tool bar or menu
(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)

;;fullscreen
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;;theme
(use-package dracula-theme
  :config (load-theme 'dracula))

;;delete word without copying
(defun my-delete-backward-word ()
  (interactive)
  (push-mark)
  (backward-word)
  (delete-region (point) (mark)))

;;kill-region+kill-whole-line
(defun my-kill-region ()
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (kill-whole-line)))

;;key bindings
(use-package bind-key
  :init
  (keyboard-translate ?\C-i ?\H-i)
  (keyboard-translate ?\C-m ?\H-m)
  :config
  (bind-keys*
   ("H-i" . previous-line)
   ("C-j" . left-char)
   ("C-k" . next-line)
   ("C-l" . right-char)
   ("S-C-i" . backward-paragraph)
   ("S-C-j" . left-word)
   ("S-C-k" . forward-paragraph)
   ("S-C-l" . right-word)
   ("M-i" . windmove-up)
   ("M-j" . windmove-left)
   ("M-k" . windmove-down)
   ("M-l" . windmove-right)
   ("S-C-SPC" . rectangle-mark-mode)
   ("<C-backspace>" . my-delete-backward-word)
   ("C-w" . my-kill-region)))

;;auto-refresh buffers
(global-auto-revert-mode t)

;;show line and column number
(add-hook 'prog-mode-hook 'linum-mode)
(setq-default column-number-mode t)

;;no tabs
(setq-default indent-tabs-mode nil)

;;trailing white-spaces
(use-package whitespace-mode
  :init
  (setq whitespace-style '(face trailing lines-tail empty tabs))
  (setq whitespace-line-column 80)
  :hook prog-mode)

;;80 chars lines
(use-package fill-column-indicator
  :init
  (setq fci-rule-column 80)
  (setq fci-rule-use-dashes t)
  :config
  (add-hook 'prog-mode-hook 'fci-mode)
  (add-hook 'LaTeX-mode-hook 'fci-mode)
  (add-hook 'XHTML-mode-hook 'fci-mode))

;;overwrite selection
(delete-selection-mode 1)

;;recursive mini-buffers
(setq enable-recursive-minibuffers t)

;;redo
(use-package undo-tree
  :bind
  (("C-z" . undo-tree-undo)
   ("S-C-z" . undo-tree-redo))
  :config (global-undo-tree-mode))

;;Spell-checking modes
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'XHTML-mode-hook 'flyspell-mode)

;;Select dictionaries
(let ((langs '("en" "es")))
  (setq lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert lang-ring elem)))

(defun cycle-ispell-languages ()
  (interactive)
  (let ((lang (ring-ref lang-ring -1)))
    (ring-insert lang-ring lang)
    (ispell-change-dictionary lang)))

;;Flyspell add word to dictionary
(defun my-save-word ()
  (interactive)
  (let ((current-location (point))
         (word (flyspell-get-word)))
    (when (consp word)
      (flyspell-do-correct 'save nil (car word) current-location
                           (cadr word) (cadr word) current-location))))

;;Correct next typo
(defun my-correct-next-word ()
  (interactive)
  (require 'flyspell-correct-ivy)
  (flyspell-goto-next-error)
  (flyspell-correct-word-generic))

;;flyspell bindings
(use-package flyspell-correct-ivy
  :ensure t
  :after flyspell
  :bind (:map flyspell-mode-map
              ("C-:" . my-save-word)
              ("<f5>" . cycle-ispell-languages)
              ("C-." . my-correct-next-word)))

;;modes
(use-package haskell-mode
  :mode "\\.hs\\'"
  :interpreter "Haskell")

;;skeletons
(require 'load-dir)
(add-to-list 'load-dirs "~/.emacs.d/templates/")
(auto-insert-mode)
(setq auto-insert-query nil)
(define-auto-insert "\\.cpp\\'" 'cpp-skeleton)
(define-auto-insert "\\.tex\\'" 'latex-skeleton)
