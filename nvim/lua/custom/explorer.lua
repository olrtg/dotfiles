require("oil").setup({
	float = {
		border = "rounded",
		max_width = 60,
		max_height = 25,
		win_options = {
			winhighlight = "NormalFloat:Background",
		},
	},
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
	},
	keymaps = {
		["<Esc>"] = "actions.close",
		["q"] = "actions.close",
		["<leader>e"] = "actions.close",
	},
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "",
	pattern = "oil",
	callback = function()
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "Background" })
	end,
})
