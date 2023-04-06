local api = require("user.utils.api")

api.install_plugins({
  { "almo7aya/openingh.nvim" },
})

--
-- openingh.nvim
--
api.setup_plugin("openingh", nil, function(openingh)
  lvim.builtin.which_key.mappings["g"]["r"] = { "<cmd>OpenInGHRepo<cr>", "Open Repo (GH)" }
  lvim.builtin.which_key.mappings["g"]["f"] = { "<cmd>OpenInGHFile<cr>", "Open File (GH)" }
end)
