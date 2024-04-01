(desktop-save-mode 1)
(setq make-backup-files nil)
(setq auto-save-default nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq scroll-conservatively 100)
(setq ring-bell-function 'ignore)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)
(setq mouse-wheel-tilt-scroll t)
(setq mouse-wheel-flip-direction t)

(setq-default truncate-lines t)
(setq truncate-partial-width-windos nil)

(global-display-line-numbers-mode)

(windmove-default-keybindings)

(setq inhibit-startup-message t)

(setq select-enable-clipboard t)

(setq default-input-method "korean-hangul")
(global-set-key (kbd "<Hangul>") 'toggle-input-method)

(setq-default indent-tabs-mode nil)

(defvar my/find-file-previous-directory nil
  "Variable to store the previous working directory.")
(defun my/find-file-from-home-directory ()
  "Set the current directory to DIRECTORY and call 'find-file, then restore."
  (interactive)
  (setq my/find-file-previous-directory default-directory)
  (cd "~/")
  (call-interactively 'find-file)
  (when my/find-file-previous-directory
    (cd my/find-file-previous-directory)
    (setq my/find-file-previous-directory nil)))
(global-set-key (kbd "C-x C-f") 'my/find-file-from-home-directory)

(global-set-key (kbd "C-z") 'ace-window)
(setq aw-keys '(?x ?d ?f ?v ?n ?j ?k ?l))
(setq display-buffer-alist
      '(("\\*Treemacs-Scoped"
         (display-buffer-in-side-window)
         (window-width . 75))
         (".*"
          (display-buffer-same-window))))

(defun my-helm-display-buffer (buffer &optional resume)
  "Display helm buffer without modifying window configuration."
  (display-buffer buffer '(display-buffer-same-window)))
(setq helm-display-function 'my-helm-display-buffer)

(global-set-key (kbd "C-x C-z") 'revert-buffer)

(global-set-key (kbd "C-x b") 'ibuffer)

(use-package magit :ensure t)

(setq lsp-java-vmargs
      (list
	"-Xmx1G"
	"-XX:+UseG1GC"
	"-XX:-UseStringDeduplication"
        "-javaagent:/home/kwonryul/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/1.18.28/a2ff5da8bcd8b1b26f36b806ced63213362c6dcc/lombok-1.18.28.jar"))

(add-hook 'java-mode-hook
	  (setq c-basic-offset 4))

(use-package projectile :ensure t :init (projectile-mode +1))
(use-package flycheck :ensure t)
(use-package yasnippet :ensure t :config (yas-global-mode))
(use-package lsp-mode :ensure t :hook ((lsp-mode . lsp-enable-which-key-integration)))
(use-package hydra :ensure t)
(use-package company :ensure t)
(use-package lsp-ui :ensure t)
(use-package which-key :ensure t :config (which-key-mode))
(use-package lsp-java :ensure t :config (add-hook 'java-mode-hook 'lsp))
(use-package cider :ensure t)
(use-package paredit :ensure t)
(use-package rainbow-delimiters :ensure t)
(use-package cider-eval-sexp-fu :ensure t)
(use-package dap-mode :ensure t :after lsp-mode :config (dap-auto-configure-mode))
(use-package helm-lsp :ensure t)
(use-package helm :ensure t :config (helm-mode))
(use-package lsp-treemacs :ensure t)

(add-hook 'cider-repl-mode-hook #'paredit-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)

(advice-add 'lsp :before (lambda (&rest _args) (eval '(setf (lsp-session-server-id->folders (lsp-session)) (ht)))))

(setq projectile-track-known-projects-automatically nil)

(use-package treemacs-projectile :ensure t)
(global-set-key (kbd "C-c t") 'treemacs)
(global-set-key (kbd "<C-M-return>") 'projectile-run-shell)

(use-package ripgrep :ensure t)
(use-package magit :ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-themes
   '("f079ef5189f9738cf5a2b4507bcaf83138ad22d9c9e32a537d61c9aae25502ef" default))
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(zenburn-theme cmake-mode yasnippet which-key use-package treemacs-projectile ripgrep rainbow-delimiters professional-theme paredit magit lsp-ui lsp-java helm-lsp flycheck eink-theme company cloud-theme cider-eval-sexp-fu cider auto-compile)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
