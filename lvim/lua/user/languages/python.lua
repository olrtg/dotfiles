local api = require("user.utils.api")

api.install_tools({ "black", "flake8", "pyright" })

api.install_parsers({ "python" })

api.setup_formatters({
  { command = "black" },
})

api.setup_linters({
  { command = "flake8" },
})
