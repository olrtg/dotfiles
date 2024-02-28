local api = require("custom.api")

api.install_tools({ "lua-language-server", "stylua" })

api.install_parsers({ "lua" })

-- api.setup_formatters({
-- 	{ command = "stylua" },
-- })
