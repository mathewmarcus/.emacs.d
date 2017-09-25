
;; Configure packages and package repository
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("MELPA Stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar myPackages
  '(better-defaults
    ac-c-headers
    jedi
    multi-term
    neotree
    magit
    markdown-mode
    ace-window
    cyberpunk-theme
    flycheck))
(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)


;; Prevent startup tutorial screen
(setq inhibit-startup-screen t)

;; Hide top menu bar
(menu-bar-mode -1)

;; show all available buffer on C-x b
(ido-mode 1)

;; Enable global line numbers
(global-linum-mode t)
(setq column-number-mode t)

;; OSX Meta key fixes
(when (eq system-type 'darwin)
  (unless (package-installed-p 'exec-path-from-shell)
      (package-install 'exec-path-from-shell))
  (exec-path-from-shell-initialize)
  (setq mac-option-key-is-meta nil)
  (setq mac-command-key-is-meat t)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

;; Load custom theme
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/plugins")
;; (load-theme 'hober t)
(load-theme 'cyberpunk t)

;; Auto complete pairs (parentheses, quotes, etc)
(electric-pair-mode 1)

;; Autoload files
(global-auto-revert-mode t)

;; Auto complete pairs (parentheses, quotes, etc)
(electric-pair-mode 1)

;; Autoload files
(global-auto-revert-mode t)

;; setup generic autocomplete
(ac-config-default)
(setq ac-modes (delq 'python-mode ac-modes))
(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-c e") 'yas-expand)

;; Load filesystem tree
(add-to-list 'load-path "~/.emacs.d/elpa/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)


;; Window configuration
(global-set-key (kbd "M-p") 'ace-window)


;; SHELL
(require 'multi-term)

;; prevent shell history navigation macro key combos from being mapped to Emacs macros
(setq term-bind-key-alist (delete '("C-p" . previous-line) term-bind-key-alist))
(setq term-bind-key-alist (delete '("C-n" . next-line) term-bind-key-alist))
(setq term-bind-key-alist (delete '("C-r" . isearch-backward) term-bind-key-alist))
(add-to-list 'term-bind-key-alist '("C-y" . term-paste))

(defun kill-term-line ()
  (define-key term-raw-map (kbd "C-k")
    (lambda ()
      (interactive)
      (term-send-raw-string "\C-k")
      (kill-line))))
(add-hook 'term-mode-hook 'kill-term-line)

(setq multi-term-program "/bin/bash")

(defun my-inhibit-global-linum-mode ()

  (add-hook 'after-change-major-mode-hook
            (lambda () (linum-mode 0))
            :append :local))

(add-hook 'term-mode-hook 'my-inhibit-global-linum-mode)
(add-hook 'term-mode-hook (lambda () (setq-local column-number-mode nil)))

(add-hook 'term-mode-hook
  (lambda () 
    (define-key term-raw-map (kbd "M-p") 'ace-window)))

;; Python
;; ------
;; (jedi:reinstall-server)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
;; (elpy-enable)

;; Enable linting
(global-flycheck-mode)

;; Add python specific yasnippets
(setq yas-snippet-dirs (append yas-snippet-dirs
                               '("~/.emacs.d/plugins/emacs-for-python/extensions/yasnippet/snippets")))
(yas-reload-all)
;; (when (not (string-equal system-name "mattwork.local"))
;;     (setq elpy-rpc-python-command "python3"))
;; (setq elpy-rpc-backend "jedi")
;; (add-hook 'python-mode-hook
;;             (lambda ()
;;               (set (make-local-variable 'company-backends) '(company-jedi))))


;; C/C++
;; -----
;; Load cc-mode
( add-to-list 'load-path "~/.emacs.d/elpa/cc-mode-5.33")
(defun my-make-CR-do-indent ()
            (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-make-CR-do-indent)

;; AUTOGENERATED, DO NOT TOUCH!!!
;; -----------------------------
;; better-defaults
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ace-window markdown-mode ac-c-headers multi-term better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
