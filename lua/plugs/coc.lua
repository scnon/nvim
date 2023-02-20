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

end

function M.setup()
end

return M
