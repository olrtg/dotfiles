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
	"tpope/vim-projectionist",

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = true,
	},

	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},
}, { root = vim.fn.stdpath("data") .. "/lazy-vscode" })

local vscode = require("vscode-neovim")

vim.notify = vscode.notify

vim.keymap.set("n", "<leader>w", function()
	vscode.call("workbench.action.files.save")
end)
vim.keymap.set("n", "<leader>q", function()
	vscode.call("workbench.action.closeActiveEditor")
end)
vim.keymap.set("n", "<leader>c", function()
	vscode.call("workbench.action.closeActiveEditor")
end)
vim.keymap.set("n", "<leader>f", function()
	vscode.call("workbench.action.quickOpen")
end)
vim.keymap.set("n", "<leader>st", function()
	vscode.call("workbench.action.findInFiles")
end)
vim.keymap.set("n", "<leader>e", function()
	vscode.call("workbench.view.explorer")
end)
vim.keymap.set("n", "<leader>gg", function()
	vscode.call("lazygit.openLazygit")
end)
vim.keymap.set("n", "<leader>R", function()
	vscode.call("workbench.action.openRecent")
end)
vim.keymap.set("n", "u", function()
	vscode.call("undo")
end)
vim.keymap.set("n", "<C-r>", function()
	vscode.call("redo")
end)
vim.keymap.set({ "n", "v" }, "<cr>", function()
	vscode.call("editor.action.smartSelect.expand")
end)
vim.keymap.set({ "n", "v" }, "<bs>", function()
	vscode.call("editor.action.smartSelect.expand")
end)

-- [[ LSP ]]
vim.keymap.set("n", "grr", function()
	vscode.call("editor.action.goToReferences")
end)
vim.keymap.set("n", "gs", function()
	vscode.call("editor.action.triggerParameterHints")
end)
vim.keymap.set({ "n", "x" }, "<leader>gra", function()
	vscode.call("editor.action.quickFix")
end)
vim.keymap.set("n", "<leader>grn", function()
	vscode.call("editor.action.rename")
end)
vim.keymap.set("n", "<leader>ld", function()
	vscode.call("workbench.actions.view.problems")
end)
vim.keymap.set("n", "<leader>lj", function()
	vscode.call("workbench.action.editor.nextChange")
end)
vim.keymap.set("n", "<leader>lk", function()
	vscode.call("workbench.action.editor.previousChange")
end)

-- [[ Navigation ]]
vim.keymap.set("n", "<S-h>", function()
	vscode.call("workbench.action.previousEditor")
end)
vim.keymap.set("n", "<S-l>", function()
	vscode.call("workbench.action.nextEditor")
end)
vim.keymap.set("n", "<leader>a", "<cmd>A<cr>")
