--
-- Plugins
--
vim.list_extend(lvim.plugins, {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
  },
})

--
-- persistence.nvim
--
local ok, persistence = pcall(require, "persistence")

if not ok then
  vim.notify("persistence.nvim not found!", vim.log.levels.WARN)
  return
end

persistence.setup()

--
-- Keybindings
--
lvim.builtin.which_key.mappings["S"] = { '<cmd>lua require("persistence").load()<cr>', "Last session" }
