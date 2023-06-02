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
;; FIXME: Is this necessary?
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)
  (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE" "NIX_SSL_CERT_FILE" "NIX_PATH"))
    (add-to-list 'exec-path-from-shell-variables var))

  (setq-default with-editor-emacsclient-executable "emacsclient")
  (add-to-list 'default-frame-alist '(undecorated-round . t))
  )
;; FIXME: Does this have any effect?
(setq which-key-idle-delay 0.1)

;; FIXME: SPC-s-d is broken for some reason
(map! :leader "s a" 'consult-ripgrep)

;; Navigate in treemacs with single click
(with-eval-after-load 'treemacs
    (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))

(map! "<M-tab>" 'evil-window-mru)
;;; config.el ends here
