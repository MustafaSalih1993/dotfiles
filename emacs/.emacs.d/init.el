(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;forcing scrollbars to disabled
(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))

;; Sidebar file explorer (https://github.com/sebastiencs/sidebar.el)
;;
;; dependencies packages: - icons-in-terminal (https://github.com/sebastiencs/icons-in-terminal)
;;                        - frame-local
;;                        - projectile
;;                        - ov
;;
;; edit the paths below to point to the 2 cloned repos(above)
(add-to-list 'load-path "~/.local/share/icons-in-terminal")
(add-to-list 'load-path "~/cloned/sidebar.el")
(require 'sidebar)
(global-set-key (kbd "C-x C-f") 'sidebar-open)
(global-set-key (kbd "C-x C-a") 'sidebar-buffers-open)


;; general shit
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") ;; load custom path for themes
(defalias 'yes-or-no-p 'y-or-n-p)                          ;; y - n instead
(electric-pair-mode t)				           ;; enable auto - pairs
(global-display-line-numbers-mode)                         ;; line numbers
(global-set-key (kbd "C-x w") 'elfeed)                     ;; starts elfeed rss client
(global-set-key(kbd "C-c /") 'comment-line)                ;; comment binding
(load-theme 'mustafa2 t)  	                           ;; loading the theme
;(set-frame-font "SauceCodePro Nerd Font Mono-12" nil t)    ;; changing the default font
(setq default-frame-alist '((font .  "SauceCodePro Nerd Font Mono-12"))) ; same as above
(tool-bar-mode -1)                                         ;; disabling toolbar
(menu-bar-mode -1)                                         ;; Disable menu bar
(scroll-bar-mode -1)                                       ;; disabling scrollbar
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")));; backup files dir
(setq display-line-numbers-type 'relative)                 ;; display the numbers relative
(setq inhibit-startup-screen t)
(setq visible-bell 1)
(show-paren-mode)				           ;; Show Matching parenths
(simple-modeline-mode)                                     ;; simplemodeline(emacs's bottom line)



;; custom function to reload emacs configs without closing it
(defun reload-emacs ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))


;; Custom Function to run astyle formatting C/C++ code buffer
(defun astyle-this-buffer()
  (interactive)
  (if(buffer-modified-p)
      (save-buffer 0))
  (shell-command
   (format "astyle -A3fpk3W3U %s"
	   (shell-quote-argument(buffer-file-name)))
   nil(get-buffer-create "*Astyle Errors*"))
  (revert-buffer t t t))


;; Custom Function to show markdown in browser
;; M-x httpd-start
;; M-x imp-mode
;; M-x imp-set-user<TAB>markdown-html
;; go to browser
(defun start-markdown-server ()
  "starting markdown server"
  (interactive)
  (httpd-start)
  (impatient-mode))

(defun markdown-html (buffer)
  (princ (with-current-buffer buffer
	   (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://strapdownjs.com/v/0.2/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
	 (current-buffer)))


;; elfeed rss client
(setq-default elfeed-search-filter "@1-day-ago +unread ")
(setq elfeed-feeds
      '(("https://github.com/MustafaSalih1993.private.atom?token=AI4H4KB2N7GWJOYYXQPR35V6GLWDQ" MyGithub)
        ("https://distrowatch.com/news/dwd.xml" Distrowatch Distro)
	("https://www.reddit.com/r/gentoo.rss" gentoo)))


;; HOOKS
;; gnus-mode hook to read my emails
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
(add-hook 'gnus-mode-hook
	  (setq user-mail-address "mustafasalih1991@gmail.com"
		user-full-name "Mustafa Salih")
	  (setq gnus-select-method
		'(nnimap "gmail"
			 (nnimap-address "imap.gmail.com")
			 (nnimap-server-port "imaps")
			 (nnimap-stream ssl)))
	  (setq smtpmail-smtp-server "smtp.gmail.com"
		smtpmail-smtp-service 587
		gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]"))

(eval-after-load 'gnus-topic
  '(progn
     (setq gnus-message-archive-group '((format-time-string "sent.%Y")))
     (setq gnus-topic-topology '(("Gnus" visible)
                                 (("gmail" visible nil nil))))

     (setq gnus-topic-alist '(("gmail" ; the key of topic
                               "nnimap+gmail:INBOX"
                               "nnimap+gmail:[Gmail]/Sent Mail"
                               "nnimap+gmail:[Gmail]/Drafts")                              
                              ("Gnus")))))


;; javascript/typescript hook
(add-hook 'js-mode-hook #'global-prettier-mode)
(add-hook 'js-mode-hook
	  (lambda ()
	    (lsp)))


;; rust language hook
(require 'rust-mode)
(add-hook 'rust-mode-hook 		                    
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
		  company-idle-delay 0.2) ;; default is 0.2

	    ))


;; C language hook
(add-hook 'c-mode-hook				 
	  (lambda()
	    (lsp)
	    (setq lsp-completion-provider :capf)
	    (setq lsp-idle-delay 0.500)
	    (setq lsp-enable-file-watchers nil)
	    (setq gc-cons-threshold 100000000)
	    (setq company-minimum-prefix-length 2
		  company-idle-delay 0.0) ;; default is 0.2
	    (setq c-basic-offset 4)
	    (global-set-key(kbd "C-c C-f") 'astyle-this-buffer) ;; format binding
	    (global-set-key(kbd "C-c C-c") 'compile)            ;; compile binding
	    ))



;; automatic inserted shit
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8979b25357daaaa8e48a1cea1ea84c42990f2531e0f50f33efa6738e9f8ace56" "2fa74c79bdd65bffa2d7a81c5c1ea3b00166a4d3e4a01b8adba310e791b6fa1e" default))
 '(package-selected-packages
   '(pest-mode simple-modeline json-mode yaml-mode rust-mode projectile ov lsp-ui frame-local elfeed company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
