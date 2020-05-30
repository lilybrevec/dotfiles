;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;    Load Extensions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Import Melpa
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
(package-initialize)

;; add load-path
(if (file-directory-p "~/.emacs.d/elisp")
  (add-to-list 'load-path "~/.emacs.d/elisp"))

(eval-when-compile
  (require 'use-package))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;    System Setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; change yes or no to y or n
(fset 'yes-or-no-p 'y-or-n-p)
;; no save backups
(setq make-backup-files nil)
;; スタート時のスプラッシュ非表示
(setq inhibit-startup-message t)
;; ビープ音を消す
(setq ring-bell-function 'ignore)
;; Delete Menubar
(menu-bar-mode 0)
;; Delete Warning
(tool-bar-mode 0)
;; Delete Warning
(setq warning-minimum-level :error)
;; Color Mode
(global-font-lock-mode t)
;; 行末が画面表示から溢れる時に折り返す
(toggle-truncate-lines 1)
;; ホームディレクトリを ~ で表記
(setq default-directory "~/")
;; 分割ウィンドウ時の折り返し
(setq truncate-partial-width-windows nil)

;; 最近使ったファイルをメニューに表示
;;(recentf-mode t)
;; 最近使ったファイルの表示数
;;(setq recentf-max-menu-items 10)
;; 最近開いたファイルの保存数を増やす
;;(setq recentf-max-saved-items 100)



;; アイコン設定
(use-package all-the-icons)
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-bar-width 3)
  (setq doom-modeline-height 20)
  (setq doom-modeline-icon (display-graphic-p))
  (setq doom-modeline-minor-modes nil))

;;(global-set-key (kbd "C-m") 'avy-goto-word-1)
;;(defun one-prefix-avy (prefix c &optional mode)
;;  (define-key global-map
;;	(read-kbd-macro (concat prefix (string c)))
;;	`(lambda ()
;;	   (interactive)
;;	   (funcall (if (eq ',mode 'char)
;;					#'avy-goto-word-1
;;				  #'avy-goto-char) ,c))))
;;(cl-loop for c from ?! to ?~ do (one-prefix-avy "H-" c) finally (cl-return t))

;; ivy設定
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-height 30)
(setq ivy-extra-directories nil)
(setq ivy-re-builders-alist
      '((t . ivy--regex-plus)))

;; neotree設定
(setq neo-theme 'ascii) ;; icon, classic等もあるよ！
(setq neo-persist-show t) ;; delete-other-window で neotree ウィンドウを消さない
(setq neo-smart-open t) ;; neotree ウィンドウを表示する毎に current file のあるディレクトリを表示する
(setq neo-smart-open t)
(global-set-key "\C-o" 'neotree-toggle)

;; counsel設定
;(global-set-key (kbd "M-x") 'counsel-M-x)
;(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;(setq counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))

;(global-set-key (kbd "C-c g") 'counsel-git)
;(global-set-key (kbd "C-c j") 'counsel-git-grep)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;    Key Setting

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Use ctrl-h as delete
(define-key global-map "\C-h" 'delete-backward-char)
;; Use ctrl-t as window change
(define-key global-map (kbd "C-t") 'other-window)
;; Help
(define-key global-map "\M-?" 'help-for-help)
;; \C-\の日本語入力の設定を無効にする
(define-key global-map "\C-\\" nil)
;; undo
(global-set-key (kbd "C-q") 'undo)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;    Editor Setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setting for Japanese and UTF-8
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; font settings
(set-face-attribute 'default nil
                    :family "monaco"
                    :height 140)
;; scroll one line at a time
(setq scroll-step 1)
;; Turn on column numbering
(column-number-mode t)
;; Turn off cursor blinking
(blink-cursor-mode 0)
;; 釣り合いのとれる括弧をハイライトする
(show-paren-mode 1)
;; タブ設定
(setq-default tab-width 2 indent-tabs-mode nil)
(put 'upcase-region 'disabled nil)
;; 行番号表示
(global-linum-mode t)
(setq linum-format "%3d ")
(set-face-attribute 'linum nil
                    :foreground "#f00"
                    :height 0.9)
;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")
;; 現在の関数を表示
(which-func-mode 1)
;; C-Ret で矩形選択
(cua-mode t)
(setq cua-enable-cua-keys nil)
;; Auto-Complete
(ac-config-default)
;; theme
(load-theme 'misterioso t)
;;(load-theme 'dichromacy t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;    Language Setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For web(HTML,JavaScript,CSS) mode
(require 'web-mode)

;; For rust mode
(use-package rustic)

;; Setting For custome file
;; http://extra-vision.blogspot.com/2016/10/emacs25-package-selected-packages.html
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;; For tuareg-mode ocaml
;;(load "tuareg-ochadai" t)
(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
(autoload 'tuareg-mode "tuareg" "Major mode for editing OCaml code" t)
(autoload 'tuareg-run-ocaml "tuareg" "Run an inferior OCaml process." t)
(autoload 'ocamldebug "ocamldebug" "Run the OCaml debugger" t)
