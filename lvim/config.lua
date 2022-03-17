-- General and builtins configs
require("options")

-- Plugin related configs
require("plugins")

-- LSP, Linters and Formatters configs
require("lsp")

-- Keymaps
require("keymaps")

function _G.P(v)
	print(vim.inspect(v))
	return v
end
