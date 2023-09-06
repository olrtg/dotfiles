local api = require("user.utils.api")
local utils = require("user.utils.functions")

api.install_tools({ "prettierd" })

local project_has_prettier_config = function()
  return (vim.fn.glob("{.,}prettier*") ~= "" or utils.is_in_package_json("prettier"))
end

local custom_filetypes =
  vim.tbl_extend("force", require("null-ls").builtins.formatting.prettierd["filetypes"], { "svelte" })

if not project_has_prettier_config() then
  api.setup_formatters({
    {
      command = "prettierd",
      filetypes = custom_filetypes,
      extra_args = { "--no-semi", "--single-quote", "--trailing-comma=all", "--arrow-parens=avoid" },
    },
  })

  return
end

api.setup_formatters({
  {
    command = "prettierd",
    filetypes = custom_filetypes,
  },
})
