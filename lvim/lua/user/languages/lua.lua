--
-- Mason
--
vim.list_extend(require("user.utils.states").mason_ensure_installed, { "lua-language-server", "stylua" })

--
-- Treesitter
--
vim.list_extend(lvim.builtin.treesitter.ensure_installed, { "lua" })

--
-- Formatters
--
local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup({ { command = "stylua" } })
