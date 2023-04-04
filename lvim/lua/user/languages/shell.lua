--
-- Mason
--
vim.list_extend(require("user.utils.states").mason_ensure_installed, { "bash-language-server", "shellcheck", "shfmt" })

--
-- Treesitter
--
vim.list_extend(lvim.builtin.treesitter.ensure_installed, { "bash" })

--
-- Formatters
--
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "shfmt" },
})

--
-- Linters
--
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { command = "shellcheck" },
})

--
-- Code Actions
--
local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
  { command = "shellcheck" },
})
