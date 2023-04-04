-- Podfile syntax highlight (useful for React Native)
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { pattern = "Podfile,*.podspec", command = "set filetype=ruby" }
)

-- Brewfile syntax highlight
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { pattern = "Brewfile,.Brewfile", command = "set filetype=ruby" }
)

-- Custom format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "cpp" then
      return
    end

    require("lvim.lsp.utils").format({ timeout_ms = 2000, filter = require("lvim.lsp.utils").format_filter })
  end,
})
