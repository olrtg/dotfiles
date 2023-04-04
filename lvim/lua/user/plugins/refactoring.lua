--
-- Plugins
--
vim.list_extend(lvim.plugins, {
  {
    "ThePrimeagen/refactoring.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  },
})

--
-- persistence.nvim
--
local ok, refactoring = pcall(require, "refactoring")

if not ok then
  vim.notify("refactoring.nvim not found!", vim.log.levels.WARN)
  return
end

refactoring.setup({})

--
-- Code Actions
--
local code_actions = require("lvim.lsp.null-ls.code_actions")

code_actions.setup({
  { command = "refactoring" },
})

--
-- Keybindings
--
lvim.builtin.which_key.mappings["r"] = {
  name = "Refactor",
  ["p"] = {
    function()
      refactoring.debug.printf({})
    end,
    "Print Call",
  },
  ["v"] = {
    function()
      refactoring.debug.print_var({ normal = true })
    end,
    "Print Variable",
  },
  ["c"] = {
    function()
      refactoring.debug.cleanup({})
    end,
    "Remove prints",
  },
}

lvim.builtin.which_key.vmappings["r"] = {
  name = "Refactor",
  ["v"] = {
    function()
      refactoring.debug.print_var({})
    end,
    "Print Variable",
  },
}
