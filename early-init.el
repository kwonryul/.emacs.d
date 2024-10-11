(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives nil)
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("org" . "https://orgmode.org/elpa/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(setq load-prefer-newer t)
(add-to-list 'load-path "/home/kwonryul/.emacs.d/init.elc")
(use-package auto-compile :ensure t)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

(use-package async :ensure t)
(use-package gnu-elpa-keyring-update :ensure t)
