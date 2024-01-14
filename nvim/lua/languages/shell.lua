-- NOTE: This is a config file for shell related languages like shell/bash/zsh and others.

local x = require("x")

x.install_tools({ "bash-language-server", "shellcheck", "shfmt" })

x.install_parsers({ "bash" })

x.setup_formatters({
	{ command = "shfmt" },
})

x.setup_linters({
	{ command = "shellcheck" },
})

x.setup_code_actions({
	{ command = "shellcheck" },
})
