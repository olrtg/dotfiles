---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<cr>",
			node_incremental = "<cr>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
})

require("nvim-ts-autotag").setup()

do
	require("treesitter-context").setup({
		max_lines = 4,
		multiline_threshold = 1,
		min_window_height = 20,
	})

	vim.keymap.set("n", "[c", require("treesitter-context").go_to_context)
end

do -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#native-commenting-in-neovim-010
	local get_option = vim.filetype.get_option
	---@diagnostic disable-next-line: duplicate-set-field
	vim.filetype.get_option = function(filetype, option)
		return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
			or get_option(filetype, option)
	end
end
