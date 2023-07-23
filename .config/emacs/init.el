;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

(defvar bootstrap-version)
(let ((bootstrap-file
			 (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
			(bootstrap-version 6))
	(unless (file-exists-p bootstrap-file)
		(with-current-buffer
				(url-retrieve-synchronously
				 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
				 'silent 'inhibit-cookies)
			(goto-char (point-max))
			(eval-print-last-sexp)))
	(load bootstrap-file nil 'nomessage))

;; Use straight.el for use-package expressions
(straight-use-package 'use-package)
;; Sets :straight t by default
(setq straight-use-package-by-default t)

(setq user-emacs-directory "~/.cache/emacs")

(use-package no-littering)

;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(setq inhibit-startup-message t)                    ; Disable the default startup message

(tool-bar-mode -1)                                  ; Disable the toolbar
(tooltip-mode -1)                                   ; Disable tooltips
(set-fringe-mode 10)                                ; Give some breathing room
(menu-bar-mode -1)                                  ; Disable the menu bar
(blink-cursor-mode -1)                              ; Disables blinking cursor
(setq visible-bell nil)                             ; Disable up the visible bell

(column-number-mode 1)                              ; display column number in modeline
(global-display-line-numbers-mode t)                ; Enable line numbering in all buffers/modes
(setq display-line-numbers-type 'relative)          ; Set relative line number

(setq frame-title-format "GNU Emacs")               ; Setting frame title
(global-hl-line-mode 1)                             ; Enable cursor line
(setq use-dialog-box nil)                           ; Disable the dialog/popups boxes
(fset 'yes-or-no-p 'y-or-n-p)                       ; simplifying yes and no
(setq global-auto-revert-non-file-buffers t)        ; Revert Dired and other buffers
(global-auto-revert-mode 1)                         ; Enable refreshing buffers automatically
(setq-default tab-width 2)                          ; Enable two tabs
(recentf-mode 1)                                    ; Enable recent files accessiblity
(save-place-mode 1)                                 ; Droping cursor on the last edited line
(electric-pair-mode 1)                              ; Enable auto pair parenthesis
(setq vc-follow-symlinks t)                         ; Enable follow symlinks
(setq user-full-name "Sadik Saifi")                 ; Sets name
(setq user-mail-address "Sadiksaifi205@gmail.com")  ; Sets email address

(scroll-bar-mode -1)

(defun efs/disable-scroll-bars (frame)
  (modify-frame-parameters frame
                           '((vertical-scroll-bars . nil)
                             (horizontal-scroll-bars . nil))))
(add-hook 'after-make-frame-functions 'efs/disable-scroll-bars)

(defvar efs/default-font-size 150)
(defvar efs/default-variable-font-size 150)

;; Set the default font
(set-face-attribute 'default nil
                    :font "JetBrainsMono Nerd Font"
                    :height efs/default-font-size
                    :weight 'medium)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil
                    :font "JetBrainsMono Nerd Font"
                    :height efs/default-font-size
                    :weight 'medium)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil
                    :font "Roboto"
                    :height efs/default-variable-font-size
                    :weight 'medium)

;; Needed if using emacsclient. Otherwise, your fonts will be smaller than expected.
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-13"))
(setq default-frame-alist '((font . "JetBrainsMono Nerd Font-13")))

(defvar efs/frame-transparency '(85 . 85))
(set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(setq bookmark-default-file "~/.config/emacs/bookmarks")

(use-package dashboard
  :init
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "          ---- WELCOME TO THE CHRUCH OF EMACS ----\n\
\nFind file           (C-x C-f)   \
Open buffer list    (C-x C-b)\
\nFind recent files   (C-c f r)   \
Open the vterm      (C-x C-t)\
\nOpen file manager   (C-x C-d)   \
List of bookmarks   (C-x r b)")
  (setq dashboard-startup-banner 'logo) 
  (setq dashboard-center-content nil) 
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 5)
                          (projects . 5)
                          (registers . 5)))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book"))))

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package general
  :after evil
  :config
  (general-create-definer efs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (efs/leader-keys
    "tt" '(counsel-load-theme :which-key "choose theme")
    "fde" '(lambda () (interactive) (find-file (expand-file-name "~/.config/emacs/README.org")))
    "." '(counsel-find-file :which-key "Find file")))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package doom-themes
  :init (load-theme 'doom-one t))

(use-package all-the-icons
    :straight t
    :if (display-graphic-p))

(use-package all-the-icons
  :straight t)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 50)))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("C-x C-b" . counsel-switch-buffer))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(defun efs/org-font-setup ()
(dolist
    (face
        '((org-level-1 1.3 "#51afef" extra-bold)
        (org-level-2 1.2 "#c678dd" bold)
        (org-level-3 1.1 "#98be65" semi-bold)
        (org-level-4 1.05 "#da8548" normal)
        (org-level-5 1.0 "#5699af" normal)
        (org-level-6 1.0 "#a9a1e1" normal)
        (org-level-7 1.0 "#46d9ff" normal)
        (org-level-8 1.0 "#ff6c6b" normal)))

    (set-face-attribute (nth 0 face) nil
                        :font "Roboto"
                        :weight (nth 3 face)
                        :height (nth 1 face)
                        :foreground (nth 2 face))

    (set-face-attribute 'org-default nil
												:family "Roboto"
                        :weight 'medium
												:height 1.0)

    (set-face-attribute 'org-table nil
                        :font "JetBrainsMono Nerd Font"
                        :weight 'normal
                        :height 1.0
                        :foreground "#bfafdf")

    (set-face-attribute 'org-block nil
                        :font "JetBrainsMono Nerd Font"
                        :weight 'medium
                        :height 1.0))

    ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
    (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
    (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(defun efs/org-mode-setup ()
	(interactive)
	(org-indent-mode)
	(display-line-numbers-mode -1) 
	(variable-pitch-mode 1)
	(setq-default truncate-lines t)
	(visual-line-mode 1))

(use-package org
	;;:pin org
	:commands (org-capture org-agenda)
	:hook ((org-mode . efs/org-mode-setup)
					(org-mode . efs/org-font-setup))
	:bind (("C-c C-a l" . 'org-agenda-list))
	:config
	(setq org-ellipsis " ▾"
				org-src-fontify-natively t
				org-fontify-quote-and-verse-blocks t
				org-src-tab-acts-natively t
				org-edit-src-content-indentation 0
				org-hide-block-startup nil
				org-src-preserve-indentation nil
				org-startup-folded 'content
				org-cycle-separator-lines 2
				org-hide-emphasis-markers t)

	(setq org-agenda-start-with-log-mode t)
	(setq org-log-done 'time)
	(setq org-log-into-drawer t)

	(setq org-agenda-files
				'("~/Projects/Org/Tasks.org"
					"~/Projects/Org/Journal.org"))

	(require 'org-habit)
	(add-to-list 'org-modules 'org-habit)
	(setq org-habit-graph-column 60)

	(setq org-todo-keywords
		'((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
			(sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

	(setq org-refile-targets
		'(("Archive.org" :maxlevel . 1)
			("Tasks.org" :maxlevel . 1)))

	;; Save Org buffers after refiling!
	(advice-add 'org-refile :after 'org-save-all-org-buffers)

	(setq org-tag-alist
		'((:startgroup)
			 ; Put mutually exclusive tags here
			 (:endgroup)
			 ("@errand" . ?E)
			 ("@home" . ?H)
			 ("@work" . ?W)
			 ("agenda" . ?a)
			 ("planning" . ?p)
			 ("publish" . ?P)
			 ("batch" . ?b)
			 ("note" . ?n)
			 ("idea" . ?i)))

	;; Configure custom agenda views
	(setq org-agenda-custom-commands
	 '(("d" "Dashboard"
		 ((agenda "" ((org-deadline-warning-days 7)))
			(todo "NEXT"
				((org-agenda-overriding-header "Next Tasks")))
			(tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

		("n" "Next Tasks"
		 ((todo "NEXT"
				((org-agenda-overriding-header "Next Tasks")))))

		("W" "Work Tasks" tags-todo "+work-email")

		;; Low-effort next actions
		("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
		 ((org-agenda-overriding-header "Low Effort Tasks")
			(org-agenda-max-todos 20)
			(org-agenda-files org-agenda-files)))

		("w" "Workflow Status"
		 ((todo "WAIT"
						((org-agenda-overriding-header "Waiting on External")
						 (org-agenda-files org-agenda-files)))
			(todo "REVIEW"
						((org-agenda-overriding-header "In Review")
						 (org-agenda-files org-agenda-files)))
			(todo "PLAN"
						((org-agenda-overriding-header "In Planning")
						 (org-agenda-todo-list-sublevels nil)
						 (org-agenda-files org-agenda-files)))
			(todo "BACKLOG"
						((org-agenda-overriding-header "Project Backlog")
						 (org-agenda-todo-list-sublevels nil)
						 (org-agenda-files org-agenda-files)))
			(todo "READY"
						((org-agenda-overriding-header "Ready for Work")
						 (org-agenda-files org-agenda-files)))
			(todo "ACTIVE"
						((org-agenda-overriding-header "Active Projects")
						 (org-agenda-files org-agenda-files)))
			(todo "COMPLETED"
						((org-agenda-overriding-header "Completed Projects")
						 (org-agenda-files org-agenda-files)))
			(todo "CANC"
						((org-agenda-overriding-header "Cancelled Projects")
						 (org-agenda-files org-agenda-files)))))))

	(setq org-capture-templates
		`(("t" "Tasks / Projects")
			("tt" "Task" entry (file+olp "~/Projects/Org/Tasks.org" "Inbox")
					 "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

			("j" "Journal Entries")
			("jj" "Journal" entry
					 (file+olp+datetree "~/Projects/Org/Journal.org")
					 "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
					 ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
					 :clock-in :clock-resume
					 :empty-lines 1)
			("jm" "Meeting" entry
					 (file+olp+datetree "~/Projects/Org/Journal.org")
					 "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
					 :clock-in :clock-resume
					 :empty-lines 1)

			("w" "Workflows")
			("we" "Checking Email" entry (file+olp+datetree "~/Projects/Org/Journal.org")
					 "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

			("m" "Metrics Capture")
			("mw" "Weight" table-line (file+headline "~/Projects/Org/Metrics.org" "Weight")
			 "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

	(define-key global-map (kbd "C-c j")
		(lambda () (interactive) (org-capture nil "jj"))))

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t)
  (org-superstar-leading-bullet ?\s)
  (org-indent-mode-turns-on-hiding-stars nil)
  (org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 135
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(with-eval-after-load 'org
  (org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . t)
      (python . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(with-eval-after-load 'org

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src sh"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
(add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
(add-to-list 'org-structure-template-alist '("js" . "src javascript"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("go" . "src go"))
(add-to-list 'org-structure-template-alist '("yaml" . "src yaml"))
(add-to-list 'org-structure-template-alist '("json" . "src json")))

(with-eval-after-load 'org
  (use-package org-auto-tangle
      :defer t
      :hook (org-mode . org-auto-tangle-mode)
      :config
      (setq org-auto-tangle-default t)))

(use-package toc-org
  :after org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode)
  ;; :hook ((c-mode
  ;;         c++-mode
  ;;         java-mode
  ;;         js-mode
  ;;         js-jsx-mode
  ;;         typescript-mode
  ;;         web-mode). lsp)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-headerline-breadcrumb-enable nil)
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-ivy
  :after lsp)

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands magit-status
  :bind (("C-x G" . magit-status) 
         ("C-x C-g s" . magit-status))
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
(use-package forge
  :after magit)

(use-package evil-nerd-commenter
  :bind ("C-/" . evilnc-comment-or-uncomment-lines))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "zsh")  ;; Change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  (setq vterm-shell "zsh")                         ;; Set this to customize the shell to launch
  (setq display-line-numbers-mode -1)
  (setq vterm-max-scrollback 10000))

(use-package vterm-toggle
  :bind ("C-x C-t" . 'vterm-toggle))

(when (eq system-type 'windows-nt)
  (setq explicit-shell-file-name "powershell.exe")
  (setq explicit-powershell.exe-args '()))

(defun efs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt
  :after eshell)

(use-package eshell
  :hook (eshell-first-time-mode . efs/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'powerline))

(use-package dired
  :straight nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . 'counsel-dired-jump)
         ("C-c f r" . 'counsel-recentf))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package dired-single
  :commands (dired dired-jump))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :commands (dired dired-jump)
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "." 'dired-hide-dotfiles-mode))

(setq delete-by-moving-to-trash t
trash-directory "~/.local/share/Trash/files/")

(setq gc-cons-threshold (* 2 1000 1000))
