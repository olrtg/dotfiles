--
-- Mason
--
vim.list_extend(require("user.utils.states").mason_ensure_installed, { "prettierd" })

--
-- prettierd
--
local utils = require("user.utils.functions")

local project_has_prettier_config = function()
  return (vim.fn.glob("{.,}prettier*") ~= "" or utils.is_in_package_json("prettier"))
end

local formatters = require("lvim.lsp.null-ls.formatters")

if not project_has_prettier_config() then
  formatters.setup({
    {
      command = "prettierd",
      extra_args = { "--no-semi", "--single-quote", "--trailing-comma=all", "--arrow-parens=avoid" },
    },
  })

  return
end

formatters.setup({ { command = "prettierd" } })
