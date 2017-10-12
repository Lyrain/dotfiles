;; My emacs config file
;; Myles Offord
(require 'package)

;; Add a list of repositories.
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

;; Print debug stacktrace when an error is detected
(setq debug-on-error  t)

;; Initialize packages
(setq package-enable-at-startup nil)

(defun fluff-ensure-package-installed (&rest packages)
  "Ensure every package is installed, ask for installation if it's not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
   nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
     (package-install package)
   package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activeate installed packages
(package-initialize)

;; List packages for installation here.
;; 'evil 'evil-surround ?
(fluff-ensure-package-installed 'monokai-theme
                                'helm
                                'evil
                                'evil-surround
                                'projectile
                                'helm-projectile
                                'web-mode
                                'emmet-mode)

;; Custom theme
(load-theme 'monokai t)

;; Essential settings.
(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (toggle-scroll-bar -1))
(show-paren-mode 1)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indent-tabs-mode nil)
(eval-after-load "vc" '(setq vc-handled-backends nil))
(setq vc-follow-symlinks t)
(setq large-file-warning-threshold nil)
(setq split-width-threshold nil)
(setq custom-safe-themes t)
(put 'narrow-to-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages (quote (web-mode helm-projectile evil-surround emmet-mode))))
(setq scroll-step 1)

;; Turn Backup off because it is very annoying
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; Change from control to command on mac
(setq mac-command-modifier 'control)
(global-linum-mode 1)

;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (format "%s/$s$s/" temporary-file-directory "emcas" (user-uid)))
(setq backup-directory-alist
      '((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      '((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)

;; Evil-Mode
(require 'evil)
(evil-mode t)

;; Map 'c' in such a way ciw & cow works properly
(general-nmap "c"
              (general-key-dispatch 'evil-change
                "ow" 'toggle-word-wrap
                "w"  (general-simulate-keys ('evil-change "iw"))
                "iw" (general-simulate-keys ('evil-change "iw"))
                "tb" 'some-command
                "c"  'evil-change-whole-line
                ;; could be used for other operators where there
                ;; isn't an existing command for the linewise version:
                ;; "c" (general-simulate-keys ('evil-change "c"))
                ))
(general-vmap "c" 'evil-change)

;; Evil-Surround
(require 'evil-surround)
(global-evil-surround-mode t)

;; Helm
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-x", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change 'helm-command-prefix-key' once 'helm-config' is loaded.
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; rebind tab to run persistent action 
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;; make TAB work in terminal
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
;; list actions using C-z
(define-key helm-map (kbd "C-z") 'helm-select-action)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, no occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in 'require' and 'declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line        t)

(defun fluff-helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background, bg-color :foreground, bg-color)))
      (setq-local cursor-type nil))))

(add-hook 'helm-minibuffer-set-up-hook
          'fluff-helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)

;; Projectile + helm-projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; Projectile file indexing is really slow on windows (this is the default elsewhere)
;; setting to 'alien uses external tools (git, find, etc) to index files (much faster than lisp solution)
(setq projectile-indexing-method 'alien)

;; Use helm completion for switching projectile projects
(setq projectile-switch-project-action 'helm-projectile)



;; Web-Mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2) ;; CSS offset indentation
(setq web-mode-code-indent-offset 2) ;; Script/code offset indentation (for JavaScript, Java, PHP, Ruby, VBScript, Python, etc.)

;; Emmet-Mode
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes.
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(setq emmet-move-cursor-between-quotes t) ;; Move the cursor to the first set of empty quotes, default nil.
(setq emmet-expand-jsx-className? t) ;; Expand for JSX for use with react, default nil.
