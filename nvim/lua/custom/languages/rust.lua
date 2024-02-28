local api = require("custom.api")

api.install_plugins({
	{ "mrcjkb/rustaceanvim", version = "^3", ft = { "rust" } },
})

api.install_parsers({ "rust" })
