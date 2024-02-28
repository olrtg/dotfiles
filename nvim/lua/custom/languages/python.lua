local api = require("custom.api")

api.install_tools({ "black", "flake8", "pyright" })

api.install_parsers({ "ninja", "python", "requirements", "rst" })

-- api.setup_formatters({
-- 	{ command = "black" },
-- })
--
-- api.setup_linters({
-- 	{ command = "flake8", args = { "--ignore=E501" } },
-- })
