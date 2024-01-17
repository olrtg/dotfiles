-- NOTE:
-- This are plugin customizations over the defaults of LazyVim
return {
  { "folke/tokyonight.nvim", opts = { style = "night" } },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      popup_border_style = "rounded",
      window = {
        position = "float",
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
}
