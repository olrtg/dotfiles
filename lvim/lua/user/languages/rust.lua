local api = require("user.utils.api")

api.install_plugins({
  { "mrcjkb/rustaceanvim", version = "^3", ft = { "rust" } },
})

api.install_parsers({ "rust" })

api.override_servers({ "rust_analyzer" })
