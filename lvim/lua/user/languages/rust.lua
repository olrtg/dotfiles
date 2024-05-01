local api = require("user.utils.api")

api.install_plugins({
  { "mrcjkb/rustaceanvim", version = "^4", lazy = false },
  { "saecki/crates.nvim", event = { "BufRead Cargo.toml" }, config = true },
})

api.install_parsers({ "rust" })

api.override_servers({ "rust_analyzer" })
