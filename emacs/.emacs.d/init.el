
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Sidebar file explorer
(add-to-list 'load-path "~/.local/share/icons-in-terminal")
(add-to-list 'load-path "~/cloned/sidebar.el")
(require 'sidebar)
(global-set-key (kbd "C-x C-f") 'sidebar-open)
(global-set-key (kbd "C-x C-a") 'sidebar-buffers-open)


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
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
(setq inhibit-startup-screen t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") ;; load custom path for themes
(set-frame-font "SauceCodePro Nerd Font Mono-16" nil t)    ;; changing the default font
(show-paren-mode)				           ;; Show Matching parenths
(menu-bar-mode -1)                                         ;; Disable menu bar
(global-display-line-numbers-mode)                         ;; line numbers
(global-set-key(kbd "C-c /") 'comment-line)                ;; comment binding
(defalias 'yes-or-no-p 'y-or-n-p)                          ;; y - n instead
(electric-pair-mode t)				           ;; enable auto - pairs
(tool-bar-mode -1)                                         ;; disabling toolbar
(scroll-bar-mode -1)                                       ;; disabling scrollbar
(load-theme 'mustafa t)  	                           ;; loading the theme


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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-livedown"))
(require 'livedown)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline success warning error])
 '(ansi-color-names-vector
   ["#000000" "#ff8059" "#44bc44" "#eecc00" "#2fafff" "#feacd0" "#00d3d0" "#ffffff"])
 '(awesome-tray-mode-line-active-color "#2fafff")
 '(awesome-tray-mode-line-inactive-color "#323232")
 '(custom-safe-themes
   (quote
    ("c79498a4f96bb433664c3b7e8e7392aa0f932261ed3271c693dab21f633985c8" "62e198a8470e9c8cc70eb1ec9f395073c24411aea95a50f97bdf0c554e9fca7a" "7636800fcfb4791e49dfdc55f7336be5aec3e3056aa29fc3fc82a80b22b273ba" "4536177f9f4ea6c72d44af1d4e9b719abbabb7078d3ab784dc6f7aa20f97c53a" "6f4b640c6f952446f919c8b9323cc74f2386a960d7022dcb47b145c84eb02c59" "4240095652885a6ad14bf98538dcf8de3cff9ff832cfdb0b8f50613cfd906d34" "b21456e98b9d9b7f90393efed139654df42cc2ae0d8d621f940f7d6759e78289" "3c4556e4a1e4ca4286e750045f1f8f23825d1e38675b6406bdf99863b4b25ff8" "47351a5e2f592e2230968cf9c30fe0e5bafc6a39cacc302addbd90c1231d17e5" "5ea32b0d5d032724cf6946aaee99f352c86fdd5c413660b178610b8fbe736ffb" "8b8f0d7a57b806ccaac5f55c41404f727d11494ff208088e18099d6e3e67e70f" "9b4d31cdc48b88c4c01f83b27c86eb9c643113642e318f53d16b1123e38eb2b8" "c167d33c13273ca47541199edf942b1f6db0260991c19de84864036a86496e29" "3f4b70fa8be76165dd3c31d75d699fdb890632bd17a566198fcebb614049499f" "13b097f8baa101f147d4cf40176c6184a96632be0b04a0bd0a62b3abc3752130" "91d0d1e7509da1172abee490fe2f2b39001050402435458a58ebcf4092ee4c5a" "86978b8777c9e54262e1191b6f4ffd7f520a5f814f44baae717896a96978e0b6" "a7f9bfe6fcb1c52f853cd3c94235db2cf4533f76600529009ac5736f473ab124" "ac40e3df8d96ae4e0af3b088f0202960e3b91f4acacb3b6f357b2e11d98635aa" "b235f6d3d3d243bc9d6220183b6d0c0c423d5094b6ad1e5034030acee887d0f1" "a2f7fa8566db71c1f8e2abaf51d0443bde2fd5391621cf60c3c92048e1e972f7" "fa4460ad3dd2c7274cdcee29e8d3bcedf7f6841ac7aa6966bcc09d74f0828be3" "985ae804d944ef73e06335ab2b86f0ea0a10199318b0b15a326a966f5f3fa984" "dbec134fb889afe6034edc2dcd881dbfa302eed9823383f795b5c00517e0ea17" default)))
 '(flymake-error-bitmap
   (quote
    (flymake-double-exclamation-mark modus-theme-fringe-red)))
 '(flymake-note-bitmap (quote (exclamation-mark modus-theme-fringe-cyan)))
 '(flymake-warning-bitmap (quote (exclamation-mark modus-theme-fringe-yellow)))
 '(highlight-tail-colors (quote (("#2f4a00" . 0) ("#00415e" . 20))))
 '(hl-todo-keyword-faces
   (quote
    (("HOLD" . "#cfdf30")
     ("TODO" . "#feacd0")
     ("NEXT" . "#b6a0ff")
     ("THEM" . "#f78fe7")
     ("PROG" . "#00d3d0")
     ("OKAY" . "#4ae8fc")
     ("DONT" . "#80d200")
     ("FAIL" . "#ff8059")
     ("BUG" . "#ff8059")
     ("DONE" . "#44bc44")
     ("NOTE" . "#f0ce43")
     ("KLUDGE" . "#eecc00")
     ("HACK" . "#eecc00")
     ("TEMP" . "#ffcccc")
     ("FIXME" . "#ff9977")
     ("XXX+" . "#f4923b")
     ("REVIEW" . "#6ae4b9")
     ("DEPRECATED" . "#bfd9ff"))))
 '(ibuffer-deletion-face (quote modus-theme-mark-del))
 '(ibuffer-filter-group-name-face (quote modus-theme-mark-symbol))
 '(ibuffer-marked-face (quote modus-theme-mark-sel))
 '(ibuffer-title-face (quote modus-theme-pseudo-header))
 '(livedown-autostart nil)
 '(livedown-browser nil)
 '(livedown-open t)
 '(livedown-port 1337)
 '(package-selected-packages
   (quote
    (rainbow-mode fish-mode yaml-mode ## prettier rust-mode flycheck lsp-ui company lsp-mode)))
 '(pdf-view-midnight-colors (quote ("#ffffff" . "#110b11")))
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#ff8059")
     (40 . "#feacd0")
     (60 . "#f78fe7")
     (80 . "#f4923b")
     (100 . "#eecc00")
     (120 . "#cfdf30")
     (140 . "#f8dec0")
     (160 . "#bfebe0")
     (180 . "#44bc44")
     (200 . "#80d200")
     (220 . "#6ae4b9")
     (240 . "#4ae8fc")
     (260 . "#00d3d0")
     (280 . "#c6eaff")
     (300 . "#2fafff")
     (320 . "#79a8ff")
     (340 . "#00bcff")
     (360 . "#b6a0ff"))))
 '(vc-annotate-very-old-color nil)
 '(xterm-color-names
   ["#000000" "#ff8059" "#44bc44" "#eecc00" "#2fafff" "#feacd0" "#00d3d0" "#a8a8a8"])
 '(xterm-color-names-bright
   ["#181a20" "#f4923b" "#80d200" "#cfdf30" "#79a8ff" "#f78fe7" "#4ae8fc" "#ffffff"]))
