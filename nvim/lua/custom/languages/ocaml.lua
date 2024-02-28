local api = require("custom.api")

api.install_parsers({ "ocaml" })

api.install_tools({ "ocaml-lsp", "ocamlformat" })

-- api.setup_formatters({ { command = "ocamlformat" } })
