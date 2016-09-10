;; My emacs config file
;; Myles Offord
(require 'package)

;; Add a list of repositories.
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

;; Initialize packages
(setq package-enable-at-startup nil)

(defun fluff-ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it's not.

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
(fluff-ensure-package-installed 'evil
                                'evil-surround
                                'helm
                                'projectile
                                'helm-projectile
                                'web-mode
                                'emmet-mode)

;; Custom theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
;; Need to set-frame-parameter to dark before loading the them, otherwise it doesn't work
(set-frame-parameter nil 'background-mode 'dark)
(load-theme 'solarized t)

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
 '(initial-frame-alist (quote ((fullscreen . maximized)))))
;; Change from control to command on mac
;; (setq mac-command-modifier 'control)

;; Evil-Mode
(require 'evil)
(evil-mode t)

;; Evil-Surround
(require 'evil-surround)
(global-evil-surround-mode t)

;; Helm
(require 'helm)
(helm-mode t)

;; Projectile + Helm-projectile
(require 'projectile)
(projectile-global-mode)

(require 'helm-projectile)
(helm-projectile-on)

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
