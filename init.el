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
(defadvice pop-to-buffer (before cancel-other-window first)
  (ad-set-arg 1 nil))
(ad-activate 'pop-to-buffer)
(setq pop-up-windows nil)

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
          (lambda ()
            (setq c-basic-offset 4)
            (local-set-key (kbd "<M-return>") 'lsp-execute-code-action)))

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

(setq lsp-java-configuration-runtimes '[(:name "JavaSE-11"
                                               :path "/usr/lib/jvm/java-11-openjdk-amd64/")
                                        (:name "JavaSE-17"
                                               :path "/usr/lib/jvm/java-17-openjdk-amd64/"
                                               :default t)])

(defun lisp-hook ()
  (paredit-mode)
  (rainbow-delimiters-mode))

(add-hook 'emacs-lisp-mode-hook 'lisp-hook)
(add-hook 'clojure-mode-hook 'lisp-hook)
(add-hook 'cider-repl-mode-hook 'lisp-hook)

(use-package haskell-mode :ensure t)

(use-package elpy :ensure t :defer t :init) (advice-add 'python-mode :before 'elpy-enable)
(setq-default python-indent-offset 4)

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

(defun org-mode-setup ()
  (org-indent-mode))

(defun org-font-setup ()
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))))

(use-package org
  :ensure t
  :hook (org-mode . org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t)
  (org-font-setup))

(use-package org-bullets
  :ensure t
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("●" "○" "●" "○" "●" "○" "●")))

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

(defun ssh-pf-trpg ()
  "Start new shell buffer and ssh connect to pf-trpg."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "ssh-pf-trpg")))
    (with-current-buffer ansi-term-buffer
      (comint-send-string (current-buffer) "cd ~\n")
      (comint-send-string (current-buffer) "ssh -i ~/pems/nwrn.pem ubuntu@43.201.216.183\n"))))

(defun ssh-pf-contest ()
  "Start new shell buffer and ssh connect to pf-contest."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "ssh-pf-contest")))
    (with-current-buffer ansi-term-buffer
      (comint-send-string (current-buffer) "cd ~\n")
      (comint-send-string (current-buffer) "ssh -i ~/pems/nwrn.pem ubuntu@43.201.201.45\n"))))

(defun repl-pf-trpg ()
  "Start pf-trpg cider repl server."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "repl-pf-trpg")))
    (comint-send-string ansi-term-buffer "cd ~/nwrn/pf-trpg\n")
    (comint-send-string ansi-term-buffer "clj -M:dev:cider\n")))

(defun repl-pf-trpg-cljs ()
  "Start pf-trpg cljs cider repl server."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "repl-pf-trpg-cljs")))
    (comint-send-string ansi-term-buffer "cd ~/nwrn/pf-trpg\n")
    (comint-send-string ansi-term-buffer "npx shadow-cljs watch app\n")))

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
   '(haskell-mode elpy zenburn-theme cmake-mode yasnippet which-key use-package treemacs-projectile ripgrep rainbow-delimiters professional-theme paredit magit lsp-ui lsp-java helm-lsp flycheck eink-theme company cloud-theme cider-eval-sexp-fu cider auto-compile))
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
