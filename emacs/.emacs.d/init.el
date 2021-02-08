
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Sidebar file explorer
;(add-to-list 'load-path "~/.local/share/icons-in-terminal")
;(add-to-list 'load-path "~/cloned/sidebar.el")
;(require 'sidebar)
;(global-set-key (kbd "C-x C-f") 'sidebar-open)
;(global-set-key (kbd "C-x C-a") 'sidebar-buffers-open)

;(setq bdf-directory-list '("/usr/share/fonts"))
;; Custom Function to run astyle formatting C code buffer
(defun astyle-this-buffer()
  (interactive)
  (if(buffer-modified-p)
      (save-buffer 0))
  (shell-command
   (format "astyle -A3fpk3W3U %s"
	   (shell-quote-argument(buffer-file-name)))
   nil(get-buffer-create "*Astyle Errors*"))
  (revert-buffer t t t))


;; general shit
(setq visible-bell 1)
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
(setq inhibit-startup-screen t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") ;; load custom path for themes
(set-frame-font "SauceCodePro Nerd Font Mono-12" nil t)    ;; changing the default font
(show-paren-mode)				           ;; Show Matching parenths
(menu-bar-mode -1)                                         ;; Disable menu bar
(global-display-line-numbers-mode)                         ;; line numbers
(global-set-key(kbd "C-c /") 'comment-line)                ;; comment binding
(defalias 'yes-or-no-p 'y-or-n-p)                          ;; y - n instead
(electric-pair-mode t)				           ;; enable auto - pairs
(tool-bar-mode -1)                                         ;; disabling toolbar
(scroll-bar-mode -1)                                       ;; disabling scrollbar
(load-theme 'mustafa2 t)  	                           ;; loading the theme


;; HOOKS

(add-hook 'dired-mode-hook
	  (lambda ()
	    (dired-hide-details-mode)
	    (setq dired-listing-switches "-alk")))      


(add-hook 'js-mode-hook #'global-prettier-mode)
(add-hook 'js-mode-hook
	  (lambda ()
	    (lsp)))


(require 'rust-mode)
;;(setenv "RUST_SRC_PATH" "/usr/lib/rust/lib-1.47.0/rustlib/x86_64-unknown-linux-gnu/lib/")
(add-hook 'rust-mode-hook 		                    ;; rust programming hook
          (lambda ()
	    (lsp)
	    (setq indent-tabs-mode nil)
	    (setq rust-format-on-save t)
	    (define-key rust-mode-map (kbd "C-c C-c") 'rust-run)
	    (define-key rust-mode-map (kbd "C-c C-a") 'lsp-ui-sideline-apply-code-actions)
	    (define-key rust-mode-map (kbd "C-c C-b") 'rust-compile) 
	    (define-key rust-mode-map (kbd "C-c C-t") 'rust-test)
	    (define-key rust-mode-map (kbd "C-c C-p") 'rust-run-clippy)
	    (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
	    (setq lsp-completion-provider :capf)
	    (setq lsp-idle-delay 0.500)
	    (setq lsp-enable-file-watchers nil)
	    (setq company-tooltip-align-annotations t)
	    (setq company-minimum-prefix-length 2
		  company-idle-delay 0.0) ;; default is 0.2
	    (setq display-line-numbers 'relative)
	    ))


(add-hook 'c-mode-hook				 ;C programming hook
	  (lambda()
	    (lsp)
	    (setq lsp-completion-provider :capf)
	    (setq lsp-idle-delay 0.500)
	    (setq lsp-enable-file-watchers nil)
	    (setq gc-cons-threshold 100000000)
	    (setq company-minimum-prefix-length 2
		  company-idle-delay 0.0) ;; default is 0.2
	    (setq c-basic-offset 4)
	    (global-set-key(kbd "C-x C-a") 'astyle-this-buffer) ;; format binding
	    (global-set-key(kbd "C-x c") 'compile)            ;; compile binding
	    ))


;; (add-hook 'company-mode-hook		 ; rebind tab
;; 	  (lambda()
;; 	    (define-key company-active-map
;; 	      (kbd "TAB") 'company-select-next-or-abort)
;; 	    ))


;; automatic inserted shit
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8979b25357daaaa8e48a1cea1ea84c42990f2531e0f50f33efa6738e9f8ace56" "2fa74c79bdd65bffa2d7a81c5c1ea3b00166a4d3e4a01b8adba310e791b6fa1e" default))
 '(package-selected-packages '(lsp-mode company yaml-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
