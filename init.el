(desktop-save-mode 1)
(setq make-backup-files nil)
(setq auto-save-default nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(defun return-t (orig-fun &rest args)
  t)
(defun return-nil (orig-fun &rest args)
  nil)
(defun auto-yes (orig-fun &rest args)
  (advice-add 'yes-or-no-p :around #'return-t)
  (advice-add 'y-or-n-p :around #'return-t)
  (let ((res (apply orig-fun args)))
    (advice-remove 'yes-or-no-p #'return-t)
    (advice-remove 'y-or-n-p #'return-t)
    res))

(defun auto-no (orig-fun &rest args)
  (advice-add 'yes-or-no-p :around #'return-nil)
  (advice-add 'y-or-n-p :around #'return-nil)
  (let ((res (apply orig-fun args)))
    (advice-remove 'yes-or-no-p #'return-nil)
    (advice-remove 'y-or-n-p #'return-nil)
    res))

(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "# This buffer is for text that is not saved.\n#+OPTIONS: ^:{} toc:nil num:0\n\n")
(global-set-key (kbd "C-c C-<return>") 'scratch-buffer)

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
(setq truncate-partial-width-windows nil)

(global-display-line-numbers-mode)

(windmove-default-keybindings)

(setq inhibit-startup-message t)

(setq select-enable-clipboard t)

(setq default-input-method "korean-hangul")
(global-set-key (kbd "<Hangul>") 'toggle-input-method)

(setq temporary-file-directory "/tmp/")

(setq browse-url-browser-function 'browse-url-chrome)

(setq-default indent-tabs-mode nil)

(defvar my/find-file-previous-directory nil
  "Variable to store the previous working directory.")
(defun my/find-file-from-home-directory ()
  "Set the current directory to DIRECTORY and call find-file, then restore."
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
      '(("*Warnings*"
         (display-buffer-no-window))
        ("\\*Treemacs-Scoped"
         (display-buffer-in-side-window)
         (window-width . 75))
        ("\\*Edit Formulas\\*"
         (display-buffer-below-selected))
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

(use-package projectile :ensure t :init (projectile-mode +1))
(use-package lsp-mode :ensure t :hook ((lsp-mode . lsp-enable-which-key-integration)))
(use-package hydra :ensure t)
(use-package company :ensure t)
(use-package lsp-ui :ensure t)
(use-package which-key :ensure t :config (which-key-mode))
(use-package dap-mode :ensure t :after lsp-mode :config (dap-auto-configure-mode))
(use-package helm-lsp :ensure t)
(use-package helm :ensure t :config (helm-mode))
(use-package lsp-treemacs :ensure t)

;; flycheck
(use-package flycheck :ensure t)

;; yasnippet
(use-package yasnippet :ensure t :config (yas-global-mode))
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(setq yas-indent-line 'fixed)

;; Haskell
(use-package haskell-mode :ensure t)
(use-package lsp-haskell :ensure t)
(add-hook 'haskell-mode-hook
          (lambda ()
            (interactive-haskell-mode)
            (define-key interactive-haskell-mode-map (kbd "M-.") 'lsp-find-definition)
            (local-set-key (kbd "C-.") 'lsp-find-implementation)
            (local-set-key (kbd "<M-return>") 'lsp-execute-code-action)
            (lsp)))

;; Lisp
(use-package paredit :ensure t)
(use-package rainbow-delimiters :ensure t)
(defun lisp-hook ()
  (paredit-mode)
  (rainbow-delimiters-mode))
(add-hook 'emacs-lisp-mode-hook 'lisp-hook)
(add-hook 'clojure-mode-hook 'lisp-hook)
(add-hook 'cider-repl-mode-hook 'lisp-hook)

;; Clojure
(use-package cider :ensure t)
(use-package cider-eval-sexp-fu :ensure t)
(setq cider-repl-pop-to-buffer-on-connect nil)
(add-to-list 'load-path "/home/kwonryul/.emacs.d/cider-storm")
(require 'cider-storm)
(define-key cider-mode-map (kbd "C-c C-v") 'cider-storm-map)

;; Java
(use-package lsp-java :ensure t)
(setq lsp-java-vmargs
      (list
       "-Xmx32G"
       "-Xms16G"
       "-XX:+UseG1GC"
       "-XX:-UseStringDeduplication"
       "-javaagent:/home/kwonryul/.emacs.d/lombok/lombok-1.18.32.jar"))
(setq lsp-java-configuration-runtimes '[(:name "JavaSE-17"
                                               :path "/usr/lib/jvm/java-17-openjdk-amd64/"
                                               :default t)])
(defun lsp-java-pre-init-hook ()
  (let ((dir "/home/kwonryul/.emacs.d/workspace/.metadata/.plugins/org.eclipse.core.resources"))
    (when (file-directory-p dir)
      (delete-directory dir 'recursive))))
(add-hook 'lsp-before-initialize-hook #'lsp-java-pre-init-hook)
(add-hook 'java-mode-hook
          (lambda ()
            (setq c-basic-offset 4)
            (local-set-key (kbd "C-.") 'lsp-find-implementation)
            (local-set-key (kbd "<M-return>") 'lsp-execute-code-action)
            (lsp)))

;; Python
(use-package lsp-pyright :ensure t)
(setq lsp-pylsp-plugins-pydocstyle-enabled nil)
(setq-default python-indent-offset 4)
(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key (kbd "C-.") 'lsp-find-implementation)
            (local-set-key (kbd "<M-return>") 'lsp-execute-code-action)
            (lsp)))

;; C
(add-hook 'c-mode-hook
          (lambda ()
            (local-set-key (kbd "C-.") 'lsp-find-implementation)
            (local-set-key (kbd "<M-return>") 'lsp-execute-code-action)
            (lsp)))

;; C++
(add-hook 'c++-mode-hook
          (lambda ()
            (lsp)))

;; Javascript / Typescript / Vue
(setq exec-path (append exec-path '("~/.nvm/versions/node/v20.18.0/bin")))
(use-package typescript-mode :ensure t)
(use-package vue-mode :ensure t)
(defun vue-hook ()
  (local-set-key (kbd "M-.") 'lsp-find-definition)
  (local-set-key (kbd "C-.") 'lsp-find-implementation)
  (local-set-key (kbd "<M-return>") 'lsp-execute-code-action)
  (lsp))
(add-hook 'vue-mode-hook 'vue-hook)
(add-hook 'js-mode-hook 'vue-hook)
(add-hook 'typescript-mode-hook 'vue-hook)
(add-hook 'vue-html-mode-hook 'vue-hook)

;; JSON
(use-package json-mode :ensure t)

;; YAML
(use-package yaml-mode :ensure t)

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

(use-package ejc-sql :ensure t)
(setq clomacs-httpd-default-port 8090)
(add-hook 'sql-mode-hook 'ejc-sql-mode)

(defun org-mode-setup ()
  (org-indent-mode))

(defun org-font-setup ()
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))))

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

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)
   (sql . t)
   (clojure . t)
   (haskell . t)
   (python . t)
   (C . t)
   (java . t)))

(setq org-babel-clojure-backend 'cider)
(setq org-babel-python-command "python3")

(setq org-src-window-setup 'current-window)

(setq org-html-head
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"file:///home/kwonryul/.emacs.d/css/org.css\" />")

(defun view-org ()
  (interactive)
  (advice-add 'org-export-as :around #'auto-no)
  (let* ((html-content (org-export-as 'html))
         (output-file "/tmp/org-export.html"))
    (with-temp-buffer
      (insert html-content)
      (write-file output-file))
    (browse-url-of-file output-file))
  (advice-remove 'org-export-as #'auto-no))

(setq ejc-preconnect-db ())
(setq ejc-preconnect-buffer ())
(defun ejc-preconnect-hook ()
  (remove-hook 'ejc-sql-connected-hook #'ejc-preconnect-hook)
  (switch-to-buffer ejc-preconnect-buffer)
  (ejc-connect ejc-preconnect-db)
  (setq ejc-preconnect-db ())
  (setq ejc-preconnect-buffer ())
  (advice-add 'ejc-connect :around #'ejc-preconnect))
(defun ejc-preconnect (orig-fun db)
  (setq ejc-preconnect-db db)
  (setq ejc-preconnect-buffer (current-buffer))
  (advice-remove 'ejc-connect #'ejc-preconnect)
  (add-hook 'ejc-sql-connected-hook #'ejc-preconnect-hook)
  (with-temp-buffer
    (ejc-connect db)))

(advice-add 'ejc-connect :around #'ejc-preconnect)
(advice-add 'clear :before #'ejc-quit-connection)

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "s-e") 'view-org)
            (local-set-key (kbd "s-c") 'cider-jack-in)
            (local-set-key (kbd "C-c a") 'org-babel-result-hide-all)
            (local-set-key (kbd "C-c c") 'ejc-connect)))
(global-set-key (kbd "C-c q") 'ejc-quit-connection)

(use-package restclient :ensure t)
(add-to-list 'auto-mode-alist '("\\.rest\\'" . restclient-mode))
(add-hook 'restclient-mode-hook
          (lambda ()
            (local-set-key (kbd "<M-return>") 'json-mode)
            (add-hook 'json-mode-hook
                      (lambda ()
                        (local-set-key (kbd "<M-return>") 'restclient-mode)))))

(defun clear ()
  "Clear all open buffers and windows."
  (interactive)
  (mapc 'kill-buffer (buffer-list))
  (delete-other-windows))

(defun resize ()
  "Resize all of the windows equal."
  (interactive)
  (balance-windows))

(defun investwith-github ()
  "Cat investwith-github token to emacs clipboard."
  (interactive)
  (let ((output (shell-command-to-string "cat ~/tokens/investwith-github")))
    (kill-new output)
    (message "Copied token to clipboard")))

(defun kwonryul-github ()
  "Cat kwonryul-github token to emacs clipboard."
  (interactive)
  (let ((output (shell-command-to-string "cat ~/tokens/kwonryul-github")))
    (kill-new output)
    (message "Copied token to clipboard")))

(defun papercompany-ceo-github ()
  "Cat papercompany-ceo-github token to emacs clipboard."
  (interactive)
  (let ((output (shell-command-to-string "cat ~/tokens/papercompany-ceo-github")))
    (kill-new output)
    (message "Copied token to clipboard")))

(defun debug-clj ()
  "Start flow-storm gui."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "debug-clj")))
    (comint-send-string ansi-term-buffer "clj -Sforce -Sdeps '{:deps {com.github.flow-storm/flow-storm-dbg {:mvn/version \"RELEASE\"}}}'\n")))

(defun ssh-ifs ()
  "Start new shell buffer and ssh connect to ifs."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "ssh-ifs")))
    (with-current-buffer ansi-term-buffer
      (comint-send-string (current-buffer) "cd ~\n")
      (comint-send-string (current-buffer) "ssh -i ~/pems/investwith-aws-key.pem ubuntu@3.37.234.198\n"))))

(defun repl-ifs ()
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "repl-ifs")))
    (comint-send-string ansi-term-buffer "cd ~/investwith/ifs-fe\n")
    (comint-send-string ansi-term-buffer "clj -M:dev:cider\n")))

(defun repl-ifs-cljs (profile)
  (interactive
   (list (completing-read "Select profile: " '("prod" "dev" "test" "debug"))))
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "repl-ifs-cljs")))
    (comint-send-string ansi-term-buffer "cd ~/investwith/ifs-fe\n")
    (comint-send-string ansi-term-buffer (concat "npx shadow-cljs watch " profile "\n"))))

(defun ifs-tunneling ()
  "Start ifs tunneling."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "ifs-tunneling")))
    (comint-send-string ansi-term-buffer "cd ~\n")
    (comint-send-string ansi-term-buffer "ssh -i ~/pems/investwith-aws-key.pem ubuntu@3.37.234.198 -L 7002:localhost:7001\n")))

(defun debug-ifs-cljs ()
  "Start ifs cljs flow-storm gui."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "debug-ifs-cljs")))
    (comint-send-string ansi-term-buffer "cd ~/investwith/ifs\n")
    (comint-send-string ansi-term-buffer "clj -Sforce -Sdeps '{:deps {com.github.flow-storm/flow-storm-dbg {:mvn/version \"RELEASE\"}}}' -X flow-storm.debugger.main/start-debugger :port 7003 :repl-type :shadow :build-id :debug\n")))

(defun ssh-ibs-prod ()
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "ssh-ibs-prod")))
    (with-current-buffer ansi-term-buffer
      (comint-send-string (current-buffer) "cd ~\n")
      (comint-send-string (current-buffer) "ssh -i ~/pems/investwith-aws-key.pem ubuntu@3.38.82.91\n"))))

(defun ssh-ibs-be ()
  "Start new shell buffer and ssh connect to ibs-be."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "ssh-ibs-be")))
    (with-current-buffer ansi-term-buffer
      (comint-send-string (current-buffer) "cd ~\n")
      (comint-send-string (current-buffer) "ssh -i ~/pems/investwith-aws-key.pem -p 11000 ec2-user@3.39.98.223\n"))))

(defun ssh-love ()
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "ssh-love")))
    (with-current-buffer ansi-term-buffer
      (comint-send-string (current-buffer) "cd ~\n")
      (comint-send-string (current-buffer) "ssh -i ~/pems/utopia.pem ubuntu@52.79.54.178\n"))))

(defun repl-love ()
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "repl-love")))
    (comint-send-string ansi-term-buffer "cd ~/dev/clojure/love\n")
    (comint-send-string ansi-term-buffer "clj -M:dev:cider\n")))

(defun repl-love-cljs ()
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "repl-love-cljs")))
    (comint-send-string ansi-term-buffer "cd ~/dev/clojure/love\n")
    (comint-send-string ansi-term-buffer "npx shadow-cljs watch app\n")))

(defun ssh-papercompany ()
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "ssh-papercompany")))
    (with-current-buffer ansi-term-buffer
      (comint-send-string (current-buffer) "cd ~\n")
      (comint-send-string (current-buffer) "ssh -i ~/pems/papercompany.pem ubuntu@13.209.92.211\n"))))

(defun ssh-utopia ()
  "Start new shell buffer and ssh connect to utopia."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "ssh-utopia")))
    (with-current-buffer ansi-term-buffer
      (comint-send-string (current-buffer) "cd ~\n")
      (comint-send-string (current-buffer) "ssh -i ~/pems/utopia.pem ubuntu@43.202.120.110\n"))))

(defun repl-utopia ()
  "Start utopia cider repl server."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "repl-utopia")))
    (comint-send-string ansi-term-buffer "cd ~/dev/clojure/utopia\n")
    (comint-send-string ansi-term-buffer "clj -M:dev:cider\n")))

(defun repl-utopia-cljs (profile)
  "Start utopia cljs cider repl server."
  (interactive
   (list (completing-read "Select profile: " '("prod" "dev" "test" "debug"))))
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "repl-utopia-cljs")))
    (comint-send-string ansi-term-buffer "cd ~/dev/clojure/utopia\n")
    (comint-send-string ansi-term-buffer (concat "npx shadow-cljs watch " profile "\n"))))

(defun debug-utopia-cljs ()
  "Start utopia cljs flow-storm gui."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "debug-utopia-cljs")))
    (comint-send-string ansi-term-buffer "cd ~/dev/clojure/utopia\n")
    (comint-send-string ansi-term-buffer "clj -Sforce -Sdeps '{:deps {com.github.flow-storm/flow-storm-dbg {:mvn/version \"RELEASE\"}}}' -X flow-storm.debugger.main/start-debugger :port 7003 :repl-type :shadow :build-id :debug\n")))

(defun utopia-tunneling ()
  "Start utopia tunneling."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "utopia-tunneling")))
    (comint-send-string ansi-term-buffer "cd ~\n")
    (comint-send-string ansi-term-buffer "ssh -i ~/pems/utopia.pem ubuntu@43.202.120.110 -L 7002:localhost:7001\n")))

(defun repl-GAT-X105 ()
  "Start GAT-X105 cider repl server."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "repl-GAT-X105")))
    (comint-send-string ansi-term-buffer "cd ~/investwith/GAT-X105\n")
    (comint-send-string ansi-term-buffer "clj -M:dev:cider\n")))

(defun repl-GAT-X105-cljs ()
  "Start GAT-X105 cljs cider repl server."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "repl-GAT-X105-cljs")))
    (comint-send-string ansi-term-buffer "cd ~/investwith/GAT-X105\n")
    (comint-send-string ansi-term-buffer "npx shadow-cljs watch app\n")))

(defun GAT-X105-tunneling ()
  "Start GAT-X105 tunneling."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "GAT-X105-tunneling")))
    (comint-send-string ansi-term-buffer "cd ~\n")
    (comint-send-string ansi-term-buffer "ssh -i ~/pems/investwith-aws-key.pem ubuntu@3.37.234.198 -L 7002:localhost:7001\n")))

(defun papercompany-orgs-export ()
  "Export all org files in DIRECTORY to HTML and save them in the same directory."
  (interactive)
  (let ((directory "/home/kwonryul/dev/org/papercompany-orgs/"))
    (dolist (org-file (directory-files-recursively directory "\\.org$"))
      (with-current-buffer (find-file-noselect org-file)
        (let ((output-file (concat (file-name-sans-extension org-file) ".html")))
          (org-html-export-to-html)
          (save-buffer)
          (kill-buffer))))))

(defun investwith-orgs-export ()
  "Export all org files in DIRECTORY to HTML and save them in the same directory."
  (interactive)
  (let ((directory "/home/kwonryul/investwith/orgs/"))
    (dolist (org-file (directory-files-recursively directory "\\.org$"))
      (with-current-buffer (find-file-noselect org-file)
        (let ((output-file (concat (file-name-sans-extension org-file) ".html")))
          (org-html-export-to-html)
          (save-buffer)
          (kill-buffer))))))

(defun ebdb-tunneling ()
  "Start ebdb tunneling."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "ebdb-tunneling")))
    (comint-send-string ansi-term-buffer "cd ~\n")
    (comint-send-string ansi-term-buffer "ssh -i ~/pems/as-is.pem ubuntu@15.165.231.145 -L 3307:prod.ctxlfqdbxj5n.ap-northeast-2.rds.amazonaws.com:3306\n")))

(defun ebdb-dev-tunneling ()
  "Start ebdb-dev tunneling."
  (interactive)
  (let ((ansi-term-buffer (ansi-term "/bin/bash" "ebdb-dev-tunneling")))
    (comint-send-string ansi-term-buffer "cd ~\n")
    (comint-send-string ansi-term-buffer "ssh -i ~/pems/as-is.pem ubuntu@15.165.231.145 -L 3307:dev-from-prod-20240109.ctxlfqdbxj5n.ap-northeast-2.rds.amazonaws.com:3306\n")))

(ejc-create-connection
 "ifs"
 :classpath "/home/kwonryul/.m2/repository/org/postgresql/postgresql/42.6.0/postgresql-42.6.0.jar"
 :subprotocol "postgresql"
 :subname "//3.37.234.198:5432/postgres"
 :user "postgres"
 :password "with2327")

(ejc-create-connection
 "ibs"
 :classpath "/home/kwonryul/.m2/repository/com/mysql/mysql-connector-j/8.1.0/mysql-connector-j-8.1.0.jar"
 :subprotocol "mysql"
 :subname "//54.180.87.169:12000/iwdb"
 :user "investwith"
 :password "inwith99$$")

(ejc-create-connection
 "ebdb"
 :classpath "/home/kwonryul/.m2/repository/com/mysql/mysql-connector-j/8.1.0/mysql-connector-j-8.1.0.jar"
 :subprotocol "mysql"
 :subname "//localhost:3307/ebdb"
 :user "admin"
 :password "investwith")

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
   '(yaml-mode cider-storm flycheck-clj-kondo typescript lsp-pyright typescript-mode htmlize ejc-sql ob-clojure-literate ob-clojure json-mode restclient lsp-haskell js2-mode j2-mode gnu-elpa-keyring-update rustic haskell-mode elpy zenburn-theme cmake-mode yasnippet which-key use-package treemacs-projectile ripgrep rainbow-delimiters professional-theme paredit magit lsp-ui lsp-java helm-lsp flycheck eink-theme company cloud-theme cider-eval-sexp-fu cider auto-compile))
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
