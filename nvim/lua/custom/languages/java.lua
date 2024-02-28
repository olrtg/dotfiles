local api = require("custom.api")

api.install_tools({ "java-debug-adapter", "java-test" })

api.install_plugins({
	"mfussenegger/nvim-jdtls",
})

-- api.setup_formatters({ command = "google_java_format" })

api.install_parsers({ "java" })
