local api = require("user.utils.api")

api.install_plugins({
  { "zbirenbaum/copilot.lua" },
})

--
-- copilot.lua
--
api.setup_plugin("copilot", {
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
