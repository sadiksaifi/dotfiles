;;---------------------- SETTING UP PACKAGE MANAGER --------------------------
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Install 'use-package' if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;---------------------- BASIC SETTINGS --------------------------
(tool-bar-mode -1)                                  ; Disable the toolbar
(tooltip-mode -1)                                   ; Disable tooltips
(set-fringe-mode 10)                                ; Give some breathing room
(menu-bar-mode -1)                                  ; Disable the menu bar
(blink-cursor-mode -1)                              ; Disables blinking cursor
(setq visible-bell nil)                             ; Disable up the visible bell
(column-number-mode 1)                              ; display column number in modeline
(global-display-line-numbers-mode t)                ; Enable line numbering in all buffers/modes
(setq display-line-numbers-type 'relative)          ; Set relative line number
(global-hl-line-mode 1)                             ; Enable cursor line
(setq use-dialog-box nil)                           ; Disable the dialog/popups boxes
(fset 'yes-or-no-p 'y-or-n-p)                       ; simplifying yes and no
;; Disable file backups
(setq make-backup-files nil)         ; Disable backup files
(setq auto-save-default nil)         ; Disable auto-save files
(setq select-enable-clipboard t)
;; Enable copy paste
(setq wl-copy-process nil)
(defun wl-copy (start end)
  (interactive "r")
  (call-process-region start end "wl-copy"))
(defun wl-paste ()
  (interactive)
  (call-process "wl-paste" nil t))

;;---------------------- FONT --------------------------
;; Set the default font
(set-face-attribute 'default nil
                    :family "JetBrainsMono Nerd Font"
                    :height 150)

;; Set the font for variable-pitch mode (used in some modes like Org Mode)
(set-face-attribute 'variable-pitch nil
                    :family "JetBrainsMono Nerd Font"
                    :height 150)

;;---------------------- THEME --------------------------
;; Configure the Doom theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)

  ;; Set the font for the Doom-One theme
  (setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))
  (setq doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))

  ;; Apply the Doom theme
  (doom-themes-neotree-config)
  (doom-themes-org-config))

;;---------------------- EVIL MODE --------------------------
;; Configure Evil mode
(setq evil-want-C-u-scroll t)
(setq evil-want-keybinding nil)
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

;; Configure Evil collection
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;;---------------------- ORG MODE --------------------------
;; Configure org-bullets
(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

;; Configure toc-org
(use-package toc-org
  :ensure t
  :hook (org-mode . toc-org-enable))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(toc-org org-bullets use-package one-themes evil-collection doom-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
