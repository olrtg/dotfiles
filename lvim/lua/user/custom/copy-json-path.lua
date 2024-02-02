local M = {}

function M.exec()
  if vim.bo.filetype ~= "json" then
    vim.notify("Not json file", vim.log.levels.ERROR, { title = "copy-json-path" })
    return
  end

  local ok, navic = pcall(require, "nvim-navic")

  if not ok then
    vim.notify("nvim-navic not found", vim.log.levels.ERROR, { title = "copy-json-path" })
    return
  end

  local data = navic.get_data()

  local keys = {}

  for _, v in ipairs(data) do
    table.insert(keys, v.name)
  end

  local path = vim.fn.join(keys, ".")
  vim.fn.setreg("+", path)
end

return M
