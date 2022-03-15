lvim.plugins = {
	{ "ellisonleao/gruvbox.nvim" },
	{ "mvpopuk/inspired-github.vim" },
	{ "b0o/schemastore.nvim" },

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
}
