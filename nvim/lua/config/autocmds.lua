-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Podfile syntax highlight
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { pattern = "Podfile,*.podspec", command = "set filetype=ruby" }
)

-- Brewfile syntax highlight
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { pattern = "Brewfile,.Brewfile", command = "set filetype=ruby" }
)

-- Open help in vertical split
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("help_window_right", {}),
  pattern = { "*.txt" },
  callback = function()
    if vim.o.filetype == "help" then
      vim.cmd.wincmd("L")
    end
  end,
})
