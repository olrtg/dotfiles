-- NOTE: This is a config file for serialized/config languages like json/yaml/toml and others.

--
-- Plugins
--
vim.list_extend(lvim.plugins, {
  { "fladson/vim-kitty" }, -- for kitty's config files
})

--
-- Mason
--
vim.list_extend(
  require("user.utils.states").mason_ensure_installed,
  { "editorconfig-checker", "json-lsp", "jsonlint", "taplo", "yaml-language-server" }
)

--
-- Treesitter
--
vim.list_extend(lvim.builtin.treesitter.ensure_installed, { "json", "toml", "yaml" })
