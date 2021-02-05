(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq inhibit-splash-screen 1)

(defvar spotify-path "/home/emacs/.emacs.d/spotify.el")
(add-to-list 'load-path "/home/emacs/.emacs.d/spotify.el")

;; melpa
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)


(defun l ()
  "Carrega sa configuració."
  (interactive)
  (load-file "/home/emacs/.emacs.d/init.el"))

(defun lc ()
  "Obri s'arxiu de configuració."
  (interactive)
  (find-file "/home/emacs/.emacs.d/init.el"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(doom-one))
 '(custom-safe-themes
   '("162b0cd4aa03c124efae6edc1cd6d036e85b720512a4a9704980ea0e54cd6caf" "df21d8cfc66d0dbad35a44116851491f00f50421357fc1f04f73d243b0410316" "1b77a33a8f953e8018bcfc4c79aa1f1825251389fefd7588a26cff34a8d4fd98" "23c37a5ad52a0676f1eff5391486953698e5b535616cfe9acab005a3033911d4" "c0c1891f936e8ec579558a3162e2eef387e781cd65d40af218e9897af193a8c3" "5b04ed3935ff56e4f8b3c49b2e2d003865170c8f7feebce510c6eb363ac24f12" "2586be8af87fb0b982006df5ee6045bae172391240d153b2d5a077e6c4b0735b" "fd638bb24c8d99ad6d822a6ac260bc98cdb6be54c4f2522affc05f0d45d7c3ce" "e73a648635b171521927bdb4c1847590efc7c16739b2d178646f1157468c4845" "7c21eb03ffe441af30fe825eabb240b381d554f695f7c26cc17bf0ac56fac454" "b5fff23b86b3fd2dd2cc86aa3b27ee91513adaefeaa75adc8af35a45ffb6c499" "71e5acf6053215f553036482f3340a5445aee364fb2e292c70d9175fb0cc8af7" "2c49d6ac8c0bf19648c9d2eabec9b246d46cb94d83713eaae4f26b49a8183fc4" "e6ff132edb1bfa0645e2ba032c44ce94a3bd3c15e3929cdf6c049802cf059a2a" "ee9a30ae06edfd3cf8929a29da3c125af14301ea1d72a700290b5c15f999d17d" "12bc0a84a45a6149bc4eaa5fb59beaefd3137d435a7bfa61b56966bd755e4beb" "ab1afc121e776103057f867899b98d6a9eca3a134349a5a1792014b35f55a000" "d5ad56308e3306ee759086d418975e2cef214bc03745468f0908f995f0a02b45" "ffa0e7d9b94b26cb3e7ecb7b6ee7623162db63d2d83f3b83da2f865c4348e372" "b05072434a37de0d2c6645340fc2b94bdc1cd8d35cde92cf32a702de670884a6" "77113617a0642d74767295c4408e17da3bfd9aa80aaa2b4eeb34680f6172d71a" default))
 '(helm-completion-style 'emacs)
 '(key-chord-mode t)
 '(line-number-mode nil)
 '(package-selected-packages
   '(all-the-icons-ivy-rich ivy-rich counsel ivy key-chord treemacs-projectile treemacs helm-descbinds helm-core company-phpactor phpactor flycheck-phpstan flycheck company-php use-package php-mode emmet-mode yasnippet company-web web-mode hl-todo projectile-codesearch projectile doom-modeline general linum-relative doom-themes evil))
 '(treemacs-filewatch-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(package-install-selected-packages)

(require 'evil)
(evil-mode 1)

(require 'doom-modeline)
(doom-modeline-mode 1)

;; tema
(load-theme 'doom-oceanic-next t)
(set-face-attribute 'default nil :font "Hack" :height 110)
(set-frame-parameter (selected-frame) 'alpha '(95 . 90))
(add-to-list 'default-frame-alist '(alpha . (95 . 90)))

;; línies
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; coses
(setq byte-compile-warnings '(cl-functions))

(require 'linum-relative)
(setq linum-relative-current-symbol "")
(linum-relative-mode 1)

(set-default 'truncate-lines t)
(setq default-tab-width 4)

;; reinici
(defun launch-separate-emacs-in-terminal ()
  "Obri Emacs a un terminal."
  (suspend-emacs "fg ; emacs -nw"))

(defun launch-separate-emacs-under-x ()
  "Obri Emacs a X."
  (call-process "sh" nil nil nil "-c" "emacs &"))

(defun restart-emacs ()
  "Reinicia Emacs."
  (interactive)
  ;; We need the new emacs to be spawned after all kill-emacs-hooks
  ;; have been processed and there is nothing interesting left
  (let ((kill-emacs-hook (append kill-emacs-hook (list (if (display-graphic-p)
                                                           #'launch-separate-emacs-under-x
                                                         #'launch-separate-emacs-in-terminal)))))
    (save-buffers-kill-emacs)))

(require 'eshell)
(require 'em-tramp)

(setq eshell-prefer-lisp-functions t)
(setq password-cache t) ; enable password caching
(setq password-cache-expiry 3600) ; for one hour (time in secs)

(defun term-bash ()
  "Obri un terminal abaix."
  (interactive)
  (eshell))
  ;;(term "/usr/bin/bash"))

;; ESHELL
(setq eshell-aliases-file "/home/emacs/.emacs.d/aliases")


(require 'key-chord)
(require 'general)
(general-evil-setup t)
(key-chord-mode 1)

;;(add-to-list 'display-buffer-alist
;;                    `(,(rx bos "*helm" (* not-newline) "*" eos)
;;                         (display-buffer-in-side-window)
;;                         (inhibit-same-window . t)
;;                         (window-height . 0.3)))

(add-to-list 'display-buffer-alist
                    `(,(rx bos "*eshell" (* not-newline) "*" eos)
                         (display-buffer-in-side-window)
                         (inhibit-same-window . t)
                         (window-height . 0.3)))


(require 'helm)
(helm-mode 0)

;;(require 'helm-descbinds)
;;(helm-descbinds-mode +1)

(require 'ivy)

(ivy-mode +1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-count-format "(%d/%d) ")
(setq ivy-height 15)

;; icones i que quedi xulo
(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))


(use-package ivy-rich
  :ensure t
  :init
  (ivy-rich-mode +1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

(nmap
  ",." 'evil-ex)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(global-set-key (kbd "C-M-k") 'windmove-up)
(global-set-key (kbd "C-M-j") 'windmove-down)
(global-set-key (kbd "C-M-l") 'windmove-right)
(global-set-key (kbd "C-M-h") 'windmove-left)

(general-define-key :keymaps 'evil-insert-state-map
                    (general-chord "jk") 'evil-normal-state
                    (general-chord "kj") 'evil-normal-state
		    (general-chord ",.") 'evil-ex)

;;(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-x") 'counsel-M-x)


(nvmap :prefix "SPC"
  ;;"." 'helm-find-files
  ;;"<SPC>" 'helm-find-files
  "." 'counsel-find-file
  "<SPC>" 'counsel-find-file
  "bn" 'next-buffer
  "bp" 'previous-buffer
  ;;"B" 'helm-buffers-list
  "B" 'ivy-switch-buffer
  "bk" 'kill-current-buffer
  "qe" 'kill-emacs
  "qr" 'restart-emacs

  ;;"x" 'helm-M-x
  "x" 'counsel-M-x

  "p" 'projectile-command-map
  "S" 'spotify-command-map
  "bl" 'linum-relative-toggle  ;; TODO: llevar aixo quan sigui

  "k" 'evil-window-up
  "j" 'evil-window-down
  "l" 'evil-window-right
  "h" 'evil-window-left

  "d" 'evil-window-delete
  "s" 'evil-window-split
  "v" 'evil-window-vsplit

  "w" 'save-buffer
  ;;"of" 'helm-find-files
  "of" 'counsel-find-file
  "ot" 'term-bash
  "t" 'treemacs)


(require 'projectile)
(projectile-global-mode)

(require 'treemacs)
(setq treemacs-width 20)

(add-hook 'nav-mode-hook 'disable-evil-mode)
(evil-set-initial-state 'dired-mode 'emacs)
(evil-set-initial-state 'sunrise-mode 'emacs)
(evil-set-initial-state 'treemacs-mode 'emacs)

(require 'hl-todo)
(hl-todo-mode 1)

(desktop-save-mode 1)

;; Spotify
;;(add-to-list 'load-path spotify-path)
(require 'spotify)

(setq spotify-oauth2-callback-port 8080)
(setq spotify-oauth2-client-id "956d511c1f2242888bef2f51513d023c")
(setq spotify-oauth2-client-secret "7ca2e5dc5e714692b71ae6f02b07179d")

;; *** PROGRAMACIÓ ***
(require 'web-mode)
(require 'emmet-mode)

(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))


(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)    

(defun my-web-mode-hook ()
  (set (make-local-variable 'company-backends) '(
						 company-css
						 company-web-html
						 company-yasnippet
						 company-files
						 company-phpactor))
)
(add-hook 'web-mode-hook  'emmet-mode) 
(add-hook 'php-mode-hook  'emmet-mode) 
(add-hook 'css-mode-hook  'emmet-mode)
(add-hook 'sgml-mode-hook  'emmet-mode)

(add-hook 'web-mode-before-auto-complete-hooks
    '(lambda ()
     (let ((web-mode-cur-language
  	    (web-mode-language-at-pos)))
               (if (string= web-mode-cur-language "php")
    	   (yas-activate-extra-mode 'php-mode)
      	 (yas-deactivate-extra-mode 'php-mode))
               (if (string= web-mode-cur-language "css")
    	   (setq emmet-use-css-transform t)
      	 (setq emmet-use-css-transform nil)))))

(use-package php-mode :ensure t)

;; *** COLORS ***
(defun xah-syntax-color-hex ()
  "Syntax color text of the form 「#ff1100」 and 「#abc」 in current buffer.
URL `http://ergoemacs.org/emacs/emacs_CSS_colors.html'
Version 2017-03-12"
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[[:xdigit:]]\\{3\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background
                      (let* (
                             (ms (match-string-no-properties 0))
                             (r (substring ms 1 2))
                             (g (substring ms 2 3))
                             (b (substring ms 3 4)))
                        (concat "#" r r g g b b))))))
     ("#[[:xdigit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-flush))

;; COMPANY-WEBMODE
(add-hook 'css-mode-hook 'xah-syntax-color-hex)
(add-hook 'php-mode-hook 'xah-syntax-color-hex)
(add-hook 'html-mode-hook 'xah-syntax-color-hex)
(add-hook 'lisp-mode-hook 'xah-syntax-color-hex)
(add-hook 'after-init-hook 'global-company-mode)

(global-flycheck-mode)
(global-set-key (kbd "C-c c") 'company-complete)
(global-set-key (kbd "<C-tab>") 'emmet-expand-line)

;; ELISP

;; PHP
(use-package phpactor :ensure t)
(use-package company-phpactor :ensure t)

(defun my-php ()
  "My PHP-mode hook."
  (require 'flycheck-phpstan)
  (flycheck-mode 1)
  (add-to-list 'company-backends 'company-my-php-backend))

(add-hook 'php-mode-hook 'my-php)
(add-hook 'web-mode-hook 'my-php)

 (defun company-my-php-backend (command &optional arg &rest ignored)
    (case command
      (prefix (and (eq major-mode 'php-mode)
                    (company-grab-symbol)))
      (sorted t)
      (candidates (all-completions
                   arg
                   (if (and (boundp 'my-php-symbol-hash)
                            my-php-symbol-hash)
                      my-php-symbol-hash

                     (with-temp-buffer
                          (call-process-shell-command "php -r '$all=get_defined_functions();foreach ($all[\"internal\"] as $fun) { echo $fun . \";\";};'" nil t)
                       (goto-char (point-min))
                       (let ((hash (make-hash-table)))
                         (while (re-search-forward "\\([^;]+\\);" (point-max) t)
                           (puthash (match-string 1) t hash))
                         (setq my-php-symbol-hash hash))))))))


(provide 'init)
;;; init.el ends here
