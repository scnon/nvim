local G = require('G')
local M = {}

function M.config()
end

function M.setup()
    G.map({ { 'n', '<c-n>', ':NvimTreeToggle<cr>', { noremap = true } }})
    require("nvim-tree").setup({
        sort_by = "case_insensitive",
        actions = {
            open_file = {
                window_picker = { enable = false }
            }
        },
        view = {
            mappings = {
                list = {
                    { key = 'P', action = 'dir_up' },
                    { key = '<Cr>', action = 'cd' },
                },
            },
            float = {
                enable = false,
                open_win_config = function()
                    local columns = G.o.columns
                    local lines = G.o.lines
                    local width = math.max(math.floor(columns * 0.5), 50)
                    local height = math.max(math.floor(lines * 0.5), 20)
                    local left = math.ceil((columns - width) * 0.5)
                    local top = math.ceil((lines - height) * 0.5 - 2)
                    return { relative = "editor", border = "rounded", width = width, height = height, row = top, col = left }
                end
            }
        }
    })
end

return M
