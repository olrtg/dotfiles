vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
	print("Installing lazy.nvim....")
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
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "L3MON4D3/LuaSnip" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "rafamadriz/friendly-snippets" },
	{ "folke/neodev.nvim", opts = {} },
	{ "tpope/vim-sleuth" },

	{ "b0o/schemastore.nvim" },

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "windwp/nvim-ts-autotag" },
		build = ":TSUpdate",
		config = function()
			require("custom.treesitter")
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("custom.statusline")
		end,
	},

	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		lazy = false,
		config = true,
		init = function()
			require("onedark").load()
		end,
	},

	{
		"stevearc/conform.nvim",
		config = function()
			require("custom.formatter")
		end,
	},

	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		keys = {
			{ "-", "<cmd>Oil --float<cr>", mode = { "n" } },
			{ "<leader>e", "<cmd>Oil --float<cr>", mode = { "n" } },
		},
		config = function()
			require("custom.explorer")
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},

	{
		-- NOTE: until https://github.com/pmizio/typescript-tools.nvim/pull/267 is merged
		-- "pmizio/typescript-tools.nvim",
		"notomo/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	},

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("custom.search")
		end,
	},

	{
		"benfowler/telescope-luasnip.nvim",
		after = "telescope.nvim",
		keys = { "<leader>fs" },
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "󰐊" },
				topdelete = { text = "󰐊" },
				changedelete = { text = "󰐊" },
				untracked = { text = "▎" },
			},
		},
	},

	{
		"supermaven-inc/supermaven-nvim",
		opts = {},
	},

	{
		"olrtg/nvim-emmet",
		dev = true,
		config = function()
			vim.keymap.set({ "n", "v" }, "<leader>ce", require("nvim-emmet").wrap_with_abbreviation)
		end,
	},
}, { dev = { path = "~/i" } })

require("custom.lsp")
require("custom.completion")
