local x = require("x")

x.install_tools({ "lua-language-server", "stylua" })
x.install_parsers({ "lua" })
x.setup_formatters({ { command = "stylua" } })
