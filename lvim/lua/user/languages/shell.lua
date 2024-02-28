-- NOTE: This is a config file for shell related languages like shell/bash/zsh and others.

local api = require("user.utils.api")

api.install_tools({ "bash-language-server", "shellcheck", "shfmt" })

api.install_parsers({ "bash" })

api.setup_formatters({
  { command = "shfmt" },
})
