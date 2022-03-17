-- Which-key: +Harpoon
lvim.builtin.which_key.mappings["h"] = {
	name = "+Harpoon",
	a = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Navigate to file 1" },
	s = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Navigate to file 2" },
	d = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Navigate to file 3" },
	f = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Navigate to file 4" },
	h = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add file" },
	u = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle UI" },
}
