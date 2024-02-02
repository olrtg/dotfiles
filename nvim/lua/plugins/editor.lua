return {
  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },

  { "dmmulroy/tsc.nvim", config = true },

  {
    "ThePrimeagen/harpoon",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("harpoon").setup()
      lvim.builtin.which_key.mappings["m"] = {
        name = "Harpoon",
        m = { require("harpoon.mark").add_file, "Mark File" },
        a = { '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', "Go to Mark 1" },
        s = { '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', "Go to Mark 2" },
        d = { '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', "Go to Mark 3" },
        f = { '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', "Go to Mark 4" },
      }
      lvim.builtin.which_key.mappings["<leader>"] = { require("harpoon.ui").toggle_quick_menu, "Marks Menu" }
    end,
  },
}
