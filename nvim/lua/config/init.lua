-- [nfnl] Compiled from fnl/config/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local core = autoload("nfnl.core")
nvim.set_keymap("n", "<space>", "<nop>", {noremap = true})
nvim.set_keymap("i", "jk", "<esc>", {silent = true})
nvim.set_keymap("n", "<leader>w", "<cmd>w<cr>", {noremap = true})
nvim.set_keymap("n", "<leader>q", "<cmd>q<cr>", {noremap = true})
nvim.set_keymap("n", "<leader>e", "<cmd>Neotree float<cr>", {noremap = true})
do
  local options = {expandtab = true, tabstop = 2, shiftwidth = 2, softtabstop = 2, completeopt = "menuone,noselect", ignorecase = true, smartcase = true, clipboard = "unnamedplus", number = true, ruler = true, signcolumn = "number"}
  for option, value in pairs(options) do
    core.assoc(nvim.o, option, value)
  end
end
return {}
