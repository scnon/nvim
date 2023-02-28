local G = require('G')

G.map({
    -- cmap
    -- { 'c', '<c-a>',       '<home>',  { noremap = true } },
    -- { 'c', '<c-e>',       '<end>',   { noremap = true } },
    -- { 'c', '<up>',        '<c-p>',   { noremap = true } },
    -- { 'c', '<down>',      '<c-n>',   { noremap = true } },

    -- VISUAL SELECT模式 s-tab tab左右缩进
    { 'v', '<',           '<gv',     { noremap = true } },
    { 'v', '>',           '>gv',     { noremap = true } },
    { 'v', '<s-tab>',     '<gv',     { noremap = true } },
    { 'v', '<tab>',       '>gv',     { noremap = true } },

    -- 选中全文 选中{ 复制全文
    { 'n', '<m-a>',       'ggVG',    { noremap = true } },
    { 'n', '<m-s>',       'vi{',     { noremap = true } },

    -- emacs风格快捷键 清空一行
    { 'n', '<c-u>',       'cc<Esc>', { noremap = true } },
    { 'i', '<c-u>',       '<Esc>cc', { noremap = true } },
    { 'i', '<c-a>',       '<Esc>I',  { noremap = true } },
    { 'i', '<c-e>',       '<Esc>A',  { noremap = true } },
    { 'i', '<c-p>',       '<Esc>ka',  { noremap = true } },
    { 'i', '<c-n>',       '<Esc>ja',  { noremap = true } },

    -- windows: sp 上下窗口 sv 左右分屏 sc关闭当前 so关闭其他 s方向切换
    { 'n', 'sv',        ':vsp<cr><c-w>w',   { noremap = true } },
    { 'n', 'sp',        ':sp<cr><c-w>w',    { noremap = true } },
    { 'n', 'sc',        ':close<cr>',       { noremap = true } },
    { 'n', 'so',        ':only<cr>',        { noremap = true } },
    { 'n', 's=',        '<c-w>=',           { noremap = true } },
    { 'n', 'sh',        '<c-w>h',           { noremap = true } },
    { 'n', 'sl',        '<c-w>l',           { noremap = true } },
    { 'n', 'sk',        '<c-w>k',           { noremap = true } },
    { 'n', 'sj',        '<c-w>j',           { noremap = true } },
    { 'n', 's0',        "winnr() <= winnr('$') - winnr() ? '<c-w>10>' : '<c-w>10<'", { noremap = true, expr = true } },
    { 'n', 's-',        "winnr() <= winnr('$') - winnr() ? '<c-w>10<' : '<c-w>10>'", { noremap = true, expr = true } },

    -- buffers
    { 'n', 'W',             ':bw<cr>',          { noremap = true, silent = true } },
    { 'n', 'ss',            ':bn<cr>',          { noremap = true, silent = true } },
    { 'n', '<s-h>',         ':bp<cr>',          { noremap = true, silent = true } },
    { 'n', '<s-l>',         ':bn<cr>',          { noremap = true, silent = true } },
    { 'v', '<s-h>',         '<esc>:bp<cr>',     { noremap = true, silent = true } },
    { 'v', '<s-l>',         '<esc>:bn<cr>',     { noremap = true, silent = true } },
    { 'i', '<s-h>',         '<esc>:bp<cr>',     { noremap = true, silent = true } },
    { 'i', '<s-l>',         '<esc>:bn<cr>',     { noremap = true, silent = true } },

    -- tt 打开一个10行大小的终端
    { 'n', 'tt',          ':below 10sp | term<cr>a', { noremap = true, silent = true } },

    -- 折叠
    { 'n', '-',           "za", { noremap = true, silent = true } },
    { 'v', '-',           ':call v:lua.MagicFold()<CR>', { noremap = true, silent = true } },

})

-- 光标在$ 0 ^依次跳转
function MagicMove()
    local first = 1
    local head = #G.fn.getline('.') - #G.fn.substitute(G.fn.getline('.'), '^\\s*', '', 'G') + 1
    local before = G.fn.col('.')
    G.fn.execute(before == first and first ~= head and 'norm! ^' or 'norm! $')
    local after = G.fn.col('.')
    if before == after then
        G.fn.execute('norm! 0')
    end
end

-- 1 当目录不存在时 先创建目录, 2 当前文件是acwrite时, 用sudo保存
function MagicSave()
    if G.fn.empty(G.fn.glob(G.fn.expand('%:p:h'))) then G.fn.system('mkdir -p ' .. G.fn.expand('%:p:h')) end
    if G.o.buftype == 'acwrite' then
        G.fn.execute('w !sudo tee > /dev/null %')
    else
        G.fn.execute('w')
    end
end

-- 驼峰转换 MagicToggleHump(true) 首字母大写 MagicToggleHump(false) 首字母小写
function MagicToggleHump(upperCase)
    G.fn.execute('normal! gv"tx')
    local w = G.fn.getreg('t')
    local toHump = w:find('_') ~= nil
    if toHump then
        w = w:gsub('_(%w)', function(c) return c:upper() end)
    else
        w = w:gsub('(%u)', function(c) return '_' .. c:lower() end)
    end
    if w:sub(1, 1) == '_' then w = w:sub(2) end
    if upperCase then w = w:sub(1,1):upper() .. w:sub(2) end
    G.fn.setreg('t', w)
    G.fn.execute('normal! "tP')
end

-- 折叠(限制最大折叠层数 1)
function MagicFold()
    local max = 1
    if G.fn.foldlevel("'<") > 0 then G.fn.execute("normal! '<zd") end
    if G.fn.foldlevel("'>") > 0 then G.fn.execute("normal! '>zd") end
    G.fn.execute('normal! gvzf')
end
