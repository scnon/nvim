local G = require('G')
local M = {}

function M.config()
    G.g.fzf_preview_window = {'right:50%:hidden', 'ctrl-/'}
    G.g.fzf_commit_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
    G.g.fzf_layout = {window = {width = 0.9, height = 0.8}}

    G.map({
        { 'n', '<c-a>', ':Ag<cr>', { silent = true, noremap = true } },
    })
end

function M.setup()
end


return M
