--
-- Mason
--
vim.list_extend(require("user.utils.states").mason_ensure_installed, { "markdownlint", "proselint" })

--
-- Treesitter
--
vim.list_extend(lvim.builtin.treesitter.ensure_installed, { "markdown" })

--
-- Plugins
--
vim.list_extend(lvim.plugins, {
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
})

--
-- Linters
--
local linters = require("lvim.lsp.null-ls.linters")

linters.setup({
  {
    command = "markdownlint",
    extra_args = {
      "--disable",
      -- https://github.com/markdownlint/markdownlint/blob/main/docs/RULES.md#md013---line-length
      "MD013",
      -- https://github.com/markdownlint/markdownlint/blob/main/docs/RULES.md#md041---first-line-in-file-should-be-a-top-level-header
      "MD041",
    },
  },
  { command = "proselint" },
})

--
-- Code Actions
--
local code_actions = require("lvim.lsp.null-ls.code_actions")

code_actions.setup({
  { command = "proselint" },
})

--
-- Keybindings
--
lvim.builtin.which_key.vmappings["m"] = {
  name = "Markdown",
  b = { 'c**<C-r>"**<esc>', "Bold" },
  c = { 'c```<cr><C-r>"```<esc>', "Code Block" },
  e = { 'c`<C-r>"`<esc>', "Inline Code" },
  i = { 'c_<C-r>"_<esc>', "Italic" },
  s = { 'c~<C-r>"~<esc>', "Strike-through" },
}
