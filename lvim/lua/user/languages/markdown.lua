local api = require("user.utils.api")

api.install_tools({ "markdownlint", "mdx-analyzer" })

api.install_parsers({ "markdown" })

api.install_plugins({
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
})

api.setup_linters({
  {
    command = "markdownlint",
    extra_args = {
      "--disable",
      -- https://github.com/markdownlint/markdownlint/blob/main/docs/RULES.md#md013---line-length
      "MD013",
      -- https://github.com/markdownlint/markdownlint/blob/main/docs/RULES.md#md033---inline-html
      "MD033",
      -- https://github.com/markdownlint/markdownlint/blob/main/docs/RULES.md#md041---first-line-in-file-should-be-a-top-level-header
      "MD041",
    },
  },
})

lvim.builtin.which_key.vmappings["m"] = {
  name = "Markdown",
  b = { 'c**<C-r>"**<esc>', "Bold" },
  c = { 'c```<cr><C-r>"```<esc>', "Code Block" },
  e = { 'c`<C-r>"`<esc>', "Inline Code" },
  i = { 'c_<C-r>"_<esc>', "Italic" },
  k = { 'c[<C-r>"]()<esc>', "Link" },
  s = { 'c~<C-r>"~<esc>', "Strike-through" },
}

---
--- MDX
---
vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
})

require("lvim.lsp.manager").setup("mdx_analyzer")
