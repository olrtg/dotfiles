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
