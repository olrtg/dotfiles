return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim", "benfowler/telescope-luasnip.nvim" },
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

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

			telescope.load_extension("luasnip")
			vim.keymap.set("n", "<leader>ss", telescope.extensions.luasnip.luasnip)

			vim.keymap.set("n", "<leader>sd", builtin.diagnostics)
			vim.keymap.set("n", "<leader>sf", builtin.find_files)
			vim.keymap.set("n", "<leader>st", builtin.live_grep)
			vim.keymap.set("n", "<leader>sh", builtin.help_tags)
			vim.keymap.set("n", "<leader>sk", builtin.keymaps)
			vim.keymap.set("n", "<leader>sr", builtin.resume)
		end,
	},
}
