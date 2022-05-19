lvim.builtin.which_key.mappings["/"] = { '<cmd>let @/=""<cr>', "No Highlight" }

lvim.builtin.which_key.mappings["h"] = {
	name = "+Harpoon",
	a = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Navigate to file 1" },
	s = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Navigate to file 2" },
	d = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Navigate to file 3" },
	f = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Navigate to file 4" },
	h = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add file" },
	u = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle UI" },
}

lvim.builtin.which_key.mappings["W"] = {
	name = "+Worktree",
	s = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", "Switch/Delete" },
	c = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", "Create" },
}

lvim.builtin.which_key.mappings["t"] = {
	name = "Diagnostics",
	t = { "<cmd>TroubleToggle<cr>", "trouble" },
	w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace" },
	d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document" },
	q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
	l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
	r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

lvim.builtin.which_key.mappings["S"] = {
	name = "Session",
	c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}
