local api = require("user.utils.api")

api.override_servers({ "jdtls" })

api.install_tools({ "java-debug-adapter", "java-test" })

api.install_plugins({
  "mfussenegger/nvim-jdtls",
})

-- api.setup_formatters({ command = "google_java_format" })

api.install_parsers({ "java" })
