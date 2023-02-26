local G = require('G')

-- 基础设置
G.opt.encoding = 'utf-8'
G.opt.wildmenu = true
G.opt.clipboard = 'unnamed,unnamedplus'
G.cmd([[
silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.config/nvim/tmp/undo,.
endif
]])

-- 设置鼠标移动
G.opt.mouse = 'a'

-- 去掉错误提示音 屏幕闪烁
G.opt.vb = true
G.opt.hidden = true

-- 缩进
G.opt.autoindent = true
G.opt.smartindent = true
G.opt.tabstop = 4
G.opt.softtabstop = 4
G.opt.shiftwidth = 4
G.opt.smarttab = true
G.opt.expandtab = true

-- 显示
G.opt.cmdheight = 1
G.opt.number = true
-- G.cmd('colorscheme codedark')
