local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local command = require("telescope.command")

telescope.setup({
	defaults = {
		mappings = {
			n = { ["q"] = actions.close },
		},
	},

	pickers = {
		help_tags = {
			mappings = {
				i = { ["<cr>"] = actions.select_vertical },
				n = { ["<cr>"] = actions.select_vertical },
			},
		},
	},
})

vim.keymap.set("n", "<leader>f", builtin.git_files, {})
vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
vim.keymap.set("n", "<leader>st", builtin.live_grep, {})
vim.keymap.set("n", "<leader>sh", builtin.help_tags, {})

telescope.load_extension("luasnip")

vim.keymap.set("n", "<leader>ss", function()
	command.load_command("luasnip")
end)
