--  [[ Global ]]
--  Set <leader> to space
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("custom.options")
require("custom.keymaps")
require("custom.autocommands")

-- [[ Lazy.nvim setup ]]
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

-- [[ Plugins ]]
require("lazy").setup({
	"tpope/vim-sleuth",
	"tpope/vim-repeat",
	"tpope/vim-abolish",
	"tpope/vim-surround",
	"tjdevries/cyclist.vim",
	"folke/lsp-colors.nvim",
	"folke/tokyonight.nvim",
	"farmergreg/vim-lastplace",
	{ "numToStr/Comment.nvim", opts = {} },
	{ "lewis6991/gitsigns.nvim", config = true },
	{ "folke/which-key.nvim", event = "VeryLazy", config = true },
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	{ "inkarkat/vim-AdvancedSorters", dependencies = "inkarkat/vim-ingo-library" },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },

	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = {
				async = true,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				json = { "prettierd" },
				jsonc = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				lua = { "stylua" },
				markdown = { "prettierd" },
				["markdown.mdx"] = { "prettier" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				vue = { "prettier" },
				scss = { "prettier" },
				less = { "prettier" },
				yaml = { "prettier" },
				graphql = { "prettier" },
				handlebars = { "prettier" },
				["*"] = { "trim_whitespace", "trim_newlines" },
			},
		},
	},

	{
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]parenthen
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			require("mini.statusline").setup()
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"html",
					"lua",
					"markdown",
					"vim",
					"vimdoc",
					"javascript",
					"typescript",
					"tsx",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see :help nvim-treesitter-incremental-selection-mod
			--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		end,
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
		"folke/persistence.nvim",
		event = "BufReadPre",
		config = true,
		init = function()
			vim.keymap.set("n", "<leader>S", require("persistence").load, { desc = "Restore session" })
		end,
	},

	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			popup_border_style = "rounded",
			window = {
				position = "float",
				mappings = { ["<leader>e"] = "cancel" },
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		},
		init = function()
			vim.keymap.set("n", "<leader>e", "<cmd>Neotree reveal<cr>", { desc = "Explorer" })
		end,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = { "<leader>mm", "<leader>ma", "<leader>ms", "<leader>md", "<leader>mf", "<leader><leader>" },
		init = function()
			local harpoon = require("harpoon")
			-- stylua: ignore start
			vim.keymap.set("n", "<leader>mm", function() harpoon:list():append() end, { desc = "Mark file" })
			vim.keymap.set("n", "<leader>ma", function() harpoon:list():select(1) end, { desc = "Go to mark 1" })
			vim.keymap.set("n", "<leader>ms", function() harpoon:list():select(2) end, { desc = "Go to mark 1" })
			vim.keymap.set("n", "<leader>md", function() harpoon:list():select(3) end, { desc = "Go to mark 1" })
			vim.keymap.set("n", "<leader>mf", function() harpoon:list():select(4) end, { desc = "Go to mark 1" })
			vim.keymap.set("n", "<leader><leader>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Marks menu" })
			-- stylua: ignore end
		end,
	},

	-- My own plugins
	{
		"olrtg/nvim-i18n",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		config = true,
		dev = true,
	},

	{ import = "custom.plugins" },
}, { dev = { path = "~/i" } })
