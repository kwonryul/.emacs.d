(deftheme kwonryul-zenburn
  "Created 2024-04-02.")

(custom-theme-set-variables
 'kwonryul-zenburn
 '(package-selected-packages '(zenburn-theme cmake-mode yasnippet which-key use-package treemacs-projectile ripgrep rainbow-delimiters professional-theme paredit magit lsp-ui lsp-java helm-lsp flycheck eink-theme company cloud-theme cider-eval-sexp-fu cider auto-compile))
 '(rainbow-delimiters-max-face-count 3)
 '(ansi-color-names-vector ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(nrepl-message-colors ''("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))

(custom-theme-set-faces
 'kwonryul-zenburn
 '(rainbow-delimiters-base-error-face ((t (:inherit rainbow-delimiters-base-face :foreground "red"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#DCDCCC"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#BFEBBF"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#D0BF8F"))))
 '(button ((t (:underline t))))
 '(link ((t (:foreground "#F0DFAF" :underline t :weight bold))))
 '(link-visited ((t (:foreground "#D0BF8F" :underline t :weight normal))))
 '(cursor ((t (:foreground "#DCDCCC" :background "#FFFFEF"))))
 '(widget-field ((t (:foreground "#DCDCCC" :background "#6F6F6F"))))
 '(escape-glyph ((t (:foreground "#F0DFAF" :weight bold))))
 '(fringe ((t (:foreground "#DCDCCC" :background "#4F4F4F"))))
 '(header-line ((t (:foreground "#F0DFAF" :background "#2B2B2B" :box (:line-width -1 :style released-button) :extend t))))
 '(highlight ((t (:background "#383838"))))
 '(success ((t (:foreground "#7F9F7F" :weight bold))))
 '(warning ((t (:foreground "#DFAF8F" :weight bold))))
 '(tooltip ((t (:foreground "#DCDCCC" :background "#4F4F4F"))))
 '(compilation-info ((t (:foreground "#BFEBBF" :underline t))))
 '(compilation-line-number ((t (:foreground "#F0DFAF"))))
 '(compilation-mode-line-exit ((t (:foreground "#9FC59F" :weight bold))))
 '(compilation-mode-line-fail ((t (:foreground "#CC9393" :weight bold))))
 '(compilation-mode-line-run ((t (:foreground "#F0DFAF" :weight bold))))
 '(completions-annotations ((t (:foreground "#656555"))))
 '(completions-common-part ((t (:foreground "#8CD0D3"))))
 '(completions-first-difference ((t (:foreground "#FFFFEF"))))
 '(custom-variable-tag ((t (:foreground "#8CD0D3" :weight bold))))
 '(custom-group-tag ((t (:foreground "#8CD0D3" :weight bold :height 1.2))))
 '(custom-state ((t (:foreground "#BFEBBF"))))
 '(fill-column-indicator ((((class color) (min-colors 89)) :foreground "#383838" :weight semilight)))
 '(match ((t (:background "#2B2B2B" :foreground "#DFAF8F" :weight bold))))
 '(Info-quoted ((t (:inherit font-lock-constant-face))))
 '(isearch ((t (:foreground "#D0BF8F" :weight bold :background "#5F5F5F"))))
 '(isearch-fail ((t (:foreground "#DCDCCC" :background "#8C5353"))))
 '(lazy-highlight ((t (:foreground "#D0BF8F" :weight bold :background "#383838"))))
 '(menu ((t (:foreground "#DCDCCC" :background "#3F3F3F"))))
 '(minibuffer-prompt ((t (:foreground "#F0DFAF"))))
 '(mode-line ((((class color) (min-colors 89)) (:foreground "#8FB28F" :background "#2B2B2B" :box (:line-width -1 :style released-button))) (t :inverse-video t)))
 '(mode-line-buffer-id ((t (:foreground "#F0DFAF" :weight bold))))
 '(mode-line-inactive ((t (:foreground "#5F7F5F" :background "#383838" :box (:line-width -1 :style released-button)))))
 '(region ((((class color) (min-colors 89)) (:background "#2B2B2B" :extend t)) (t :inverse-video t)))
 '(secondary-selection ((t (:background "#5F5F5F"))))
 '(trailing-whitespace ((t (:background "#CC9393"))))
 '(vertical-border ((t (:foreground "#DCDCCC"))))
 '(font-lock-builtin-face ((t (:foreground "#DCDCCC" :weight bold))))
 '(font-lock-comment-face ((t (:foreground "#7F9F7F"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#5F7F5F"))))
 '(font-lock-constant-face ((t (:foreground "#BFEBBF"))))
 '(font-lock-doc-face ((t (:foreground "#9FC59F"))))
 '(font-lock-function-name-face ((t (:foreground "#93E0E3"))))
 '(font-lock-keyword-face ((t (:foreground "#F0DFAF" :weight bold))))
 '(font-lock-negation-char-face ((t (:foreground "#F0DFAF" :weight bold))))
 '(font-lock-preprocessor-face ((t (:foreground "#94BFF3"))))
 '(font-lock-regexp-grouping-construct ((t (:foreground "#F0DFAF" :weight bold))))
 '(font-lock-regexp-grouping-backslash ((t (:foreground "#7F9F7F" :weight bold))))
 '(font-lock-string-face ((t (:foreground "#CC9393"))))
 '(font-lock-type-face ((t (:foreground "#7CB8BB"))))
 '(font-lock-variable-name-face ((t (:foreground "#DFAF8F"))))
 '(font-lock-warning-face ((t (:foreground "#D0BF8F" :weight bold))))
 '(c-annotation-face ((t (:inherit font-lock-constant-face))))
 '(line-number ((t (:inherit default :foreground "#6F6F6F" :background "#383838"))))
 '(line-number-current-line ((t (:inherit line-number :foreground "#D0BF8F"))))
 '(company-tooltip ((t (:foreground "#DCDCCC" :background "#4F4F4F"))))
 '(company-tooltip-annotation ((t (:foreground "#DFAF8F" :background "#4F4F4F"))))
 '(company-tooltip-annotation-selection ((t (:foreground "#DFAF8F" :background "#2B2B2B"))))
 '(company-tooltip-selection ((t (:foreground "#DCDCCC" :background "#2B2B2B"))))
 '(company-tooltip-mouse ((t (:background "#2B2B2B"))))
 '(company-tooltip-common ((t (:foreground "#9FC59F"))))
 '(company-tooltip-common-selection ((t (:foreground "#9FC59F"))))
 '(company-tooltip-scrollbar-thumb ((t (:background "#2B2B2B"))))
 '(company-tooltip-scrollbar-track ((t (:background "#5F5F5F"))))
 '(company-preview ((t (:background "#9FC59F"))))
 '(company-preview-common ((t (:foreground "#9FC59F" :background "#2B2B2B"))))
 '(cider-result-overlay-face ((t (:background unspecified))))
 '(cider-enlightened-face ((t (:box (:color "#DFAF8F" :line-width -1)))))
 '(cider-enlightened-local-face ((t (:weight bold :foreground "#8FB28F"))))
 '(cider-deprecated-face ((t (:background "#D0BF8F"))))
 '(cider-instrumented-face ((t (:box (:color "#CC9393" :line-width -1)))))
 '(cider-traced-face ((t (:box (:color "#93E0E3" :line-width -1)))))
 '(cider-test-failure-face ((t (:background "#8C5353"))))
 '(cider-test-error-face ((t (:background "#DC8CC3"))))
 '(cider-test-success-face ((t (:background "#5F7F5F"))))
 '(cider-fringe-good-face ((t (:foreground "#BFEBBF"))))
 '(diff-added ((t (:background "#335533" :foreground "#7F9F7F"))))
 '(diff-changed ((t (:background "#555511" :foreground "#E0CF9F"))))
 '(diff-removed ((t (:background "#553333" :foreground "#AC7373"))))
 '(diff-refine-added ((t (:background "#338833" :foreground "#BFEBBF"))))
 '(diff-refine-changed ((t (:background "#888811" :foreground "#F0DFAF"))))
 '(diff-refine-removed ((t (:background "#883333" :foreground "#CC9393"))))
 '(diff-header ((((class color) (min-colors 89)) (:background "#5F5F5F")) (t (:background "#DCDCCC" :foreground "#3F3F3F"))))
 '(diff-file-header ((((class color) (min-colors 89)) (:background "#5F5F5F" :foreground "#DCDCCC" :weight bold)) (t (:background "#DCDCCC" :foreground "#3F3F3F" :weight bold))))
 '(flycheck-error ((((supports :underline (:style wave))) (:underline (:style wave :color "#BC8383") :inherit unspecified)) (t (:foreground "#BC8383" :weight bold :underline t))))
 '(flycheck-warning ((((supports :underline (:style wave))) (:underline (:style wave :color "#F0DFAF") :inherit unspecified)) (t (:foreground "#F0DFAF" :weight bold :underline t))))
 '(flycheck-info ((((supports :underline (:style wave))) (:underline (:style wave :color "#93E0E3") :inherit unspecified)) (t (:foreground "#93E0E3" :weight bold :underline t))))
 '(flycheck-fringe-error ((t (:foreground "#BC8383" :weight bold))))
 '(flycheck-fringe-warning ((t (:foreground "#F0DFAF" :weight bold))))
 '(flycheck-fringe-info ((t (:foreground "#93E0E3" :weight bold))))
 '(git-commit-comment-action ((((class color) (min-colors 89)) (:foreground "#8FB28F" :weight bold))))
 '(git-commit-comment-branch-local ((((class color) (min-colors 89)) (:foreground "#94BFF3" :weight bold))))
 '(git-commit-comment-branch-remote ((((class color) (min-colors 89)) (:foreground "#7F9F7F" :weight bold))))
 '(git-commit-comment-heading ((((class color) (min-colors 89)) (:foreground "#F0DFAF" :weight bold))))
 '(helm-header ((t (:foreground "#7F9F7F" :background "#3F3F3F" :underline nil :box nil :extend t))))
 '(helm-source-header ((t (:foreground "#F0DFAF" :background "#2B2B2B" :underline nil :weight bold :box (:line-width -1 :style released-button) :extend t))))
 '(helm-selection ((t (:background "#4F4F4F" :underline nil))))
 '(helm-selection-line ((t (:background "#4F4F4F"))))
 '(helm-visible-mark ((t (:foreground "#3F3F3F" :background "#D0BF8F"))))
 '(helm-candidate-number ((t (:foreground "#BFEBBF" :background "#2B2B2B"))))
 '(helm-separator ((t (:foreground "#CC9393" :background "#3F3F3F"))))
 '(helm-time-zone-current ((t (:foreground "#9FC59F" :background "#3F3F3F"))))
 '(helm-time-zone-home ((t (:foreground "#CC9393" :background "#3F3F3F"))))
 '(helm-buffer-not-saved ((t (:foreground "#CC9393" :background "#3F3F3F"))))
 '(helm-buffer-process ((t (:foreground "#93E0E3" :background "#3F3F3F"))))
 '(helm-buffer-saved-out ((t (:foreground "#DCDCCC" :background "#3F3F3F"))))
 '(helm-buffer-size ((t (:foreground "#656555" :background "#3F3F3F"))))
 '(helm-ff-directory ((t (:foreground "#93E0E3" :background "#3F3F3F" :weight bold))))
 '(helm-ff-file ((t (:foreground "#DCDCCC" :background "#3F3F3F" :weight normal))))
 '(helm-ff-file-extension ((t (:foreground "#DCDCCC" :background "#3F3F3F" :weight normal))))
 '(helm-ff-executable ((t (:foreground "#9FC59F" :background "#3F3F3F" :weight normal))))
 '(helm-ff-invalid-symlink ((t (:foreground "#CC9393" :background "#3F3F3F" :weight bold))))
 '(helm-ff-symlink ((t (:foreground "#F0DFAF" :background "#3F3F3F" :weight bold))))
 '(helm-ff-prefix ((t (:foreground "#3F3F3F" :background "#F0DFAF" :weight normal))))
 '(helm-grep-cmd-line ((t (:foreground "#93E0E3" :background "#3F3F3F"))))
 '(helm-grep-file ((t (:foreground "#DCDCCC" :background "#3F3F3F"))))
 '(helm-grep-finish ((t (:foreground "#9FC59F" :background "#3F3F3F"))))
 '(helm-grep-lineno ((t (:foreground "#656555" :background "#3F3F3F"))))
 '(helm-grep-match ((t (:foreground nil :background nil :inherit helm-match))))
 '(helm-match ((t (:foreground "#DFAF8F" :background "#2B2B2B" :weight bold))))
 '(helm-moccur-buffer ((t (:foreground "#93E0E3" :background "#3F3F3F"))))
 '(hl-line ((((class color) (min-colors 89)) (:background "#383838" :extend t)) (t :weight bold)))
 '(hydra-face-red ((t (:foreground "#BC8383" :background "#3F3F3F"))))
 '(hydra-face-amaranth ((t (:foreground "#9C6363" :background "#3F3F3F"))))
 '(hydra-face-blue ((t (:foreground "#8CD0D3" :background "#3F3F3F"))))
 '(hydra-face-pink ((t (:foreground "#DC8CC3" :background "#3F3F3F"))))
 '(hydra-face-teal ((t (:foreground "#93E0E3" :background "#3F3F3F"))))
 '(magit-section-highlight ((t (:background "#494949"))))
 '(magit-section-heading ((t (:foreground "#F0DFAF" :weight bold))))
 '(magit-section-heading-selection ((t (:foreground "#DFAF8F" :weight bold))))
 '(magit-diff-file-heading ((t (:weight bold))))
 '(magit-diff-file-heading-highlight ((t (:background "#494949" :weight bold))))
 '(magit-diff-file-heading-selection ((t (:background "#494949" :weight bold :foreground "#DFAF8F"))))
 '(magit-diff-added ((t (:background "#5F7F5F"))))
 '(magit-diff-added-highlight ((t (:background "#7F9F7F"))))
 '(magit-diff-removed ((t (:background "#8C5353"))))
 '(magit-diff-removed-highlight ((t (:background "#9C6363"))))
 '(magit-diff-hunk-heading ((t (:background "#4F4F4F"))))
 '(magit-diff-hunk-heading-highlight ((t (:background "#5F5F5F"))))
 '(magit-diff-hunk-heading-selection ((t (:background "#5F5F5F" :foreground "#DFAF8F"))))
 '(magit-diff-lines-heading ((t (:background "#DFAF8F" :foreground "#5F5F5F"))))
 '(magit-diff-context-highlight ((t (:background "#494949" :foreground "grey70"))))
 '(magit-diffstat-added ((t (:foreground "#BFEBBF"))))
 '(magit-diffstat-removed ((t (:foreground "#CC9393"))))
 '(magit-process-ok ((t (:foreground "#7F9F7F" :weight bold))))
 '(magit-process-ng ((t (:foreground "#CC9393" :weight bold))))
 '(magit-log-author ((t (:foreground "#DFAF8F"))))
 '(magit-log-date ((t (:foreground "#656555"))))
 '(magit-log-graph ((t (:foreground "#FFFFEF"))))
 '(magit-sequence-pick ((t (:foreground "#D0BF8F"))))
 '(magit-sequence-stop ((t (:foreground "#7F9F7F"))))
 '(magit-sequence-part ((t (:foreground "#F0DFAF"))))
 '(magit-sequence-head ((t (:foreground "#8CD0D3"))))
 '(magit-sequence-drop ((t (:foreground "#CC9393"))))
 '(magit-sequence-done ((t (:foreground "#656555"))))
 '(magit-sequence-onto ((t (:foreground "#656555"))))
 '(magit-bisect-good ((t (:foreground "#7F9F7F"))))
 '(magit-bisect-skip ((t (:foreground "#F0DFAF"))))
 '(magit-bisect-bad ((t (:foreground "#CC9393"))))
 '(magit-blame-heading ((t (:background "#2B2B2B" :foreground "#6CA0A3"))))
 '(magit-blame-hash ((t (:background "#2B2B2B" :foreground "#6CA0A3"))))
 '(magit-blame-name ((t (:background "#2B2B2B" :foreground "#DFAF8F"))))
 '(magit-blame-date ((t (:background "#2B2B2B" :foreground "#DFAF8F"))))
 '(magit-blame-summary ((t (:background "#2B2B2B" :foreground "#6CA0A3" :weight bold))))
 '(magit-dimmed ((t (:foreground "#6F6F6F"))))
 '(magit-hash ((t (:foreground "#6F6F6F"))))
 '(magit-tag ((t (:foreground "#DFAF8F" :weight bold))))
 '(magit-branch-remote ((t (:foreground "#7F9F7F" :weight bold))))
 '(magit-branch-local ((t (:foreground "#8CD0D3" :weight bold))))
 '(magit-branch-current ((t (:foreground "#8CD0D3" :weight bold :box t))))
 '(magit-head ((t (:foreground "#8CD0D3" :weight bold))))
 '(magit-refname ((t (:background "#5F5F5F" :foreground "#DCDCCC" :weight bold))))
 '(magit-refname-stash ((t (:background "#5F5F5F" :foreground "#DCDCCC" :weight bold))))
 '(magit-refname-wip ((t (:background "#5F5F5F" :foreground "#DCDCCC" :weight bold))))
 '(magit-signature-good ((t (:foreground "#7F9F7F"))))
 '(magit-signature-bad ((t (:foreground "#CC9393"))))
 '(magit-signature-untrusted ((t (:foreground "#F0DFAF"))))
 '(magit-signature-expired ((t (:foreground "#DFAF8F"))))
 '(magit-signature-revoked ((t (:foreground "#DC8CC3"))))
 '(magit-signature-error ((t (:inherit magit-signature-bad))))
 '(magit-cherry-unmatched ((t (:foreground "#93E0E3"))))
 '(magit-cherry-equivalent ((t (:foreground "#DC8CC3"))))
 '(magit-reflog-commit ((t (:foreground "#7F9F7F"))))
 '(magit-reflog-amend ((t (:foreground "#DC8CC3"))))
 '(magit-reflog-merge ((t (:foreground "#7F9F7F"))))
 '(magit-reflog-checkout ((t (:foreground "#8CD0D3"))))
 '(magit-reflog-reset ((t (:foreground "#CC9393"))))
 '(magit-reflog-rebase ((t (:foreground "#DC8CC3"))))
 '(magit-reflog-cherry-pick ((t (:foreground "#7F9F7F"))))
 '(magit-reflog-remote ((t (:foreground "#93E0E3"))))
 '(magit-reflog-other ((t (:foreground "#93E0E3"))))
 '(message-cited-text-1 ((t (:inherit font-lock-comment-face))))
 '(message-header-name ((t (:foreground "#8FB28F"))))
 '(message-header-other ((t (:foreground "#7F9F7F"))))
 '(message-header-to ((t (:foreground "#F0DFAF" :weight bold))))
 '(message-header-cc ((t (:foreground "#F0DFAF" :weight bold))))
 '(message-header-newsgroups ((t (:foreground "#F0DFAF" :weight bold))))
 '(message-header-subject ((t (:foreground "#DFAF8F" :weight bold))))
 '(message-header-xheader ((t (:foreground "#7F9F7F"))))
 '(message-mml ((t (:foreground "#F0DFAF" :weight bold))))
 '(message-separator ((t (:inherit font-lock-comment-face))))
 '(outline-1 ((t (:inherit default :foreground "#DFAF8F"))))
 '(outline-2 ((t (:inherit default :foreground "#BFEBBF"))))
 '(outline-3 ((t (:inherit default :foreground "#7CB8BB"))))
 '(outline-4 ((t (:inherit default :foreground "#D0BF8F"))))
 '(outline-5 ((t (:inherit default :foreground "#93E0E3"))))
 '(outline-6 ((t (:inherit default :foreground "#9FC59F"))))
 '(outline-7 ((t (:inherit default :foreground "#8C5353"))))
 '(outline-8 ((t (:inherit default :foreground "#4C7073"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#93E0E3"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#9FC59F"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#94BFF3"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#E0CF9F"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#8FB28F"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#6CA0A3"))))
 '(rmail-highlight ((t (:foreground "#F0DFAF" :weight bold))))
 '(rmail-header-name ((t (:foreground "#8CD0D3"))))
 '(show-paren-mismatch ((t (:foreground "#DCA3A3" :background "#6F6F6F" :weight bold))))
 '(show-paren-match ((t (:foreground "#DCDCCC" :background "#6F6F6F" :weight bold))))
 '(tab-bar ((t (:background "#4F4F4F"))))
 '(tab-bar-tab ((t (:foreground "#DCDCCC" :background "#3F3F3F" :weight bold :box (:line-width -1 :style released-button)))))
 '(tab-bar-tab-inactive ((t (:foreground "#DCDCCC" :background "#4F4F4F" :box (:line-width -1 :style released-button)))))
 '(tab-line ((t (:background "#4F4F4F"))))
 '(which-func ((t (:foreground "#BFEBBF"))))
 '(default ((t (:foreground "#DCDCCC" :background "#3F3F3F")))))

(provide-theme 'kwonryul-zenburn)
