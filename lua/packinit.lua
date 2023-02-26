local G = require('G')
local packer_bootstrap = false
local install_path = G.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local compiled_path = G.fn.stdpath('config')..'/plugin/packer_compiled.lua'

local isWin = G.fn.has('win32') == 1

if isWin then
    install_path = G.fn.stdpath('data')..'\\site\\pack\\packer\\start\\packer.nvim'
    compiled_path = G.fn.stdpath('config')..'\\plugin\\packer_compiled.lua'
end

if G.fn.empty(G.fn.glob(install_path)) > 0 then
    print('Installing packer.nvim...')
    G.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    if isWin then
        G.fn.system({'rmdir', '/s', '/q', compiled_path})
    else
        G.fn.system({'rm', '-rf', compiled_path})
    end
    G.cmd [[packadd packer.nvim]]
    packer_bootstrap = true
end


require('packer').startup({
    function(use)
        -- packer 管理自己的版本
        use { 'wbthomason/packer.nvim' }

        -- vscode 主题
        require('plugs/code-dark').config()
        use { 'tomasiser/vim-code-dark', config = "require('plugs/code-dark').setup()" }

        -- 浮动终端
        require('plugs/floaterm').config()
        use { 'voldikss/vim-floaterm', config = "require('plugs/floaterm').setup()" }

        -- coc
        require('plugs/coc').config()
        use { 'neoclide/coc.nvim', config = "require('plugs/coc').setup()", branch = 'release' }

        -- github copilot
        require('plugs/copilot').config()
        use { 'github/copilot.vim', config = "require('plugs/copilot').setup()", event = 'InsertEnter' }

        -- 状态栏 & 标题栏
        require('plugs/lines').config()
        use { 'yaocccc/nvim-lines.lua', config = "require('plugs/lines').setup()" }

        -- 文件管理器
        require('plugs/nvim-tree').config()
        use { 'nvim-tree/nvim-tree.lua', require = {
            'nvim-tree/nvim-web-devicons',
        }, config = "require('plugs/nvim-tree').setup()" }

    end,
    config = {
        git = { clone_timeout = 120, depth = 1 },
        -- display = {
        --    working_sym = '[]', error_sym = '[✗]', done_sym = '[✓]', removed_sym = ' - ', moved_sym = ' → ', header_sym = '─',
        --    open_fn = function() return require("packer.util").float({ border = "rounded" }) end
        --}
    }
})

if packer_bootstrap then
    require('packer').sync()
end

