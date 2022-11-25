vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { pattern = "Podfile,*.podspec", command = "set filetype=ruby" }
)
