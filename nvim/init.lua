require("vim._core.ui2").enable({})

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
	"tpope/vim-sleuth",
	"RRethy/nvim-treesitter-endwise",

	{ "nvim-tree/nvim-web-devicons", opts = {} },

	{ "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },

	{
		-- This plugin doesn't really need lazy loading so I'm not going to force it
		-- https://github.com/windwp/nvim-ts-autotag#a-note-on-lazy-loading
		"windwp/nvim-ts-autotag",
		opts = {},
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#native-commenting-in-neovim-010
			require("ts_context_commentstring").setup({ enable_autocmd = false })
			local get_option = vim.filetype.get_option
			---@diagnostic disable-next-line: duplicate-set-field
			vim.filetype.get_option = function(filetype, option)
				if option == "commentstring" then
					local expr = require("ts_context_commentstring.internal").calculate_commentstring()
					vim.print(expr)
					return expr
				else
					return get_option(filetype, option)
				end
			end
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			local plugin = require("treesitter-context")
			plugin.setup({
				max_lines = 4,
				multiline_threshold = 1,
				min_window_height = 20,
			})
			vim.keymap.set("n", "[c", plugin.go_to_context)
		end,
	},

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
			completion = { menu = { auto_show = false } },
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
		opts = {
			format_on_save = {
				timeout_ms = 5000,
				lsp_format = "fallback",
			},
			formatters = {
				prettier = {
					require_cwd = true,
				},
				sqlfluff = {
					args = { "fix", "--dialect=postgres", "-" },
				},
			},
			formatters_by_ft = {
				["lua"] = { "stylua" },
				["go"] = { "goimports", "gofumpt" },
				["sh"] = { "shfmt" },
				["sql"] = { "sqlfluff" },

				["html"] = { "prettier" },
				["css"] = { "prettier" },
				["less"] = { "prettier" },
				["sass"] = { "prettier" },
				["scss"] = { "prettier" },
				["javascript"] = { "prettier" },
				["javascriptreact"] = { "prettier" },
				["typescript"] = { "prettier" },
				["typescriptreact"] = { "prettier" },
				["json"] = { "prettier" },
				["jsonc"] = { "prettier" },
				["yaml"] = { "prettier" },
				["markdown"] = { "prettier" },
				["markdown.mdx"] = { "prettier" },
				["grahpql"] = { "prettier" },
				["vue"] = { "prettier" },
			},
		},
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
			vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk_inline)
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
