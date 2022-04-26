require("olrtg.plugins.bufferline").config()

lvim.plugins = {
	{ "shaunsingh/nord.nvim" },
	{ "nvim-telescope/telescope-fzy-native.nvim" },
	{ "ThePrimeagen/git-worktree.nvim" },
	{ "tjdevries/cyclist.vim" },
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
			require("colorizer").setup({ "*" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},

	{
		"ThePrimeagen/harpoon",
		config = function()
			require("olrtg.plugins.harpoon").config()
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
