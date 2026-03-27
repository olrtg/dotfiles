vim.g.mapleader = " "

local lazy = vim.fn.stdpath("data") .. "/lazy"
local lazypath = lazy .. "/lazy.nvim"

-- Auto-install lazy.nvim if not present
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

require("lazy").setup({
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"rafamadriz/friendly-snippets",
	"b0o/schemastore.nvim",
	"nvim-treesitter/nvim-treesitter-context",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"tpope/vim-sleuth",
	"RRethy/nvim-treesitter-endwise",

	{ "nvim-tree/nvim-web-devicons", opts = {} },

	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "normal",
			},
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		},
	},

	{ "echasnovski/mini.statusline", version = "*", opts = {} },

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "windwp/nvim-ts-autotag" },
		lazy = false,
		build = ":TSUpdate",
		config = function() require("custom.treesitter") end,
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

	{
		"navarasu/onedark.nvim",
		priority = 1000,
		lazy = false,
		opts = { style = "dark" },
		init = function()
			vim.o.background = "dark"
			require("onedark").load()
		end,
	},

	{
		"stevearc/conform.nvim",
		config = function() require("custom.formatter") end,
	},

	{
		"mfussenegger/nvim-lint",
		config = function() require("custom.linter") end,
	},

	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			explorer = { enabled = true },
			notifier = { enabled = true },
		},
		keys = {
			{ "<leader>gg", function() Snacks.lazygit() end },
			{ "<leader>f", function() Snacks.picker.files() end },
			{ "<leader>st", function() Snacks.picker.grep() end },
			{ "<leader>sh", function() Snacks.picker.help() end },
			{ "<leader>ld", function() Snacks.picker.diagnostics_buffer() end },
			{ "<leader>lD", function() Snacks.picker.diagnostics() end },
			{ "<leader><space>", function() Snacks.picker.resume() end },
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			vim.keymap.set("n", "[h", function() gitsigns.nav_hunk("prev") end)
			vim.keymap.set("n", "]h", function() gitsigns.nav_hunk("next") end)
			vim.keymap.set("n", "<leader>hR", gitsigns.reset_hunk)
			vim.keymap.set("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end)
		end,
	},

	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		keys = {
			{ "-", "<cmd>Oil --float<cr>", mode = { "n" } },
			{ "<leader>e", "<cmd>Oil --float<cr>", mode = { "n" } },
		},
		config = function() require("custom.explorer") end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"olrtg/nvim-copy-deep-path",
		dev = false,
		cmd = "CopyDeepPath",
		config = true,
	},
}, { dev = { path = "~/d" } })

require("custom.lsp")
