--
-- Plugins
--
vim.list_extend(lvim.plugins, {
  { "WhoIsSethDaniel/mason-tool-installer.nvim" },
})

--
-- mason-tool-installer.nvim
--
local ok, mason_tool_installer = pcall(require, "mason-tool-installer")

if not ok then
  vim.notify("mason-tool-installer.nvim not found!", vim.log.levels.WARN)
  return
end

local tools = require("user.utils.states").mason_ensure_installed

mason_tool_installer.setup({ ensure_installed = tools })
