--
-- Mason
--
vim.list_extend(require("user.utils.states").mason_ensure_installed, { "eslint_d" })

--
-- eslint_d
--
local utils = require("user.utils.functions")

local project_has_eslint_config = function()
  return (vim.fn.glob(".eslintrc*") ~= "" or utils.is_in_package_json("eslint"))
end

if not project_has_eslint_config() then
  return
end

local formatters = require("lvim.lsp.null-ls.formatters")
local linters = require("lvim.lsp.null-ls.linters")
local code_actions = require("lvim.lsp.null-ls.code_actions")

formatters.setup({ { command = "eslint_d" } })
linters.setup({ { command = "eslint_d" } })
code_actions.setup({ { command = "eslint_d" } })
