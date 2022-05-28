lvim.builtin.which_key.mappings["/"] = { '<cmd>let @/=""<cr>', "No Highlight" }

-- https://github.com/ThePrimeagen/refactoring.nvim
lvim.builtin.which_key.vmappings["r"] = {
	name = "Refactor",
	e = { "<Esc><cmd>lua require('refactoring').refactor('Extract Function')<cr>", "Extract function" },
	f = {
		"<Esc><cmd>lua require('refactoring').refactor('Extract Function To File')<cr>",
		"Extract function to file",
	},
	v = { "<Esc><cmd>lua require('refactoring').refactor('Extract Variable')<cr>", "Extract variable" },
	m = { "<Esc><cmd>lua require('refactoring').refactor('Inline Variable')<cr>", "Inline variable" },
}

lvim.builtin.which_key.mappings["r"] = {
	name = "Refactor",
	b = { "<cmd>lua require('refactoring').refactor('Extract Block')<cr>", "Extract block" },
	f = { "<cmd>lua require('refactoring').refactor('Extract Block To File')<cr>", "Extract block to file" },
	i = { "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>", "Inline variable" },
}

-- https://github.com/ThePrimeagen/harpoon
lvim.builtin.which_key.mappings["h"] = {
	name = "Harpoon",
	a = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Navigate to file 1" },
	s = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Navigate to file 2" },
	d = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Navigate to file 3" },
	f = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Navigate to file 4" },
	h = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add file" },
	u = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle UI" },
}

-- https://github.com/ThePrimeagen/git-worktree.nvim
lvim.builtin.which_key.mappings["W"] = {
	name = "Worktree",
	s = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", "Switch/Delete" },
	c = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", "Create" },
}

-- https://github.com/folke/persistence.nvim
lvim.builtin.which_key.mappings["S"] = {
	name = "Session",
	c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

-- https://github.com/benfowler/telescope-luasnip.nvim
lvim.builtin.which_key.mappings["s"]["s"] = { "<cmd>Telescope luasnip<cr>", "Snippets" }
