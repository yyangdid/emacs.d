(use-package
  which-key
  :ensure t
  :defer nil
  :custom (which-key-enable-extended-define-key t)
  :init (setq which-key-idle-delay 0.5)
  (setq which-key-idle-secondary-delay 0)
  (setq which-key-sort-order 'which-key-key-order)
  (setq which-key-enable-extended-define-key t)
  :config (which-key-mode t)
  (add-to-list 'which-key-replacement-alist '(("TAB" . nil) . ("↹" . nil)))
  (add-to-list 'which-key-replacement-alist '(("RET" . nil) . ("⏎" . nil)))
  (add-to-list 'which-key-replacement-alist '(("DEL" . nil) . ("⇤" . nil)))
  (add-to-list 'which-key-replacement-alist '(("SPC" . nil) . ("␣" . nil))))


;; evil-collection 需要设置
(setq evil-want-integration t)
(setq evil-want-keybinding nil)

(use-package
  evil-leader
  :ensure t
  :init ;; (setq evil-leader/in-all-states t)
  (global-evil-leader-mode t)
  (evil-leader/set-leader "SPC")
  :config                               ;

  (setq file-map-prefix (w/create-leader-keymap "f" file-map "file"))
  (w/create-leader-key "o" 'find-file "open-file" file-map-prefix)
  (w/create-leader-key "f" 'find-file "open-file" file-map-prefix)
  (w/create-leader-key "r" 'recentf-open-files "recent-file" file-map-prefix)
  (setq buffer-map-prefix (w/create-leader-keymap "b" buffer-map "buffer"))
  (w/create-leader-key "c" 'kill-current-buffer "close-buffer" buffer-map-prefix)
  (w/create-leader-key "b" 'switch-to-buffer "switch-buffer" buffer-map-prefix)
  (w/create-leader-key "k" 'kill-buffer "close-selected-buffer" buffer-map-prefix)
  (w/create-leader-key "w" 'kill-buffer-and-window "close-buffer-and-window" buffer-map-prefix) (w/create-leader-key "s" 'save-buffer "save-buffer" buffer-map-prefix)
  (w/create-leader-key "S" 'save-some-buffers "save-all-buffer-interactive" buffer-map-prefix)
  (w/create-leader-key "p" 'switch-to-prev-buffer "previous-buffer" buffer-map-prefix)
  (w/create-leader-key "n" 'switch-to-next-buffer "next-buffer" buffer-map-prefix)
  (w/create-leader-key "m" 'view-echo-area-messages "message-buffer" buffer-map-prefix)
  (setq window-map-prefix (w/create-leader-keymap "w" window-map "window"))
  (w/create-leader-key "c" 'delete-window "close-window" window-map-prefix)
  (w/create-leader-key "o" 'delete-other-windows "close-other-window" window-map-prefix)
  (w/create-leader-key "m" 'maximize-window "maximize-window" window-map-prefix)
  (w/create-leader-key "n" 'minimize-window "minimize-window" window-map-prefix)
  (w/create-leader-key "b" 'balance-windows "balance-window" window-map-prefix)
  (w/create-leader-key "s" 'split-window-horizontally "split-window-horizontally" window-map-prefix)
  (w/create-leader-key "v" 'split-window-vertically "split-window-vertically" window-map-prefix)
  (w/create-leader-key "w" 'kill-buffer-and-window "close-window-and-buffer" window-map-prefix)
  (setq content-map-prefix (w/create-leader-keymap "c" content-map "content"))
  (w/create-leader-key "w" 'w/wrap-region-match-wrap "wrap" content-map-prefix)
  (setq goto-map-prefix (w/create-leader-keymap "g" goto-map "goto"))
  (setq project-map-prefix (w/create-leader-keymap "p" project-map "project"))
  (setq major-map-prefix (w/create-leader-keymap "m" major-mode-map "major"))
  (w/create-leader-key "c" 'comment-line "comment" major-map-prefix)
  (w/create-leader-key "r" 'comment-or-uncomment-region "(un)comment-region" major-map-prefix)
  (setq help-map-prefix (w/create-leader-keymap "h" help-map "help"))
  (w/create-leader-key "RET" 'view-order-manuals "manuals" help-map-prefix)
  (w/create-leader-key "f" 'describe-function "function-help" help-map-prefix)
  (w/create-leader-key "v" 'describe-variable "variable-help" help-map-prefix)
  (w/create-leader-key "k" 'describe-key "key-help" help-map-prefix)
  (w/create-leader-key "c" 'describe-coding-system "coding-system" help-map-prefix)
  (w/create-leader-key "m" 'describe-mode "mode-help" help-map-prefix)
  (w/create-leader-key "p" 'describe-package "package-help" help-map-prefix)
  (w/create-leader-key "w" 'where-is "where-is" help-map-prefix)
  (w/create-leader-key "s" 'describe-symbol "symbol-help" help-map-prefix)
  (w/create-leader-key "?" 'about-emacs "about" help-map-prefix))

(use-package
  evil
  :ensure t
  :custom                               ;
  (evil-want-minibuffer nil)
  :init                                 ;
  (setq evil-emacs-state-cursor '("#ffb1ef" bar))
  (setq evil-normal-state-cursor '("#55b1ef" box))
  (setq evil-visual-state-cursor '("orange" box))
  (setq evil-insert-state-cursor '("#c46bbc" bar))
  (setq evil-replace-state-cursor '("#c46bbc" hollow-rectangle))
  (setq evil-operator-state-cursor '("#c46bbc" hollow))
  (setq evil-want-C-i-jump nil)
  (when evil-want-C-i-jump (define-key evil-motion-state-map (kbd "C-i") 'evil-jump-forward))
  :bind                                 ;
  (:map evil-insert-state-map           ;
        ("M-h" . evil-backward-char)
        ("M-j" . evil-next-line)
        ("M-k" . evil-previous-line)
        ("M-l" . evil-forward-char)
        ("M-w" . evil-forward-word-begin)
        ("M-e" . evil-forward-word-end)
        ("M-b" . evil-backward-word-begin)
        ("M-B" . evil-backward-WORD-begin)
        :map evil-visual-state-map
        ("(" . electric-pair))
  :config                               ;
  (evil-mode t)
  (w/create-leader-key "h" 'evil-window-left "focus-left-window" window-map-prefix)
  (w/create-leader-key "j" 'evil-window-down "focus-down-window" window-map-prefix)
  (w/create-leader-key "k" 'evil-window-up "focus-up-window" window-map-prefix)
  (w/create-leader-key "l" 'evil-window-right "focus-right-window" window-map-prefix))

(use-package
  evil-collection
  :after evil
  :ensure t
  :config                               ;
  (evil-collection-init))

(use-package
  evil-surround
  :ensure t
  :config                               ;
  (global-evil-surround-mode 1))

(use-package
  evil-terminal-cursor-changer
  :ensure t
  :unless (display-graphic-p)
  :after evil
  :config                               ;
  (evil-terminal-cursor-changer-activate))

(provide 'core/keymap)
