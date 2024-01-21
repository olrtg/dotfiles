return {
  -- Plugin setup
  {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    opts = { enable_cody = true, accept_tos = true },
  },

  -- Add cmp source
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "sourcegraph/sg.nvim" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "cody" })
    end,
  },
}
