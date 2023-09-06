local api = require("user.utils.api")
local utils = require("user.utils.functions")

api.install_tools({ "eslint_d" })

local project_has_eslint_config = function()
  return (vim.fn.glob(".eslintrc*") ~= "" or utils.is_in_package_json("eslint"))
end

if not project_has_eslint_config() then
  return
end

local custom_filetypes =
  vim.tbl_extend("force", require("null-ls").builtins.formatting.eslint_d["filetypes"], { "svelte" })

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
