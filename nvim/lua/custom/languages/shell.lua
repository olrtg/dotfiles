-- NOTE: This is a config file for shell related languages like shell/bash/zsh and others.

local api = require("custom.api")

api.install_tools({ "bash-language-server", "shellcheck", "shfmt" })

api.install_parsers({ "bash" })

-- api.setup_formatters({
-- 	{ command = "shfmt" },
-- })
--
-- api.setup_linters({
-- 	{ command = "shellcheck" },
-- })
--
-- api.setup_code_actions({
-- 	{ command = "shellcheck" },
-- })
