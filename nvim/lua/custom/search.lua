local builtin = require("telescope.builtin")
local command = require("telescope.command")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

require("telescope").load_extension("luasnip")

vim.keymap.set("n", "<leader>fs", function()
	command.load_command("luasnip")
end)
