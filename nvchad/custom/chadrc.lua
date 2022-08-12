local M = {}
local override = require("custom.override")

M.plugins = {
  override = {
    ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
    ["williamboman/mason.nvim"] = override.mason,
  },

  user = require("custom.plugins"),
}

M.ui = {
  theme = "everforest",
  theme_toggle = { "everforest", "everforest_light" },
}

M.mappings = require("custom.mappings")

return M
