local api = require("user.utils.api")

api.override_servers({ "jdtls" })

-- api.install_tools({ "google-java-format" })

api.install_plugins({
  "mfussenegger/nvim-jdtls",
})

-- api.setup_formatters({ command = "google_java_format" })

api.install_parsers({ "java" })
