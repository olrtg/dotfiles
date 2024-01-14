local x = require("x")

x.install_tools({ "java-debug-adapter", "java-test" })
x.install_plugins({ "mfussenegger/nvim-jdtls" })
-- api.setup_formatters({ command = "google_java_format" })
x.install_parsers({ "java" })
