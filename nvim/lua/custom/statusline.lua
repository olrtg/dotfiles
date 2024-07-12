-- NOTE: A tweaked version of:
-- https://github.com/nvim-lualine/lualine.nvim/blob/0a5a66803c7407767b799067986b4dc3036e1983/examples/bubbles.lua
require("lualine").setup({
	options = {
		component_separators = "",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { { "mode", separator = { left = "" } } },
		lualine_b = { "filename", "branch" },
		lualine_c = {},
		lualine_x = {
			{
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = { fg = "#ff9e64" },
			},
		},
		lualine_y = { "filetype", "progress" },
		lualine_z = {
			{ "location", separator = { right = "" } },
		},
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
})
