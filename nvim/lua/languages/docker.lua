local x = require("x")

x.install_tools({ "dockerfile-language-server", "hadolint" })
x.install_parsers({ "dockerfile" })
x.setup_linters({ { command = "hadolint" } })
