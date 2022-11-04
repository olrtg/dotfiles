vim.keymap.set("i", "jk", "<ESC>", { silent = true })

lvim.keys.normal_mode["<C-a>"] = "ggVG"
lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<cr>"

lvim.builtin.which_key.vmappings["s"] = {
  [["sy:let @/=@s<CR>cgn]],
  "Search/Replace",
}

lvim.builtin.which_key.vmappings["l"] = {
  name = "LSP",
  a = { "<Esc><cmd>lua vim.lsp.buf.range_code_action()<cr>", "Code Action" },
}

lvim.builtin.which_key.mappings["/"] = { '<cmd>let @/=""<cr>', "No Highlight" }
lvim.builtin.which_key.mappings["gy"] = { "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>", "Gitlinker" }
lvim.builtin.which_key.mappings["K"] = { "<cmd>edit ~/.config/kitty/kitty.conf<cr>", "Kitty conf" }

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

-- https://github.com/danymat/neogen
lvim.builtin.which_key.mappings["a"] = {
  name = "Annotations",
  c = { "<cmd>lua require('neogen').generate({ type = 'class'})<CR>", "Class Documentation" },
  f = { "<cmd>lua require('neogen').generate({ type = 'func'})<CR>", "Function Documentation" },
  t = { "<cmd>lua require('neogen').generate({ type = 'type'})<CR>", "Type Documentation" },
  F = { "<cmd>lua require('neogen').generate({ type = 'file'})<CR>", "File Documentation" },
}
