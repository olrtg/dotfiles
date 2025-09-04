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
	"nvim-lua/plenary.nvim",
	"nvim-treesitter/nvim-treesitter-context",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"tpope/vim-sleuth",

	"mfussenegger/nvim-dap",
	"jay-babu/mason-nvim-dap.nvim",
	"theHamsta/nvim-dap-virtual-text",
	{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },

	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "v0.*",
		cond = not vim.g.forcing_myself_to_learn,

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default" },
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
		ft = "lua", -- only load on lua files
		dependencies = {
			{ "Bilal2453/luvit-meta", lazy = true }, -- `vim.uv` typings
			{ "LuaCATS/busted", lazy = true }, -- testing typings
		},
		opts = {
			library = {
				lazy .. "/luvit-meta/library",
				lazy .. "/busted/library",
			},
		},
	},

	{ "echasnovski/mini.statusline", version = "*", opts = {} },
	{ "stevearc/dressing.nvim", opts = {} },

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "windwp/nvim-ts-autotag" },
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
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function() require("custom.search") end,
	},

	{
		"benfowler/telescope-luasnip.nvim",
		after = "telescope.nvim",
		keys = { "<leader>ss" },
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

	{ "supermaven-inc/supermaven-nvim", opts = {}, cond = not vim.g.forcing_myself_to_learn },

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
		dev = true,
	},

	{
		"olrtg/nvim-i18n",
		dev = true,
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		config = true,
	},

	{
		"olrtg/nvim-emmet",
		dev = true,
		config = function() vim.keymap.set({ "n", "v" }, "<leader>ce", require("nvim-emmet").wrap_with_abbreviation) end,
	},

	{
		"olrtg/nvim-copy-deep-path",
		dev = true,
		config = true,
	},
	---@diagnostic disable-next-line: missing-fields
}, { dev = { path = "~/d" } })

require("custom.lsp")
require("custom.dap")
