local x = require("x")

x.install_parsers({ "ocaml" })

x.install_tools({ "ocaml-lsp", "ocamlformat" })

x.setup_formatters({ { command = "ocamlformat" } })
