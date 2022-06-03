lvim.plugins = {
	-- Themes
	{ "sainnhe/everforest" },

	-- Telescope
	{ "nvim-telescope/telescope-fzy-native.nvim" },

	{
		"benfowler/telescope-luasnip.nvim",
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("luasnip")
		end,
	},

	-- LSP
	{
		"ThePrimeagen/refactoring.nvim",
		event = "BufRead",
		requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("refactoring").setup({})
		end,
	},

	-- { "github/copilot.vim" },

	{
		"zbirenbaum/copilot.lua",
		event = { "VimEnter" },
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
				})
			end, 100)
		end,
	},

	{ "zbirenbaum/copilot-cmp", after = { "copilot.lua", "nvim-cmp" } },

	-- Treesitter
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
		end,
		requires = "nvim-treesitter/nvim-treesitter",
		tag = "*",
	},

	{ "mtdl9/vim-log-highlighting" },

	{ "p00f/nvim-ts-rainbow" },

	-- Git
	{
		"ThePrimeagen/git-worktree.nvim",
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("git_worktree")
		end,
	},

	-- Navigation
	{
		"ThePrimeagen/harpoon",
		event = "BufWinEnter",
		requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
		config = function()
			require("olrtg.plugins.harpoon").config()
		end,
	},

	{
		"nacro90/numb.nvim",
		event = "BufRead",
		config = function()
			require("olrtg.plugins.numb").config()
		end,
	},

	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("olrtg.plugins.lastplace")
		end,
	},

	-- Misc
	{ "tjdevries/cyclist.vim" },

	{
		"tpope/vim-surround",
		keys = { "c", "d", "y", "S" },
	},

	{
		"felipec/vim-sanegx",
		event = "BufRead",
	},

	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
				options = { "buffers", "curdir", "tabpages", "winsize" },
			})
		end,
	},
}

table.insert(lvim.builtin.cmp.sources, { name = "copilot", group_index = 0 })
