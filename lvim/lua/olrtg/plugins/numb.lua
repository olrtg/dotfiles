local M = {}

M.config = function()
  local status_ok, numb = pcall(require, "numb")

  if not status_ok then
    return
  end

  -- https://github.com/nacro90/numb.nvim#options
  local options = {
    show_numbers = true,
    show_cursorline = true,
  }

  numb.setup(options)
end

return M
