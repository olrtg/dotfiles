local api = require("user.utils.api")
local utils = require("user.utils.functions")

api.install_tools({ "eslint_d" })

local project_has_eslint_config = function()
  if utils.is_dependency_in_package_json("eslint") then
    return true
  end

  local filenames = {
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
  }

  for _, v in pairs(filenames) do
    if vim.fn.filereadable(vim.fn.getcwd() .. v) == 1 then
      return true
    end
  end

  return false
end

if not project_has_eslint_config() then
  return
end

--- @type string[]
local base_filetypes = require("null-ls").builtins.formatting.eslint_d["filetypes"]
local custom_filetypes = { "svelte" }

for _, v in pairs(base_filetypes) do
  table.insert(custom_filetypes, v)
end

api.setup_formatters({
  {
    command = "eslint_d",
    filetypes = custom_filetypes,
  },
})

api.setup_linters({
  {
    command = "eslint_d",
    filetypes = custom_filetypes,
  },
})

api.setup_code_actions({
  {
    command = "eslint_d",
    filetypes = custom_filetypes,
  },
})
