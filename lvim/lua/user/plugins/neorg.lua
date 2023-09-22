local api = require("user.utils.api")

api.install_plugins({
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            default_workspace = "notes",
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
          ["core.journal"] = { config = { workspace = "notes" } },
          ["core.completion"] = { config = { engine = "nvim-cmp" } },
        },
      })
    end,
  },
})
