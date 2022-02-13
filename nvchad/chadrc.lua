local M = {}

local plugin_conf = require "custom.plugins.configs"
local user_plugins = require "custom.plugins"

M.plugins = {
   status = {
      dashboard = true,
      colorizer = true,
   },

   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },

   default_plugin_config_replace = {
      nvim_treesitter = plugin_conf.treesitter,
      nvim_tree = plugin_conf.nvimtree,
   },

   install = user_plugins,
}

M.ui = {
   theme = "gruvbox",
   transparency = true,
}

M.options = {
  relativenumber = true,
}

return M
