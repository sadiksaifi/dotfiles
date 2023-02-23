(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(use-package! dired
:ensure nil
:commands (dired dired-jump)
:bind (("C-x C-j" . dired-jump))
:custom ((dired-listing-switches "-agho --group-directories-first"))
:config
(evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files/")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 17)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 17)
      doom-big-font (font-spec :family "JetBrainsMono Font" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.7))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.2)))))

(set-face-attribute 'mode-line nil :font "Ubuntu Mono-13")
(setq doom-modeline-height 45     ;; sets modeline height
      doom-modeline-bar-width 5   ;; sets right bar width
      doom-modeline-persp-name t  ;; adds perspective name to modeline
      doom-modeline-persp-icon t) ;; adds folder icon next to persp name

(after! org
  (use-package! org-auto-tangle
      :defer t
      :hook (org-mode . org-auto-tangle-mode)
      :config
      (setq org-auto-tangle-default t)))
