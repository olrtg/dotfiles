local api = require("user.utils.api")

api.install_plugins({
  {
    "ThePrimeagen/refactoring.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  },
})

--
-- persistence.nvim
--
api.setup_plugin("refactoring", nil, function(refactoring)
  api.setup_code_actions({
    { command = "refactoring" },
  })

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
end)
