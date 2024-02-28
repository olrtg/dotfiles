local api = require("custom.api")

api.install_tools({ "dockerfile-language-server", "hadolint" })

api.install_parsers({ "dockerfile" })

-- api.setup_linters({
-- 	{ command = "hadolint" },
-- })
