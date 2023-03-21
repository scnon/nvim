-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local G = require("G")

G.map({
  -- VISUAL SELECT模式 s-tab tab左右缩进
  { "v", "<", "<gv", { noremap = true } },
  { "v", ">", ">gv", { noremap = true } },
  { "v", "<s-tab>", "<gv", { noremap = true } },
  { "v", "<tab>", ">gv", { noremap = true } },
})
