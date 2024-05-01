-- NOTE: This is a config file for serialized/config languages like json/yaml/toml and others.

local api = require("user.utils.api")

api.install_plugins({
  { "fladson/vim-kitty" }, -- for kitty's config files
})

api.install_tools({ "json-lsp", "jsonlint", "taplo", "yaml-language-server" })

api.install_parsers({ "json", "toml", "yaml" })

require("lvim.lsp.manager").setup("taplo")
