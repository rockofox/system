(setq confirm-kill-emacs nil)
;; accept completion from copilot and fallback to company
(use-package! copilot
  ;; :config (setq copilot--base-dir (getenv "EMACS_PATH_COPILOT"))
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))
(unless (display-graphic-p)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
  (global-set-key (kbd "<mouse-6>") 'scroll-right)
  (global-set-key (kbd "<mouse-7>") 'scroll-left)
  (global-set-key (kbd "S-<mouse-6>") 'scroll-right)
  (global-set-key (kbd "S-<mouse-7>") 'scroll-left)
  )
(setq-default with-editor-emacsclient-executable "emacsclient")
(add-to-list 'default-frame-alist '(undecorated-round . t))
(add-to-list 'exec-path "/run/current-system/sw/bin")
(add-to-list 'exec-path (format "/etc/profiles/per-user/%s/bin" `((user :default ,user-login-name))))
;;; config.el ends here
