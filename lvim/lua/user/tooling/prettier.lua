local api = require("user.utils.api")
local utils = require("user.utils.functions")

api.install_tools({ "prettier" })

local project_has_prettier_config = function()
  return (vim.fn.glob("{.,}prettier*") ~= "" or utils.is_in_package_json("prettier"))
end

--- @type string[]
local base_filetypes = require("null-ls").builtins.formatting.prettierd["filetypes"]
local custom_filetypes = { "astro", "svelte" }

for _, v in pairs(base_filetypes) do
  table.insert(custom_filetypes, v)
end

if not project_has_prettier_config() then
  api.setup_formatters({
    {
      command = "prettier",
      filetypes = custom_filetypes,
      extra_args = { "--no-semi", "--single-quote", "--trailing-comma=all", "--arrow-parens=avoid" },
    },
  })

  return
end

api.setup_formatters({
  {
    command = "prettier",
    filetypes = custom_filetypes,
  },
})
