;; === Настройка пакетов ===
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; === PHP-mode ===
(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

;; === Автодополнение (company) ===
(require 'company)
(global-company-mode t)                 ; включаем company везде

;; Для PHP-буферов настраиваем лёгкие источники дополнения
(add-hook 'php-mode-hook
          (lambda ()
            ;; Основные источники: контекстное дополнение из php-mode + слова из открытых буферов
            (setq-local company-backends
                        '((company-capf        ; стандартное дополнение, которое php-mode предоставляет через completion-at-point (функции PHP, переменные и т.д.)
                           company-dabbrev-code ; дополнение по словам из всех буферов с кодом (быстро ищет похожие имена)
                           company-keywords     ; ключевые слова языка (если php-mode их добавляет)
                           company-files        ; имена файлов (удобно для include/require)
                           )))
            ;; Отключаем требовательные к ресурсам бэкенды, чтобы не нагружать систему
            ;; (никаких company-ispell, company-yasnippet по желанию)
            ))

;; === Установка eglot (Emacs 27) ===
(unless (package-installed-p 'eglot)
  (package-refresh-contents)
  (package-install 'eglot))

(require 'eglot)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((php-mode :language-id "php") . ("phpactor" "language-server"))))

(add-hook 'php-mode-hook 'eglot-ensure)
