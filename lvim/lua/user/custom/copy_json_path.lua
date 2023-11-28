local M = {}

--- Copies the path of a JSON object to the clipboard
M.exec = function()
  local node = vim.treesitter.get_node()

  if not node then
    return
  end

  vim.print(node:parent():type())
end

return M
