local api = require("user.utils.api")
local utils = require("user.utils.functions")

api.install_tools({ "prettierd" })

local project_has_prettier_config = function()
  if utils.is_dependency_in_package_json("prettier") then
    return true
  end

  local filenames = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    "prettier.config.js",
    ".prettierrc.cjs",
    "prettier.config.cjs",
    ".prettierrc.mjs",
    "prettier.config.mjs",
    ".prettierrc.toml",
  }

  for _, v in pairs(filenames) do
    if vim.fn.filereadable(vim.fn.getcwd() .. v) == 1 then
      return true
    end
  end

  return false
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
