require("plugins.lualine").config()
require("plugins.bufferline").config()

lvim.plugins = {
	{ "ellisonleao/gruvbox.nvim" },
	{ "mvpopuk/inspired-github.vim" },
	{ "b0o/schemastore.nvim" },
	{ "nvim-telescope/telescope-fzy-native.nvim" },
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
}
