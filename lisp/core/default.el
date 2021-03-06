;;; package -- default
;;; Commentary:
;;; Code:


;;;; 用户信息

;;;;用户信息
(section
(setq user-full-name "walter")
(setq user-mail-address "ismrwalter@gmail.com"))

;;;; 基础设置
(section
  (setq shift-select-mode nil)              ; 禁止双击 shift 选择
  (setq load-prefer-newer t)                ; 加载最新的文件
  (setq ring-bell-function 'ignore)         ; 关闭光标警告
  (setq-default inhibit-splash-screen 1)    ; 不显示启动屏幕
  (setq-default initial-scratch-message "") ; 将 Scratch 的内容设为空
  (setq-default create-lockfiles nil)       ; 不要锁定文件
  (setq-default tab-width 4)                ; Tab Width
  (setq-default indent-tabs-mode nil)       ; 使用空格代替 Tab
  (setq-default delete-selection-mode t)    ; 允许删除选区
  (setq-default select-enable-clipboard t)  ; 启用系统剪切板
  (setq ad-redefinition-action 'accept)
  (fset 'yes-or-no-p 'y-or-n-p)         ; 用 y/n 代替 yes/no
  (electric-pair-mode t)                ; 自动输入括号
  (electric-quote-mode t)               ; 自动输入引号
  (delete-selection-mode 1)             ; 插入时替换选区
  (global-auto-revert-mode t)           ; 开启重新加载被修改的文件
  (auto-compression-mode t)             ; 压缩文件支持
  (global-so-long-mode 1) ; 打开长行文件时可能会导致严重的性能问题，可以自动关闭一些可能会导致这一问题的功能
  ;; (global-hl-line-mode t)                 ; 高亮当前的行
  ;; (desktop-save-mode 1)                 ;自动保存环境
  ;; 换行时自动缩进
  (global-set-key (kbd "RET") 'newline-and-indent) ;; 保存文件时移除空格
  (add-hook 'before-save-hook (lambda()
                                (whitespace-cleanup)
                                (delete-trailing-whitespace)))

  ;; 保存光标位置
  (section
    (setq save-place-file (expand-file-name "palces" misc-file-directory))
    (save-place-mode 1))

  ;; 保存最近打开的文件
  (section
    (setq recentf-save-file (expand-file-name "recentf" misc-file-directory))
    (recentf-mode 1))

  ;; 显示行号
  (section (global-linum-mode 1)
           (setq linum-format "%4d ")   ;设置行号格式
           )

  ;; 字符编码
  (section (prefer-coding-system 'utf-8-unix)
           (set-language-environment "English")
           (set-default-coding-systems 'utf-8-unix)
           (set-terminal-coding-system 'utf-8-unix)
           (set-keyboard-coding-system 'utf-8-unix)
           (setq locale-coding-system 'utf-8-unix))

  ;; Emacs备份
  (section
    (defconst backup-file-directory (expand-file-name "backup" misc-file-directory))
    (make-directory backup-file-directory t)
    ;; 启动备份版本控制
    (setq version-control t)
    ;; 创建版本控制备份文件
    (setq vc-make-backup-files t)
    ;; 删除旧的版本
    (setq delete-old-versions -1)
    ;; 设置备份目录
    (setq backup-directory-alist `(("." . ,backup-file-directory)))
    ;; 设置自动保存文件名
    (setq auto-save-file-name-transforms  `((".*" ,backup-file-directory t)))
    (setq auto-save-list-file-prefix backup-file-directory))

  ;; UI控件设置
  (section (menu-bar-mode -1)           ; 隐藏菜单
           (tool-bar-mode -1)           ; 隐藏工具栏
           (scroll-bar-mode -1)         ; 隐藏滚动条
           (when environment/gui
             (setq mouse-highlight nil) ; 禁止鼠标悬浮高亮
             (setq-default frame-title-format "[%m] %f") ; 设置窗口标题格式
             (setq-default use-dialog-box nil) ; 不现实对话框
             (set-frame-parameter nil 'alpha 100) ;设置窗口透明度
             ;;设置自动换行标识
             (define-fringe-bitmap 'right-curly-arrow [#b00101010 ;
                                                       #b00000000 ;
                                                       #b00000010 ;
                                                       #b00000000 ;
                                                       #b00000010 ;
                                                       #b00000000 ;
                                                       #b00000010 ;
                                                       #b00000000 ;
                                                       #b00010010 ;
                                                       #b00100000 ;
                                                       #b01111110])
             (define-fringe-bitmap 'left-curly-arrow [#b00000000])))

  ;; 滚动行为
  (section
    (setq scroll-conservatively 10000)  ; 滚动时保持光标位置
    (setq scroll-step 1)                ; 滚动行数
    (setq scroll-margin 5)              ; 滚动光标边距
    (setq hscroll-step 1)               ; 水平滚动列数
    (setq hscroll-margin 10)            ; 水平滚动光标边距
    )
  ;; 优化 Minibuffer
  (section
    (setq echo-keystrokes 0.1)          ; 显示未完成的按键命令
    (setq-default history-length 500)   ; Minibuffer 历史长度
    (setq-default enable-recursive-minibuffers nil) ; 禁止递归 Minibuffer
    (setq-default minibuffer-prompt-properties '(read-only t point-entered minibuffer-avoid-prompt
                                                           face minibuffer-prompt))
    ;; 自动关闭minibuffer
    (add-hook 'mouse-leave-buffer-hook (lambda()
                                         (when (and (>= (recursion-depth) 1)
                                                    (active-minibuffer-window))
                                           (abort-recursive-edit)))))
  (section (setq-default mouse-wheel-progressive-speed nil) ; 设置鼠标滚动速度
           (setq read-process-output-max (* 1024 1024)) ; 设置Emacs每次从进程读取的最大数据量
           )
  ;; 优化 Dired mode
  (section
    (setq dired-recursive-deletes 'always)       ;递归删除
    (setq dired-recursive-copies 'always)        ;递归复制
    (setq global-auto-revert-non-file-buffers t) ;自动刷新
    (setq auto-revert-verbose nil)               ;不显示多余的信息
    (setq dired-dwim-target t)                   ;快速复制和移动
    (setq delete-by-moving-to-trash t)           ;删除文件到trash
    (put 'dired-find-alternate-file 'disabled nil) ;重新使用已经存在dired buffer
    (with-eval-after-load 'dired (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
                          (define-key dired-mode-map (kbd "<return>") 'dired-find-alternate-file)
                          (define-key dired-mode-map (kbd "^")
                            (lambda ()
                              (interactive)
                              (find-alternate-file ".."))))))


(provide 'core/default)
;;; default.el ends here
