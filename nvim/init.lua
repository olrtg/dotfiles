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
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },

	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"L3MON4D3/LuaSnip",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",
	"b0o/schemastore.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-treesitter/nvim-treesitter-context",
	"JoosepAlviste/nvim-ts-context-commentstring",

	"mfussenegger/nvim-dap",
	"jay-babu/mason-nvim-dap.nvim",
	"theHamsta/nvim-dap-virtual-text",
	{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },

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

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = {
					-- Set not show a message if hover is not available
					-- ex: shift+k on Java code
					silent = true,
				},
			},
			presets = { long_message_to_split = true },
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},

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
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function() require("custom.statusline") end,
	},

	{
		"navarasu/onedark.nvim",
		priority = 1000,
		lazy = false,
		config = true,
		init = function() require("onedark").load() end,
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
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	},

	{
		"nvim-java/nvim-java",
		dependencies = {
			"nvim-java/lua-async-await",
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-dap",
			"nvim-java/nvim-java-refactor",
			"MunifTanjim/nui.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			"JavaHello/spring-boot.nvim",
			{
				"williamboman/mason.nvim",
				opts = {
					registries = {
						"github:nvim-java/mason-registry",
						"github:mason-org/mason-registry",
					},
				},
			},
		},
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

	{ "supermaven-inc/supermaven-nvim", opts = {} },

	-- {
	-- 	"tree-sitter-grammars/tree-sitter-test",
	-- 	build = "make parser/test.so",
	-- 	ft = "test",
	-- 	init = function()
	-- 		-- toggle dynamic language injection
	-- 		vim.g.tstest_dynamic_injection = false
	-- 		-- toggle full-width rules for test separators
	-- 		vim.g.tstest_fullwidth_rules = false
	-- 		-- set the highlight group of the rules
	-- 		vim.g.tstest_rule_hlgroup = "FoldColumn"
	-- 	end,
	-- },

	{
		"tpope/vim-sleuth",
		-- Disable for java projects
		cond = vim.fn.filereadable(vim.fn.getcwd() .. "/pom.xml") == 0,
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
}, { dev = { path = "~/i" } })

require("custom.lsp")
require("custom.completion")
require("custom.dap")
