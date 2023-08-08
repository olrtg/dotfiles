local api = require("user.utils.api")

api.install_plugins({
  -- { "NvChad/nvim-colorizer.lua" },
  { "mehalter/nvim-colorizer.lua" }, -- NOTE: until https://github.com/NvChad/nvim-colorizer.lua/pull/63 is merged
})

--
-- nvim-colorizer.lua
--
api.setup_plugin("colorizer", {
  filetypes = {
    "*",
    "!mason",
    "!toggleterm",
    "!TelescopePrompt",
    "!lazy",
  },
  user_default_options = {
    names = false,
    RRGGBBAA = true,
    AARRGGBB = true,
    css_fn = true,
    tailwind = true,
    mode = "inline",
    virtualtext = " ■",
  },
})
