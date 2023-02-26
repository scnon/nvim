local G = require('G')
local M = {}

function M.config()
    G.g.coc_global_extensions = {
        'coc-tsserver',
        'coc-json',
        'coc-html',
        'coc-css',
        'coc-go',
        'coc-sh',
        'coc-db',
        'coc-stylua',
        'coc-translator',
    }

    G.cmd("command! -nargs=? Fold :call CocAction('fold', <f-args>)")
    -- Tab 按键向下选择补全项
    G.cmd([[
    inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "<Tab>" : coc#refresh()
    function! CheckBackspace() abort
	    let col = col('.') - 1
	    return !col || getline('.')[col - 1] =~# '\s'
    endfunction
    ]])
    -- 回车键应用补全项
    G.cmd([[
        inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    ]])

end

function M.setup()
end

return M
