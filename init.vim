"
" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" 自动下载插件管理器 plug.vim
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" 插件列表
call plug#begin()

" Github Copilot
Plug 'github/copilot.vim'

" coc.nvim 代码补全
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" 自动补全括号
Plug 'jiangmiao/auto-pairs'

" 底部状态栏
Plug 'theniceboy/eleline.vim', { 'branch': 'no-scrollbar' }

" 代码注释
Plug 'theniceboy/tcomment_vim'

" Vscode 主题
Plug 'tomasiser/vim-code-dark'

" 顶部选项卡
Plug 'nvim-tree/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

" 模糊搜索
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

call plug#end()



" ================= 基础设置 =====================
set autochdir
set exrc
set secure
set number
set relativenumber
set cursorline
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set list
set listchars=tab:\|\ ,trail:>
set clipboard=unnamedplus

set wrap

silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.config/nvim/tmp/undo,.
endif
set colorcolumn=100
set updatetime=100
set virtualedit=block

colorscheme codedark

noremap <silent> <C-t> :terminal<CR><A>

" ================== coc.nvim =======================
let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-docker',
	\ 'coc-eslint',
	\ 'coc-explorer',
	\ 'coc-flutter-tools',
	\ 'coc-gitignore',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-prettier',
	\ 'coc-pyright',
	\ 'coc-snippets',
	\ 'coc-stylelint',
	\ 'coc-syntax',
	\ 'coc-translator',
	\ 'coc-tsserver',
	\ 'coc-vetur',
	\ 'coc-vimlsp',
	\ 'coc-yaml'
\]

" Tab 按键向下选择补全项
inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#pum#next(1) :
	\ CheckBackspace() ? "<Tab>" :
	\ coc#refresh()
"
"  inoremap <expr><S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" 回车键应用补全项
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
	\ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

" ctrl+0 显示当前所有的补全项
inoremap <silent><expr> <c-o> coc#refresh()

function! ShowDocument() abort
	call CocActionAsync('highlight')
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" ctrl+h 显示当前光标下的文档
inoremap c-h :call ShowDocument()<CR>

" 翻译
nmap ts <Plug>(coc-translator-p)
vmap ts <Plug>(coc-translator-pv)

" 代码跳转
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 文件管理器
nmap tt :CocCommand explorer<CR>



" ================== 自动补全括号 =======================
au Filetype FILETYPE let b:AutoPairs = {"(": ")"}
au FileType php      let b:AutoPairs = AutoPairsDefine({'<?' : '?>', '<?php': '?>'})


" ==================== eleline.vim ====================
let g:airline_powerline_fonts = 0


" ==================== tcomment_vim ====================
" 代码注释
let g:tcomment_textobject_inline_comment = ''
nmap <LEADER>cn g>c
vmap <LEADER>cu g>
nmap <LEADER>cu g>c
vmap <LEADER>cn g>

" ==================== xtabline ====================
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
noremap to :XTabCycleMode<CR>
noremap \p :echo expand('%:p')<CR>

" ==================== rnvimr ====================
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_draw_border = 0
" let g:rnvimr_bw_enable = 1
highlight link RnvimrNormal CursorLine
" R 键打开 ranger
nnoremap <silent> R :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': 0.6,
            \ 'height': 0.6,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]



"==================== vim-telescope ====================

nnoremap <c-p> <cmd>Telescope find_files<cr>
nnoremap <c-l> <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>
