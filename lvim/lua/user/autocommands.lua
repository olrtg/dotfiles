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

-- Provide .env file for worktrees
vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  pattern = "*",
  callback = function()
    local parent_env_exists = vim.fn.filereadable("./../.env") ~= 0
    local env_exists = vim.fn.filereadable("./.env") ~= 0

    if parent_env_exists and not env_exists then
      vim.uv.fs_copyfile("./../.env", "./.env")
      print("Found a parent .env file. Copied!")
    end
  end,
  desc = "Provide .env files",
})
