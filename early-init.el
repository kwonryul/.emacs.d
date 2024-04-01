(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
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
