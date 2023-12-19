local M = {}

local g = {
  --- @param specifiers string
  --- @return string
  import = function(specifiers)
    return string.format("import %s from '@mui/material'", specifiers)
  end,

  --- @param specifiers string[]
  --- @return string
  specifiers = function(specifiers)
    return "{ " .. vim.fn.join(specifiers, ", ") .. " }"
  end,

  --- @param name string
  --- @param alias? string
  --- @return string
  specifier = function(name, alias)
    if alias then
      return string.format("%s as %s", name, alias)
    end
    return name
  end,
}

M.exec = function()
  local query_string = [[
    ;; query
    (import_statement
      (import_clause (identifier) @imported)
      source: (string
        (string_fragment) @source (#match? @source "mui/material/"))) @import
  ]]

  local parser = vim.treesitter.get_parser(0, "typescript")
  local ok, query = pcall(vim.treesitter.query.parse, parser:lang(), query_string)

  if not ok then
    return
  end

  local tree = parser:parse()[1]
  local bufnr = 0
  local start = 0
  local stop = -1

  --- @type table[]
  local import_ranges = {}
  ---
  --- @type string[]
  local import_default_specifiers = {}

  --- @type string[]
  local import_specifiers = {}

  for _, match, _ in query:iter_matches(tree:root(), bufnr, start, stop) do
    for id, node in pairs(match) do
      local name = query.captures[id]

      if name == "imported" then
        local value = vim.treesitter.get_node_text(node, bufnr)
        table.insert(import_default_specifiers, value)
      end

      if name == "source" then
        local value = vim.treesitter.get_node_text(node, bufnr)
        local segments = vim.split(value, "/")
        table.insert(import_specifiers, segments[#segments])
      end

      if name == "import" then
        local start_row, _, end_row, _ = vim.treesitter.get_node_range(node)
        table.insert(import_ranges, { start_row = start_row, end_row = end_row })
      end
    end
  end

  --- @types table[]
  local ranges_to_delete = {}

  local curr_range = { start_row = import_ranges[1].start_row, end_row = import_ranges[1].end_row }

  for index = 2, #import_ranges do
    if curr_range.end_row + 1 == import_ranges[index].start_row then
      curr_range.end_row = import_ranges[index].end_row
    else
      table.insert(ranges_to_delete, curr_range)
      curr_range = { start_row = import_ranges[index].start_row, end_row = import_ranges[index].end_row }
    end
  end

  table.insert(ranges_to_delete, curr_range)

  for index, range in ipairs(ranges_to_delete) do
    local replacement = {}

    if index == 1 then
      local specifiers = {}
      for i, specifier in pairs(import_specifiers) do
        local alias = import_default_specifiers[i] ~= specifier and import_default_specifiers[i] or nil
        table.insert(specifiers, g.specifier(specifier, alias))
      end

      replacement = { g.import(g.specifiers(specifiers)) }
    end

    vim.api.nvim_buf_set_lines(bufnr, range.start_row, range.end_row + 1, true, replacement)
  end
end

return M
