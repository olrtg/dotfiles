local api = require("user.utils.api")

api.install_plugins({
  { "WhoIsSethDaniel/mason-tool-installer.nvim" },
})

--
-- mason-tool-installer.nvim
--
local tools = require("user.utils.states").mason_ensure_installed

api.setup_plugin("mason-tool-installer", { ensure_installed = tools })
