;;packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
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

;;auto-refresh buffers
(global-auto-revert-mode t)

;;show line and column number
(add-hook 'prog-mode-hook 'linum-mode)
(setq-default column-number-mode t)

;;no tabs
(setq-default indent-tabs-mode nil)

;;trailing whitespaces
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
  (add-hook 'prog-mode-hook 'fci-mode))

;;overwrite selection
(delete-selection-mode 1)

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
   ("S-C-SPC" . rectangle-mark-mode)))

;;redo
(use-package undo-tree
  :bind
  (("C-z" . undo-tree-undo)
   ("S-C-z" . undo-tree-redo))
  :config (global-undo-tree-mode))

;;modes
(use-package haskell-mode
  :mode "\\.hs\\'"
  :interpreter "Haskell")
