-- NOTE: This is a config file for serialized/config languages like json/yaml/toml and others.

local x = require("x")

x.install_plugins({
	{ "fladson/vim-kitty" }, -- for kitty's config files
})

x.install_tools({ "json-lsp", "jsonlint", "taplo", "yaml-language-server" })

x.install_parsers({ "json", "toml", "yaml" })
