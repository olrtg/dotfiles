local api = require("user.utils.api")

api.install_plugins({
  { "simrat39/rust-tools.nvim" },
})

api.install_parsers({ "rust" })

api.override_servers({ "rust_analyzer" })
