--
-- Mason
--
vim.list_extend(require("user.utils.states").mason_ensure_installed, { "black", "flake8", "pyright" })

--
-- Treesitter
--
vim.list_extend(lvim.builtin.treesitter.ensure_installed, { "python" })

--
-- Formatters
--
local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup({
  { command = "black" },
})

--
-- Linters
--
local linters = require("lvim.lsp.null-ls.linters")

linters.setup({
  { command = "flake8" },
})
