--
-- Mason
--
vim.list_extend(require("user.utils.states").mason_ensure_installed, { "dockerfile-language-server", "hadolint" })

--
-- Treesitter
--
vim.list_extend(lvim.builtin.treesitter.ensure_installed, { "dockerfile" })

--
-- Linters
--
local linters = require("lvim.lsp.null-ls.linters")

linters.setup({
  { command = "hadolint" },
})
