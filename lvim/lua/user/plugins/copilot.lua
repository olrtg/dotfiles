--
-- Plugins
--
vim.list_extend(lvim.plugins, {
  { "zbirenbaum/copilot.lua", cmd = "Copilot", build = ":Copilot auth" },
})

--
-- copilot.lua
--
local ok, copilot = pcall(require, "copilot")

if not ok then
  vim.notify("copilot.lua not found!", vim.log.levels.WARN)
  return
end

copilot.setup({
  plugin_manager_path = os.getenv("LUNARVIM_RUNTIME_DIR") .. "/site/pack/packer",
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = "<M-Enter>",
      accept_line = "<M-l>",
      accept_word = "<M-w>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<M-c>",
    },
  },
})
