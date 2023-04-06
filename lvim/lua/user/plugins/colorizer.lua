local api = require("user.utils.api")

api.install_plugins({
  { "NvChad/nvim-colorizer.lua" },
})

--
-- nvim-colorizer.lua
--
api.setup_plugin("colorizer", {
  filetypes = {
    "*",
    "!mason",
    "!toggleterm",
  },
  user_default_options = {
    RRGGBBAA = true,
    AARRGGBB = true,
    css_fn = true,
    tailwind = true,
    always_update = true,
  },
})
