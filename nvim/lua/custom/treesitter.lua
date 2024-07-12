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
