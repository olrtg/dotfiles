local M = {}

M.config = function()
  local status_ok, harpoon = pcall(require, "harpoon")

  if not status_ok then
    return
  end

  -- https://github.com/ThePrimeagen/git-worktree.nvim#options
  local options = {
    global_settings = {
      save_on_toggle = true,
      save_on_change = true,
      enter_on_sendcmd = false,
      tmux_autoclose_windows = false,
      excluded_filetypes = { "harpoon", "nvim-tree", "dashboard" },
    },
  }

  harpoon.setup(options)
end

return M
