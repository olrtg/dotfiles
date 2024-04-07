vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { eol = "↵", nbsp = "◇", tab = "→ ", trail = "⋅" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.shortmess = "I"

vim.keymap.set("i", "jk", "<Esc>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require("autocmds")
require("winbar")

require("lazy").setup({
	"tpope/vim-sleuth",

	{ "williamboman/mason.nvim", config = true },

	{
		"stevearc/oil.nvim",
		opts = {
			view_options = { show_hidden = true },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{ "stevearc/dressing.nvim", opts = {} },

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			vim.g.skip_ts_context_commentstring_module = true
			require("Comment").setup({
				pre_hook = function()
					return vim.bo.commentstring
				end,
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				markdown = { "prettierd" },
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				json = { "prettierd" },
				shell = { "shfmt" },
			},
		},
	},

	{ "lewis6991/gitsigns.nvim", config = true },

	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},

	{ "kylechui/nvim-surround", version = "*", event = "VeryLazy", config = true },

	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{
		"navarasu/onedark.nvim",
		priority = 1000,
		lazy = false,
		config = true,
		init = function()
			require("onedark").load()
		end,
	},

	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},

	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = {
			{ "<leader>cj", "<cmd>TSJToggle<cr>", desc = "Join/split code block" },
		},
		opts = { use_default_keymaps = false },
	},

	{
		"chrisgrieser/nvim-various-textobjs",
		lazy = false,
		opts = { useDefaultKeymaps = true, disabledKeymaps = { "gc" } },
		init = function()
			-- INFO: uncomment the rest of the comment using `gcgc`
			vim.keymap.set({ "o" }, "gc", require("various-textobjs").multiCommentedLines)
		end,
	},

	{
		"olrtg/nvim-i18n",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		config = true,
		dev = true,
	},

	{ import = "plugins" },
}, { dev = { path = "~/i" } })
