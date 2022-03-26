require("plugins.bufferline").config()

lvim.plugins = {
	{ "shaunsingh/nord.nvim" },
	{ "mvpopuk/inspired-github.vim" },
	{ "b0o/schemastore.nvim" },
	{ "nvim-telescope/telescope-fzy-native.nvim" },
	{ "ThePrimeagen/git-worktree.nvim" },
	-- {
	-- 	"~/projects/open-source/telescope-luasnip.nvim",
	-- 	config = function()
	-- 		require("telescope").load_extension("snippets")
	-- 	end,
	-- },

	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{
		"tpope/vim-surround",
		keys = { "c", "d", "y", "S" },
	},

	{
		"felipec/vim-sanegx",
		event = "BufRead",
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("plugins.colorizer")
		end,
	},

	{
		"ThePrimeagen/harpoon",
		config = function()
			require("plugins.harpoon").config()
		end,
		event = "BufWinEnter",
		requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
	},

	{
		"nacro90/numb.nvim",
		event = "BufRead",
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			})
		end,
	},

	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
}

require("telescope").load_extension("git_worktree")
