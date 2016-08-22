;; Reqire common lisp libraries
(require 'cl)

;; Make sure we have el-get
(unless (require 'el-get nil t)
  (url-retrieve "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer))))
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; Custom theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
;; Need to set-frame-parameter to dark before loading the them, otherwise it doesn't work
(set-frame-parameter nil 'background-mode 'dark)
(load-theme 'solarized t)

;; Remove the tool bar
(custom-set-variables '(tool-bar-mode nil))
(menu-bar-mode -1)
(toggle-scroll-bar -1)

;; Change from control to command on mac
(setq mac-command-modifier 'control)

;; Allow hash to be entered
;; (global-set-key (kbd "M-3") '(lambda()(interactive)(insert "#")))

;; Evil-Mode
;; (add-to-list 'load-path "~/.emacs.d/el-get/evil")
;; (require 'evil)
;; (evil-mode 1)


