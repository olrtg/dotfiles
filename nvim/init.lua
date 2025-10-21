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

vim.g.forcing_myself_to_learn = false

require("lazy").setup({
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"rafamadriz/friendly-snippets",
	"b0o/schemastore.nvim",
	"nvim-treesitter/nvim-treesitter-context",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"NMAC427/guess-indent.nvim",

	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "1.*",
		cond = not vim.g.forcing_myself_to_learn,

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
		cond = not vim.g.forcing_myself_to_learn,
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
			{ "<leader>e", function() Snacks.explorer({ layout = { layout = { position = "right" } } }) end },
			{ "<leader>gg", function() Snacks.lazygit() end },

			{ "<leader>f", function() Snacks.picker.files() end },
			{ "<leader>st", function() Snacks.picker.grep() end },
			{ "<leader>sh", function() Snacks.picker.help() end },
			{ "<leader>ld", function() Snacks.picker.diagnostics_buffer() end },
			{ "<leader>lD", function() Snacks.picker.diagnostics() end },
			{ "<leader>r", function() Snacks.picker.resume() end },
		},
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
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end },
			{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end },
			{ "r", mode = "o", function() require("flash").remote() end },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end },
		},
	},

	{
		"olrtg/nvim-rename-state",
		ft = { "javascript", "javascriptreact", "typescriptreact" },
		dev = false,
	},

	{
		"olrtg/nvim-i18n",
		dev = false,
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		config = true,
	},

	{
		"olrtg/nvim-emmet",
		dev = false,
		config = function() vim.keymap.set({ "n", "v" }, "<leader>ce", require("nvim-emmet").wrap_with_abbreviation) end,
	},

	{
		"olrtg/nvim-copy-deep-path",
		dev = false,
		config = true,
	},
}, { dev = { path = "~/d" } })

require("custom.lsp")
