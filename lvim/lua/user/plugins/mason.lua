local api = require("user.utils.api")

local tools = require("user.utils.states").mason_ensure_installed

api.install_plugins({
  { "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = tools } },
})
