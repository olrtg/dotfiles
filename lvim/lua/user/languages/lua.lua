local api = require("user.utils.api")

api.install_tools({ "lua-language-server", "stylua" })

api.install_parsers({ "lua" })

api.setup_formatters({
  { command = "stylua" },
})
