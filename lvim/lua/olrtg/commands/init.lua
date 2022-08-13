-- Provide .env file for worktrees
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    local parent_env_exists = vim.fn.filereadable("./../.env") ~= 0
    local env_exists = vim.fn.filereadable("./.env") ~= 0

    if parent_env_exists and not env_exists then
      vim.api.nvim_command("!cp ./../.env ./.env")
      vim.notify("Found a parent .env file. Copied!", vim.lsp.log_levels.SUCCESS, { title = "Dotenv provisioning" })
    end
  end,
  desc = "Provide .env files",
})

-- Auto install dependencies
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    local deps_installed = vim.fn.isdirectory("node_modules") ~= 0

    if require("olrtg.utils").is_web_project() and not deps_installed then
      vim.api.nvim_command('TermExec cmd="ni" open=0')
      vim.notify("Installing dependencies")
    end
  end,
  desc = "Auto install node deps",
})
