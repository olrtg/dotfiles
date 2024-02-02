local api = require("user.utils.api")

api.install_plugins({
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup()
      lvim.builtin.which_key.mappings["S"] = { '<cmd>lua require("persistence").load()<cr>', "Last session" }
    end,
  },
})
