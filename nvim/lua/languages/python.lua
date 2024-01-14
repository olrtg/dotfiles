local x = require("x")

x.install_tools({ "black", "flake8", "pyright" })

x.install_parsers({ "python" })

x.setup_formatters({ { command = "black" } })

x.setup_linters({
	{ command = "flake8", args = { "--ignore=E501" } },
})
