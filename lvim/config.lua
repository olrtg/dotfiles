-- General and builtins configs
require("olrtg.options")

-- Plugin related configs
require("olrtg.plugins")

-- Commands
require("olrtg.commands")

-- LSP, Linters and Formatters configs
require("olrtg.lsp")

-- Keymaps
require("olrtg.keymaps")

function _G.P(v)
  print(vim.inspect(v))
  return v
end
