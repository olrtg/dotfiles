local api = require("user.utils.api")

api.install_plugins({
  -- { "NvChad/nvim-colorizer.lua" },
  -- NOTE: until https://github.com/NvChad/nvim-colorizer.lua/pull/63 is merged
  {
    "mehalter/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "*",
        "!lazy",
        "!mason",
        "!neo-tree",
        "!toggleterm",
        "!TelescopePrompt",
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
    },
  },
})
