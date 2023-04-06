local api = require("user.utils.api")

api.install_plugins({
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
  },
})

--
-- persistence.nvim
--
api.setup_plugin("persistence")

lvim.builtin.which_key.mappings["S"] = { '<cmd>lua require("persistence").load()<cr>', "Last session" }
