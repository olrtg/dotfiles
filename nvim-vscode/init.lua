vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

-- [[ Lazy ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-surround",

	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},
})

local vscode = require("vscode-neovim")

vim.keymap.set("n", "<leader>w", function()
	vscode.call("workbench.action.files.save")
end)
vim.keymap.set("n", "<leader>f", function()
	vscode.call("workbench.action.quickOpen")
end)
vim.keymap.set("n", "<leader>st", function()
	vscode.call("workbench.action.findInFiles")
end)

-- [[ LSP ]]
vim.keymap.set("n", "gs", function()
	vscode.call("editor.action.triggerParameterHints")
end)
vim.keymap.set("n", "<leader>la", function()
	vscode.call("editor.action.quickFix")
end)
vim.keymap.set("n", "<leader>lr", function()
	vscode.call("editor.action.rename")
end)
