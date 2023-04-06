local api = require("user.utils.api")

api.install_tools({ "dockerfile-language-server", "hadolint" })

api.install_parsers({ "dockerfile" })

api.setup_linters({
  { command = "hadolint" },
})
