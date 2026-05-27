(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
