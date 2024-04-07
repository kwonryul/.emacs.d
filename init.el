(desktop-save-mode 1)
(setq make-backup-files nil)
(setq auto-save-default nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(defvar my-ansi-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-ansi-term-shell)))
(ad-activate 'ansi-term)

(defun projectile-ansi-term ()
  (interactive)
  (let ((project-root (projectile-project-root)))
    (if project-root
        (let ((ansi-term-buffer (ansi-term "/bin/bash" (concat "ansi-term-" project-root))))
          (comint-send-string ansi-term-buffer (concat "cd " project-root "\n")))
      (let ((ansi-term-buffer (ansi-term "/bin/bash" "ansi-term-home")))
        (comint-send-string ansi-term-buffer "cd ~\n")))))

(global-set-key (kbd "<C-M-return>") 'projectile-ansi-term)

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

(defun lisp-hook ()
  (paredit-mode)
  (rainbow-delimiters-mode))

(add-hook 'emacs-lisp-mode-hook 'lisp-hook)
(add-hook 'clojure-mode-hook 'lisp-hook)
(add-hook 'cider-repl-mode-hook 'lisp-hook)

(advice-add 'lsp :before (lambda (&rest _args) (eval '(setf (lsp-session-server-id->folders (lsp-session)) (ht)))))

(setq projectile-track-known-projects-automatically nil)

(use-package treemacs-projectile :ensure t)
(global-set-key (kbd "C-c t") 'treemacs)
(defun move-to-treemacs ()
  "If treemacs is open, move to treemacs window."
  (interactive)
  (let ((treemacs-windows (seq-filter
                           (lambda (w)
                             (string-prefix-p " *Treemacs-Scoped" (buffer-name (window-buffer w))))
                           (window-list))))
    (if treemacs-windows
        (select-window (car treemacs-windows))
      (message "Treemacs buffer not opened."))))
(global-set-key (kbd "C-c f") 'move-to-treemacs)

(use-package ripgrep :ensure t)
(use-package magit :ensure t)

(global-set-key (kbd "C-S-f") 'projectile-ripgrep)

(defun clear ()
  "Clear all open buffers and windows."
  (interactive)
  (mapc 'kill-buffer (buffer-list))
  (delete-other-windows))

(defun resize ()
  "Resize all of the windows equal."
  (interactive)
  (balance-windows))

(defun kwonryul-github ()
  "Cat kwonryul-github token to emacs clipboard."
  (interactive)
  (let ((output (shell-command-to-string "cat ~/tokens/kwonryul-github")))
    (kill-new output)
    (message "Copied token to clipboard")))

(defun ssh-paper-auth ()
  "Start new shell buffer and ssh connect to paper-auth."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "ssh-paper-auth")))
    (with-current-buffer ansi-term-buffer
      (comint-send-string (current-buffer) "cd ~\n")
      (comint-send-string (current-buffer) "ssh -i ~/pems/paper-company.pem ubuntu@43.200.64.248\n"))))

(defun repl-paper-auth ()
  "Start paper-auth cider repl server as daemon."
  (interactive)
  (let ((prev-buffer (current-buffer))
        (ansi-term-buffer (ansi-term "/bin/bash" "repl-paper-auth")))
    (comint-send-string ansi-term-buffer "cd ~/dev/clojure/paper-auth\n")
    (comint-send-string ansi-term-buffer "clj -M:dev:cider\n")
    (switch-to-buffer prev-buffer)))

(use-package zenburn-theme :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes '(zenburn))
 '(custom-safe-themes
   '("f079ef5189f9738cf5a2b4507bcaf83138ad22d9c9e32a537d61c9aae25502ef" default))
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(zenburn-theme cmake-mode yasnippet which-key use-package treemacs-projectile ripgrep rainbow-delimiters professional-theme paredit magit lsp-ui lsp-java helm-lsp flycheck eink-theme company cloud-theme cider-eval-sexp-fu cider auto-compile))
 '(rainbow-delimiters-max-face-count 8))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono"))))
 '(rainbow-delimiters-base-error-face ((t (:inherit rainbow-delimiters-base-face :foreground "black"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "gray75"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "firebrick3"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "RoyalBlue2"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "yellow4"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "gray75"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "purple2"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "cyan3"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "chartreuse4")))))
