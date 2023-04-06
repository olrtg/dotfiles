local api = require("user.utils.api")

api.install_plugins({
  { "zbirenbaum/copilot.lua", cmd = "Copilot", build = ":Copilot auth" },
})

--
-- copilot.lua
--
api.setup_plugin("copilot", {
  plugin_manager_path = os.getenv("LUNARVIM_RUNTIME_DIR") .. "/site/pack/packer",
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = "<M-Enter>",
      accept_line = "<M-l>",
      accept_word = "<M-w>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<M-c>",
    },
  },
})
